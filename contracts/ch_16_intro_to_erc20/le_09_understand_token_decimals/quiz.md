# Lesson 9 Quiz: Understand Token Decimals

---
# Quiz 1
## Scenario: The 1,000 That Wasn't 1,000

Dan's `balanceOf` reads a clean `1000` and he goes to bed happy — until JM warns that a real wallet would render that same balance as `0.000000000000001000 WCR`. The culprit is a number Dan never set: `decimals`, defaulting to 18.

**Question 1:** What does `decimals()` actually do to a token's on-chain balances?
A. It divides every balance by 18 before storing it
B. Nothing on-chain — it's a display instruction telling wallets where to place the decimal point when showing balances to a human
C. It rounds balances to 18 significant figures
D. It multiplies `totalSupply` by `10 ** 18` automatically

**Answer:** B
**Explanation:** `decimals()` looks like it does math but does none. It returns 18 (OpenZeppelin's default) and changes nothing on-chain — it's a note for wallets and explorers about where to render the decimal point. On-chain, balances stay raw integers.

---

**Question 2:** Why does Solidity forbid floating-point numbers entirely?
A. Floats are too slow to compute on a blockchain
B. Floats drift (`0.1 + 0.2 ≠ 0.3`), and drifting credits couldn't be trusted — so the ecosystem stores big integers in a tiny base unit instead
C. Solidity is too old to support decimals
D. Floats take up too much storage space

**Answer:** B
**Explanation:** Floats are binary approximations that drift — harmless for a graph, catastrophic for money. So Solidity uses only `uint256` integers, and the ecosystem counts in base units, keeping `decimals` as a separate display number. It's the same whole-number trick Dan used for peso kita in Rust.

---

**Question 3:** WCR has 18 decimals. How many base units make up **one whole WCR**?
A. 18
B. 100
C. `10 ** 18` (a one followed by eighteen zeros)
D. `10 ** 2`

**Answer:** C
**Explanation:** With 18 decimals, one whole WCR splits into `10 ** 18` base units — just like a peso (2 decimals) splits into `10 ** 2` = 100 centavos. Same idea, more zeros.

---

# Quiz 2
## Scenario: One Multiplication Fixes Everything

JM's fix is a single change to the `_mint` line. Dan applies it, redeploys, and reads the balance in both languages the chain speaks: base units and human WCR.

**Question 4:** To mint **1,000 whole WCR**, what should the constructor call?
A. `_mint(msg.sender, 1000);`
B. `_mint(msg.sender, 1000 * 10 ** decimals());`
C. `_mint(msg.sender, 1000 / 10 ** decimals());`
D. `_mint(msg.sender, 1000.0);`

**Answer:** B
**Explanation:** `base units = human amount × 10 ** decimals()`. So 1,000 whole credits is `1000 * 10 ** decimals()` = `1000000000000000000000` base units. The naive `1000` was a speck; dividing would be even smaller; and `1000.0` won't compile because Solidity has no floats.

---

**Question 5:** Why write `1000 * 10 ** decimals()` instead of typing `1000` followed by eighteen zeros?
A. The multiplication is faster at runtime
B. Hand-typing eighteen zeros is error-prone — miscount by one and you mint ten times too many or too few; letting the contract compute the zeros can't miscount
C. Solidity rejects any literal longer than ten digits
D. `decimals()` must be called or the mint reverts

**Answer:** B
**Explanation:** Let the contract compute the zeros. A hand-typed string of zeros is exactly how you mean 100 WCR and hand out 10,000. `10 ** decimals()` always matches the token's real decimals, with no miscount.

---

**Question 6:** After the fix, Remix shows `totalSupply` as `1000000000000000000000`. What would a wallet display to a student?
A. `1000000000000000000000 WCR`
B. `1,000 WCR` — the wallet applies the 18 decimals, dividing the raw base units by `10 ** 18`
C. `0.000000000000001000 WCR`
D. `18 WCR`

**Answer:** B
**Explanation:** Remix is a developer tool that shows raw base units. A wallet applies `decimals()` and divides by `10 ** 18`, rendering `1000000000000000000000` base units as `1,000 WCR`. Same balance, two readings.

---
**Next:** Proceed to Lesson 9 exercises.
