# Play the Store: Pull 30, Watch the Allowance Fall

Tonight you play **both** roles — first Kevin, the owner who approved, then the store, the spender who pulls. Open `act_1.sol` and finish `collectFrom`, deploy, stage the same 50 WCR allowance from Lessons 16-17, then reach into Kevin's balance and watch three numbers move. Finally, overreach on purpose and meet a brand-new revert. The token contract itself hasn't changed one character since Lesson 9 — `transferFrom`, `approve`, and `allowance` are all inherited; your only new code is one line.

## Task 1: Finish `collectFrom`

`collectFrom(address from, uint256 amount)` is the store's move, wrapped into a single call. Its body should forward to the inherited **`transferFrom`**, pulling `amount` **out of** `from` and **into** the caller (`msg.sender` — whoever is doing the collecting). Because the recipient is `msg.sender`, whichever account clicks the button is the one the credits land in — exactly how a store collects to itself. Compile with the green checkmark before deploying.

## Task 2: Rebuild the staged state

Deploy on **Remix VM (Cancun)** and reproduce the Lesson 16-17 setup so there is an allowance to spend:

1. With **Account 0** (`0x5B38...beddC4`, the instructor) selected, **Deploy**.
2. Still as the instructor, call `transfer` with `0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2` (Account 1 = **Kevin**) and `100000000000000000000` (100 WCR). Now Kevin holds 100 WCR.
3. Switch the **Account** dropdown to **Account 1 (Kevin)** and call `approve` with `0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db` (Account 2 = **the store**) and `50000000000000000000` (50 WCR).

Confirm with the blue buttons: `balanceOf(Kevin)` = 100 WCR, `balanceOf(store)` = 0, `allowance(Kevin, store)` = 50 WCR.

## Task 3: Become the store and pull 30

In the **Account** dropdown, select **Account 2** (`0x4B20...2C02db`). *This is the crucial step* — whoever is selected here is `msg.sender`, the spender doing the pull. Leave it on Kevin and you aren't testing anything.

Now call `collectFrom` with:

- `from`: `0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2`  (Kevin — the owner)
- `amount`: `30000000000000000000`  (30 WCR in base units)

The transaction mines green. Expand it in the terminal and read the decoded log: a single `Transfer`, `from` Kevin, `to` the store. Notice what's **absent** — no `Approval` event, even though the allowance just dropped.

## Task 4: Read the three numbers that moved

Click the blue buttons again and compare against Task 2's starting state. `balanceOf(Kevin)` fell by 30, `balanceOf(store)` rose by 30, and `allowance(Kevin, store)` fell from 50 to 20 — the store's remaining permission. `totalSupply` is unchanged; nothing was minted or burned. Three numbers moved from one call, and it only worked because Kevin approved first.

## Task 5: Overreach on purpose

Only 20 WCR of allowance remains. Keep Account 2 (the store) selected and call `collectFrom` again with the same `from` but `amount` = `30000000000000000000` — more than what's left. The ledger refuses cleanly, reverting with `ERC20InsufficientAllowance`. Re-read the balances: still 70 and 30, untouched. The allowance is checked *before* any credits move, so the whole transaction reverts to its initial state.

## Sample Output

```text
// Task 3 — store calls collectFrom(Kevin, 30 WCR); one decoded log:
status   true   Transaction mined and execution succeed
to       WorkshopCredit.collectFrom(address,uint256)
logs     1
[
  {
    "event": "Transfer",
    "args": {
      "from":  "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
      "to":    "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db",
      "value": "30000000000000000000"
    }
  }
]

// Task 4 — the three numbers that moved:
balanceOf(0xAb84...835cb2)      ->  70000000000000000000    (Kevin: 100 -> 70)
balanceOf(0x4B20...2C02db)      ->  30000000000000000000    (store: 0 -> 30)
allowance(0xAb84..., 0x4B20...) ->  20000000000000000000    (50 -> 20)
totalSupply()                   -> 1000000000000000000000   (unchanged)

// Task 5 — pull 30 with only 20 left:
transact to WorkshopCredit.collectFrom errored: Error occurred: revert.

Error provided by the contract:
    ERC20InsufficientAllowance
Parameters:
{
    "spender":   "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db",
    "allowance": "20000000000000000000",
    "needed":    "30000000000000000000"
}
```

## Reflection Questions

1. In `collectFrom`, the credits land with `msg.sender`, not a `to` argument. What does that design choice guarantee about *who* can pull to *whom* — and why is that exactly what a store wants?
2. The overreach in Task 5 reverted with `ERC20InsufficientAllowance`, and the balances were untouched afterward. What does the *order* of the internal checks (allowance before balance) have to do with the fact that no credits moved?
3. `transferFrom` dropped the allowance from 50 to 20, but no `Approval` event was emitted. If you were building a dashboard that shows each spender's remaining permission, how would you know the allowance changed?

## Challenge

**Challenge A — Spend the allowance down to zero.** You've pulled 30, leaving 20 WCR of allowance. As the store (Account 2), call `collectFrom(Kevin, 20000000000000000000)` — pull exactly what's left. Then read all three numbers and note what happens to `allowance(Kevin, store)`. Try one more pull of even 1 wei and record the revert. What would Kevin have to do before the store could pull again?

**Challenge B — Reason about the two edge cases.** Answer in your own words, then verify in Remix:
1. `transferFrom` checks the **allowance** *before* the **balance**. Suppose Kevin had only 10 WCR left but the store still had 40 WCR of allowance, and the store tried to pull 30 — which error fires, `ERC20InsufficientAllowance` or `ERC20InsufficientBalance`? Why?
2. OpenZeppelin decreases the allowance on every `transferFrom` — *except* when it was set to the maximum `uint256` ("unlimited"). Why special-case unlimited approvals and skip the subtraction? What does it save, and what does it cost in safety?

## What You've Learned

- **`collectFrom` wraps `transferFrom(from, msg.sender, amount)`** — the caller is the spender, the credits leave `from` and land with whoever collects.
- **One `transferFrom` moves three numbers:** `from`'s balance down, the recipient's up, the allowance down — while `totalSupply` stays put.
- **Overreaching the allowance reverts with `ERC20InsufficientAllowance(spender, allowance, needed)`**, checked before the balance, so a failed pull changes nothing.
- **This is the RewardStore's engine.** `credit.transferFrom(buyer, address(this), price)` is the same move — you just built it into the token by hand.
