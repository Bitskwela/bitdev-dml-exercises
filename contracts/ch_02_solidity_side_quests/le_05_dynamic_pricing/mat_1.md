# Side Quest 5: Dynamic Pricing for a Ride-Hailing App — On-Chain Math & Integer Division

![Dynamic Pricing](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_2/C2+5.0+-+COVER.png)

## Scene

After the devastating digital attacks by Hackana, many systems in San Juan began to rebuild. However, one of the most used services—JuanRide, the local ride-hailing app—was left broken. Hackana's last malware forced the ride pricing to remain static, causing chaos during rush hours and leaving drivers underpaid.

![Neri the Blockchain Defender](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_2/C2+5.1.png)

Neri, the elite software engineer from Pinaglabanan, must now restore trust and fairness in the system. She needs to implement a dynamic pricing model that adjusts the fare based on demand and time of day, ensuring both riders and drivers get fair value. It's a small piece of code—but it has massive impact for the everyday lives of Filipinos.

## Why this matters

Pricing logic is *value logic*. When a contract computes how much money changes hands, every rounding error, every overflow, every misplaced division is real pesos lost or unfairly charged. Neri can't ship "approximately right" — on a blockchain, the number the contract returns is the number a rider pays and a driver receives. There is no support hotline to fix a bad fare after the fact.

The twist that trips up almost every newcomer: **Solidity has no decimals and no floating-point numbers.** No `float`, no `double`, no `1.5`. Every arithmetic operation works on integers, and division *throws away* the remainder instead of rounding. If you write percentage math the way you'd write it in JavaScript or Python, you will silently lose money on every transaction. This lesson teaches you to do fare math that is exact, fair, and gas-efficient.

## 1. There are no floats — integer division truncates

In Solidity, `uint256` (and every other integer type) holds whole numbers only. Division always rounds **toward zero** — it keeps the integer part and discards the fractional remainder. It never rounds up, and it never rounds to nearest.

```solidity
uint256 a = 7 / 2;   // = 3,  NOT 3.5 (the .5 is dropped)
uint256 b = 99 / 100; // = 0,  the entire value is lost
uint256 c = 250 / 100; // = 2,  NOT 2.5
```

That `99 / 100 = 0` is the killer. Watch what happens to a 5% fee on a small fare if you divide too early:

```solidity
// WRONG: divide first, then multiply
uint256 fare = 19;
uint256 fee = fare / 100 * 5;  // (19 / 100) = 0, then 0 * 5 = 0  → fee is ZERO
```

The fee evaporated. The remainder was thrown away *before* it could contribute to the result.

## 2. The golden rule: multiply BEFORE you divide

Because division discards the remainder, you want to keep your numbers as large as possible for as long as possible — so you do all your multiplications first, and divide only once, at the very end.

```solidity
// CORRECT: multiply first, divide last
uint256 fare = 19;
uint256 fee = fare * 5 / 100;  // (19 * 5) = 95, then 95 / 100 = 0  → still 0 here,
                               // but precision is preserved for any fare ≥ 20
```

Compare the two orderings across a few fares to see the precision you reclaim:

| Fare | `fare / 100 * 5` (divide first) | `fare * 5 / 100` (multiply first) | True 5% |
|------|-------------------------------|-----------------------------------|---------|
| 19   | 0                             | 0                                 | 0.95    |
| 50   | 0                             | 2                                 | 2.5     |
| 199  | 5                             | 9                                 | 9.95    |
| 1000 | 50                            | 50                                | 50      |

Divide-first throws away accuracy on every value that isn't a clean multiple of 100. **Multiply-before-divide** keeps every peso it can. This single ordering rule is one of the most important habits in on-chain financial code.

> Rule of thumb: in any percentage or ratio calculation, write it as `value * numerator / denominator`, never `value / denominator * numerator`.

## 3. Modeling a percentage increase

JuanRide's fare has two multipliers stacked on top of the base price:

- **Demand factor** — a surge during peak hours or holidays. `demandFactor = 20` means **+20%**.
- **Time factor** — a second bump for late-night runs or heavy traffic. `timeFactor = 10` means **+10%**.

The clean, readable way to add a percentage is: compute the adjustment with multiply-before-divide, then add it back to the base.

```solidity
function calculatePrice(
    uint256 basePrice,
    uint256 demandFactor,   // percent, e.g. 20 == +20%
    uint256 timeFactor      // percent, e.g. 10 == +10%
) public pure returns (uint256) {
    // Apply demand surge on the base price
    uint256 demandAdjustment = (basePrice * demandFactor) / 100;
    uint256 tempPrice = basePrice + demandAdjustment;

    // Apply the time surge on top of the already-adjusted price
    uint256 timeAdjustment = (tempPrice * timeFactor) / 100;
    uint256 finalPrice = tempPrice + timeAdjustment;

    return finalPrice;
}
```

Trace it with `basePrice = 100`, `demandFactor = 20`, `timeFactor = 10`:

1. `demandAdjustment = 100 * 20 / 100 = 20` → `tempPrice = 120`
2. `timeAdjustment = 120 * 10 / 100 = 12` → `finalPrice = 132`

The two surges **compound**: the time factor applies to the *already surged* price, not the original base. That's `100 → 120 → 132`, which is also `100 * 120 * 110 / 10000 = 132`. Both forms agree because in this example the intermediate divisions land on whole numbers.

### Why `pure`?

`calculatePrice` reads no storage and writes none — it's a function of its inputs alone. Marking it `pure` documents that, lets the compiler optimize, and means anyone can call it for a quote without sending a transaction or paying gas. Use `pure` for math that touches no state, and `view` for math that only *reads* state.

## 4. Order of operations matters even for compounding

The contract applies demand first, then time. Because both are percentages of the running total, the order changes the intermediate values but, for clean inputs like these, lands on the same final number. Where ordering bites you is precision: doing each division on a *larger* running total (multiply-before-divide within each step) loses less than collapsing everything into one chain of small divisions.

If you ever need finer precision than whole pesos (say, centavos), the standard technique is to **scale up** by a fixed factor — work in `value * 100` so a "centavo" is representable as an integer — do all the math, then scale back down at the very end. This is exactly how ERC-20 tokens use 18 decimals: there is no `1.5` token, there is `1_500_000_000_000_000_000` of the smallest unit.

## Common mistakes to avoid

1. **Dividing before multiplying.** `price / 100 * factor` silently zeros out small values. Always `price * factor / 100`.
2. **Expecting decimals.** `7 / 2` is `3`, not `3.5`. There is no rounding to nearest — the remainder is discarded. If you need it, use `%` (modulo) to recover it explicitly.
3. **Assuming the result rounds up.** Integer division always rounds toward zero, which means fees and adjustments are always rounded *down*. If your business needs round-up (e.g. "always charge at least one unit"), add `(denominator - 1)` before dividing: `(a + 99) / 100` rounds a percentage up.
4. **Hard-coding `100` everywhere as a magic number.** For a real system, define a named constant like `uint256 constant PERCENT_DENOMINATOR = 100;` (or use basis points, `10_000`, for sub-percent precision) so the intent is obvious and consistent.
5. **Forgetting `pure`/`view`.** A pure pricing helper shouldn't cost gas to query. Mislabeling it as a normal function forces callers to send a transaction just to get a quote.
6. **Ignoring overflow on huge inputs.** Since Solidity 0.8.0, arithmetic reverts automatically on overflow (no more silent wraparound), so `basePrice * demandFactor` is safe by default. Don't reach for `unchecked` here just to save gas — the protection is the point.

## Gas & precision notes

- **Multiply-before-divide costs nothing extra** in gas versus divide-first, and it preserves precision. There is no tradeoff — it's strictly better.
- **Basis points (`/ 10_000`)** are the industry-standard way to express fractions of a percent on-chain (e.g. `250` = 2.5%). Reach for them when whole-percent granularity isn't enough.
- **Built-in overflow checks (0.8.0+)** add a tiny gas cost per operation but eliminate an entire category of exploits. Keep them.

## What's next

You now know how to do exact, fair math on-chain — the foundation for fees, interest, staking rewards, and token economics. In the next side quest you'll put this to work splitting real ETH: an **NFT royalty system** where a percentage of every sale must be carved out and paid to the original creator. The same multiply-before-divide discipline you learned today is what keeps that royalty cut honest.

## References

- Solidity docs — Types: integers and division semantics — https://docs.soliditylang.org/en/latest/types.html#integers
- Solidity docs — Arithmetic checks and `unchecked` (0.8.0+) — https://docs.soliditylang.org/en/latest/control-structures.html#checked-or-unchecked-arithmetic
- Solidity by Example — Fixed-point / precision patterns — https://solidity-by-example.org/

## Closing

Neri pushes the update and watches the JuanRide dashboard come alive. During the 6 PM crush in Pinaglabanan, fares lift smoothly with demand; at 1 AM, the late-night factor stacks fairly on top. Drivers see honest earnings, riders see honest prices, and not a single centavo disappears into a rounding crack. "Tama ang bawat piso," she murmurs — every peso accounted for. Hackana broke the system by freezing it; Neri fixed it with nothing more than careful integer math.
