# Break a Transfer on Purpose

The happy path is easy — you already watched a good transfer succeed. This activity does the opposite: you'll deliberately attempt an *impossible* transfer and read the revert the ledger throws back, field by field. You'll meet OpenZeppelin's inherited custom error first, then add a friendly guard of your own and compare the two. Open `act_1.sol` and work the TODO.

## Task 1: Add the Friendly Guard

Fill in `sendExactly(address to, uint256 amount)`:

1. `require(balanceOf(msg.sender) >= amount, "WCR: not enough credits");` — a human-readable pre-check.
2. `transfer(to, amount);` — do the move.

This is a courtesy layer. The important thing to internalize: even if you skipped step 1, `transfer` would *still* refuse an overspend on its own, using OpenZeppelin's inherited check. You're just adding an earlier, friendlier message.

## Task 2: Deploy and Set the Scene

Compile (Ctrl+S) and, on **Remix VM (Cancun)** with the **instructor** account (first in the dropdown), click **Deploy** — that mints 1,000 WCR to the instructor. Now give Kevin exactly 100: call the plain `transfer` with `to` = Kevin's address `0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2` and `amount` = `100000000000000000000`. Confirm with `balanceOf(Kevin)` → `100000000000000000000`.

## Task 3: Trigger the Inherited Revert

Switch the account dropdown to **Kevin's account** (the one holding 100 WCR). Find the orange **`transfer`** button, enter a *third* account as `to`, and the amount **`1000000000000000000000`** — that's `1000 * 10**18`, one thousand WCR. Kevin has one hundred. Click **transact** and watch the terminal turn red. This is the inherited `ERC20InsufficientBalance` custom error — no code of yours involved.

## Task 4: Prove Nothing Moved

Re-read the balances. `balanceOf(Kevin)` is still `100000000000000000000`, the recipient is still `0`, and `totalSupply()` is unchanged. The revert rolled everything back to the exact pre-transaction state — atomic, all-or-nothing. Notice too that **no `Transfer` event fired**: because the internal "emit" step never ran, there's no log entry and nothing for an explorer to show. A refused transfer leaves no false trail.

## Task 5: Compare Your Friendly Guard

Still on Kevin's account, call **`sendExactly`** with the same too-large amount `1000000000000000000000`. It also reverts — but this time on *your* `require` message, `"WCR: not enough credits"`, one step before OZ's check. Read both outputs and notice the difference: your string is friendlier for a beginner; OZ's custom error carries the exact numbers. Same protection, two voices.

## Sample Output

The inherited custom error from Task 3 (Kevin, holding 100, trying to send 1,000):

```text
transact to WorkshopCredit.transfer errored: Error occurred: revert.

revert
	The transaction has been reverted to the initial state.
Error provided by the contract:
ERC20InsufficientBalance
Parameters:
{
 "sender": {
  "value": "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2"
 },
 "balance": {
  "value": "100000000000000000000"
 },
 "needed": {
  "value": "1000000000000000000000"
 }
}
Debug the transaction to get more information.
```

Read it like the receipt it is — three fields, matching `ERC20InsufficientBalance(address sender, uint256 balance, uint256 needed)`:

```text
sender  -> 0xAb84...5cb2   Kevin's account — the one who tried
balance -> 100000000000000000000    what Kevin actually had (100 * 10**18 = 100 WCR)
needed  -> 1000000000000000000000   what the transfer required (1000 * 10**18 = 1,000 WCR)
```

Proving nothing moved (Task 4):

```text
balanceOf(Kevin)     -> 100000000000000000000   (still 100 WCR — untouched)
balanceOf(recipient) -> 0                        (still 0 — never received)
totalSupply()        -> 1000000000000000000000   (still 1,000 WCR — unchanged)
```

Your friendly guard from Task 5, for contrast:

```text
transact to WorkshopCredit.sendExactly errored: Error occurred: revert.
Error provided by the contract:
WCR: not enough credits
```

## Reflection Questions

1. Both the inherited `ERC20InsufficientBalance` and your `"WCR: not enough credits"` stop the same bad transfer. What does the custom error give you that the string message doesn't — and in what situation would that extra information actually matter?
2. After the failed transfer, `balanceOf(Kevin)` still reads exactly 100 and no `Transfer` event was logged. Explain, using the word *atomic*, why those two facts are really the same fact.
3. JM compared the revert to GCash refusing a payment you can't afford, and to Rust's compiler refusing to build a bug. Both refuse. Name the one real cost of the on-chain refusal that the Rust compiler's refusal does *not* have, and why it exists.

## Challenge: Read the Refusal

**Challenge A — Reproduce the revert and name the honest field.** From an account holding 100 WCR, attempt to `transfer` `1000000000000000000000` (1,000 WCR) to any address. When it reverts, copy down the `sender`, `balance`, and `needed` values from the `ERC20InsufficientBalance` output. Then argue, in one or two sentences: which of the three fields is the one that would convince Tita Malou no fraud occurred — that the student simply didn't have enough — and why that field, not the others?

**Challenge B — Predict a *different* revert: sending into a black hole.** OpenZeppelin v5 guards more than the balance. Try to `transfer` a *valid* amount (say `10000000000000000000`, 10 WCR, from an account that has it) but set the recipient to the **zero address** `0x0000000000000000000000000000000000000000`. Before you run it, write down which custom error you predict will fire and what its one parameter will be. Then run it, read the output, and check your prediction against what the contract actually returned.

## What You've Learned

- **A revert is a clean refusal, not a crash** — the token rewinds to the exact state before the transaction, so the ledger is never left half-finished or lying.
- **Reverts are atomic**: all-or-nothing, no half-transfers; a failed step means every earlier step is undone too, which is why no `Transfer` event fires on a refusal.
- **The balance check is inherited** — OpenZeppelin's `transfer` reverts with the v5 custom error `ERC20InsufficientBalance(sender, balance, needed)`, carrying the real numbers, and a friendly `require` on top is optional sugar.
- **A revert costs gas but never state** — you pay a small toll for the work up to the failure, but the balances the transaction tried to corrupt stay exactly as they were.
