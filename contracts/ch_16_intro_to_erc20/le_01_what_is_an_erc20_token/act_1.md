# Build the Barest Possible Token

Before OpenZeppelin, before the ERC-20 standard, before a single import — build the *idea* of a token in plain Solidity: a public ledger of who-holds-how-much. Open `act_1.sol` and work the TODOs in order. This is not the real WCR yet (no standard, no safety) — it's the one-sentence definition of a token, made concrete: `balanceOf` is the listahan, `award` adds a line, `transfer` moves credits between names.

## Task 1: The Ledger Itself

Declare a **public** state variable `mapping(address => uint256) balanceOf`. This single line IS the token — a list mapping each person (an `address`) to how many credits they hold. `public` means anyone can read any balance for free, which is the whole point: a notebook the barangay can read.

## Task 2: The Running Total

Declare a **public** `uint256 totalCredits`. This tracks how many credits exist across everyone — the sum of every balance. You'll keep it in step with `balanceOf` as credits are created.

## Task 3: `award` — Add a Line to the Ledger

Implement `award(address student, uint256 amount)`: add `amount` to `balanceOf[student]` and the same `amount` to `totalCredits`. This is Dan handing out credits for finished work. (Anyone can call it right now — real "only Dan can mint" access control is Lesson 21's job; today is about the ledger itself.)

## Task 4: `transfer` — Move Credits Between Names

Implement `transfer(address to, uint256 amount)`:

1. `require` that `balanceOf[msg.sender]` is at least `amount` (you can't spend what you don't have), with the message `"not enough credits"`.
2. Subtract `amount` from the caller's balance, then add it to `balanceOf[to]`.

`msg.sender` is whoever called the function — the built-in "who's holding the pen right now." Note `totalCredits` does **not** change here: a transfer moves credits, it doesn't create them.

## Sample Output

Deploy in Remix, then exercise it from the deployed panel (addresses shortened):

```text
award(0xAb...C2, 40)      // Dan awards Kevin 40 credits
balanceOf(0xAb...C2)  ->  40
totalCredits()        ->  40

transfer(0x5B...E4, 10)   // Kevin sends 10 to a classmate
balanceOf(0xAb...C2)  ->  30
balanceOf(0x5B...E4)  ->  10
totalCredits()        ->  40      // unchanged — a transfer creates nothing
```

Every number above is readable by anyone, and no line can be quietly changed — the exact property Dan's notebook never had.

## Reflection Questions

1. `balanceOf` is `public`. Who can read Kevin's balance — and why is that a feature here, not a privacy bug, for a workshop credits system?
2. `transfer` changes two balances but leaves `totalCredits` alone, while `award` changes a balance *and* `totalCredits`. Why the difference?
3. Right now *anyone* can call `award` and hand themselves a million credits. Which row of the "notebook vs. ledger" table does that break, and which later lesson (hint: ownership) fixes it?

## Challenge: Define Your Token

**Challenge A — The one-paragraph WCR use case.** In 4-6 sentences, write what a single WCR *represents*, how a student *earns* it, and how a student *spends* it. Be concrete and boring. Answer inside the paragraph: What does 1 WCR stand for? What earns credits? What can they buy? And one sentence for Tita Malou: why is this *not* a coin you buy, sell, or invest in?

**Challenge B — Three real fungible tokens in the wild.** Using a block explorer (e.g. `etherscan.io/tokens`), find three real ERC-20 tokens of different flavors: one **stablecoin**, one **loyalty/utility** token, and one **game/platform** currency. For each, write one line: name/symbol and what one unit is fungible *for*. End with a sentence naming which is the closest cousin to WCR, and why.

## What You've Learned

- A token, at its core, is a **public ledger of balances** — `balanceOf` is the whole idea, in one mapping.
- **`award`** creates credits (and moves `totalCredits`); **`transfer`** only moves existing credits between holders.
- **`msg.sender`** is the built-in caller — Solidity's "who's holding the pen."
- This hand-rolled ledger has no standard and no real safety yet. Lessons 5-9 replace it with a real, audited ERC-20 — but the mental model never changes: **a token is a ledger.**
