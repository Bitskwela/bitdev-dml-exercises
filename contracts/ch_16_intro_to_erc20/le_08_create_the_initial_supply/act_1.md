# Mint the Ledger's First Line

Your Lesson 7 token knows its name and symbol but holds zero credits — `totalSupply` reads `0`, every balance empty. One line inside the constructor fixes that: it writes the ledger's very first entry. Open `act_1.sol` and work the TODO. This is not the *final* WCR yet — the amount you mint is deliberately naive, and reading it back reveals a weirdness that Lesson 9 exists to explain.

## Task 1: Write the First Line

Inside the constructor body, call `_mint(msg.sender, 1000)`. `_mint` is the internal helper inherited from OpenZeppelin's `ERC20`: it adds `1000` to the recipient's balance **and** raises `totalSupply` by the same `1000`, atomically. Because the constructor runs once at deploy, `msg.sender` here is the account that **deployed** the contract — you, the instructor. So this hands your deployer the entire starting pile the instant the token is born. Type `1000` plainly for now; it will look strange on read-back, and that is the point.

## Task 2: Compile and Deploy

Compile with solc `0.8.20` or higher (green check — same as Lesson 7). On **Deploy & Run**, environment **Remix VM (Cancun)**, note the **Account** at the top and copy it — that's your deployer. Hit the orange **Deploy**. Expand the deploy transaction in the terminal: notice `logs 1` — the ledger already recorded your mint as a "from nobody, to you" line (you will decode it in Lesson 14).

## Task 3: Read the Two Numbers

Click **`totalSupply`** — it now reads `1000`, where last lesson it read `0`. Then find **`balanceOf`**, paste your deployer address, and call it — also `1000`. They match for one reason: right now the deployer holds *every* credit that exists, so the sum-of-all-balances invariant collapses onto a single account. The moment Dan sends some to a student (Lesson 13), those two numbers part ways.

## Task 4: Read It as a Human Would

Remix shows you the raw on-chain integer. But WCR declares **18** decimals (OpenZeppelin's default). A real wallet slides the point 18 places left before display — so your `1000` becomes `1000 / 10^18`. Compute that by hand and sit with the result: it is not a thousand credits. Don't fix it yet. Lesson 9 is the whole answer.

## Sample Output

Deploy on the Remix VM, then read from the deployed panel (addresses shortened):

```text
-- deploy receipt (expand the green tx) --
status                true  Transaction mined and execution succeed
to                    WorkshopCredit.(constructor)
logs                  1                 // the mint: from 0x0 -> you

totalSupply()                 ->  1000
balanceOf(0x5B38...ddC4)      ->  1000   // your deployer holds it all
balanceOf(0xAb84...C2)        ->  0      // any other account: empty

-- read it as a wallet would --
raw balance:  1000
decimals:     18
displayed:    1000 / 10^18  =  0.000000000000001000 WCR
```

That last line — `0.000000000000001000 WCR` — is not a bug. Every number is internally consistent. The integer is right; the *unit* is wrong. Hold that thought.

## Reflection Questions

1. `_mint` raises both `balanceOf(you)` and `totalSupply` by the same amount. Why must those two numbers always move together — what would a ledger where they *didn't* actually be lying about?
2. `msg.sender` inside the constructor is the deployer, but `msg.sender` inside a `transfer` later is the caller. Same keyword, different account — why doesn't that dual meaning cause bugs?
3. It's `_mint` with an underscore, callable only from inside the contract, and today only from the constructor. Whose problem does that solve, and which later lesson (hint: ownership) decides who may mint *after* deployment?

## Challenge: Print the Pot, Read the Sliver

**Challenge A — Mint it and probe the invariant.** After confirming `totalSupply` and `balanceOf(deployer)` both read `1000`, switch the **Account** dropdown to a *different* Remix account, copy that address, and call `balanceOf` on it. Write one sentence explaining what it returns and why the deployer's balance equals the total supply right now.

**Challenge B — Predict the meaning of `1000`.** You know two facts: the raw balance is `1000`, and the token has `18` decimals. In your own words, one or two sentences: is `1000` raw base units equal to a full **1,000 WCR** or a tiny **fraction** of one credit? And if you wanted the balance to *display* as `1,000 WCR`, would the raw number need to be bigger or smaller than `1000`, and by roughly how much? (No peeking at Lesson 9 — just predict.)

## What You've Learned

- **`_mint(account, amount)` writes credits into existence** — raising that account's balance *and* `totalSupply` together, atomically, so the books always balance.
- **The constructor is the mint site** — it runs once at deploy, `msg.sender` is the deployer, so the first line hands the instructor the whole starting pile, paluwagan-style.
- **`_mint` is internal** — no button, no outside caller; today only the constructor invokes it, so credits are created exactly once.
- **Solidity counts in whole base units, not decimals** — `1000` raw on an 18-decimal token reads as `0.000000000000001000 WCR`. The number is right; the unit is the cliffhanger into Lesson 9.
