# Fix the Mint with One Multiplication

Lesson 8 left you with a token that holds `1000` raw base units — which a wallet renders as `0.000000000000001000 WCR`, a speck. Today you fix it with a single multiplication, redeploy, and read the balance in **both** languages the blockchain speaks: base units (what's stored) and human WCR (what's shown). Open `act_1.sol` and work the TODO.

## Task 1: See the Bug One Last Time

Before fixing, deploy the naive version — `_mint(msg.sender, 1000);` — on **Remix VM (Cancun)**. Click **`balanceOf`**, paste the first VM account `0x5B38Da6a701c568545dCfcB03FcB875f56beddC4`, and read `1000`. That's one thousand *base units*; divide by `10 ** 18` and it's `0.000000000000001000 WCR`. Name the value out loud before you change any code — you're fixing a *unit*, not a broken contract.

## Task 2: Multiply Into Base Units

Change the mint amount from `1000` to `1000 * 10 ** decimals()`. `decimals()` is the inherited metadata function that returns `18`, so `10 ** decimals()` is `10 ** 18` — the number of base units in one whole WCR. Multiplying by it converts "1,000 whole credits" into the base-unit integer the contract actually stores. Do **not** hand-type eighteen zeros; let the contract compute them, or you'll mean 1,000 and hand out something else.

## Task 3: Redeploy and Read the Base Units

Recompile (green check — you only changed a number) and redeploy. Click **`decimals`** and confirm `18` — the display instruction you never had to write. Click **`totalSupply`**: `1000000000000000000000`. Click **`balanceOf`** with the deployer address: the same `1000000000000000000000`. That long number is the truth on the ledger — 1,000 WCR expressed in base units.

## Task 4: Read It Back as a Human

Remix is a developer tool — it shows raw base units and does not apply decimals for you. Divide that long number by `10 ** 18` by hand and confirm it lands on a clean `1000`. That's exactly what a wallet or block explorer would render: **1,000 WCR**. Same balance on the ledger, two readings — base units for the chain, whole credits for the human.

## Sample Output

```text
-- naive version (Lesson 8) --
balanceOf(0x5B38...ddC4)  ->  1000
   1000 / 10^18  =  0.000000000000001000 WCR      // a speck

-- after the fix: _mint(msg.sender, 1000 * 10 ** decimals()) --
decimals()                ->  18
totalSupply()             ->  1000000000000000000000
balanceOf(0x5B38...ddC4)  ->  1000000000000000000000

   1000000000000000000000  base units      (what Remix shows)
 /            1000000000000000000  (10^18)
 = ---------------------------------------
                     1000  WCR              (what a wallet shows)
```

Same balance, two readings. Dan wasn't looking at a bug in Lesson 8 — he was reading the cash drawer instead of the price tag.

## Reflection Questions

1. `decimals()` returns `18`, yet the material insists it "changes nothing on-chain." If it does no math and stores no fractions, what *does* the number actually do, and who reads it?
2. Solidity refuses to store `0.5`. Given that refusal, how does the ecosystem still let someone hold half a credit — and why is forbidding floats a *feature* for a credit ledger, not a limitation?
3. You wrote `1000 * 10 ** decimals()` instead of pasting `1000` followed by eighteen zeros. Both produce the same number today. Why is the multiplication the safer habit even so?

## Challenge: Count in Centavos

**Challenge A — Mint a real 50.** After confirming `balanceOf(deployer)` reads `1000000000000000000000` (1,000 WCR), change the constructor to mint **50** whole credits instead — `50 * 10 ** decimals()` — redeploy, and read the new balance. Write one sentence stating the raw number you expect and the human WCR it represents, then confirm it in Remix.

**Challenge B — Conversions by hand, then reason about zero.** No Remix needed for the first two; use `base units = human × 10 ** 18`:
1. What is the base-unit value of **250 WCR**?
2. What is the base-unit value of **0.5 WCR** (half a credit) — and why is it still a whole integer of base units?
3. Imagine a workshop *graduation certificate* token, where 1 always means one whole certificate and half a certificate is meaningless. What would you set its `decimals()` to, what would that make its base unit, and in one sentence, why does WCR's answer differ?

## What You've Learned

- **`decimals()` is a display instruction, not a calculator** — it defaults to 18, changes nothing on-chain, and only tells wallets where to place the decimal point.
- **On-chain everything is an integer in base units** — `uint256`, no floats, because floats drift and drifting credits can't be trusted.
- **The formula is `base units = human amount × 10 ** decimals()`** — so 1,000 whole WCR is `1000 * 10 ** decimals()` = `1000000000000000000000`.
- **Let the contract compute the zeros** — `1000 * 10 ** decimals()` beats a hand-typed string of eighteen zeros every time; Remix shows raw base units, a wallet applies the decimals.
