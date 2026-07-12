# Write the Note, Then Prove Nothing Moved

`approve` is inherited from OpenZeppelin and already audited — but you'll wrap it in one small helper, `approveStore`, so the intent reads in plain language: *let this store pull up to this many of my credits.* Then you'll play two people in Remix — **Kevin**, who owns credits, and the **RewardStore** stand-in he authorizes — grant 50 WCR, read the `Approval` event out of the log, and confirm the part that makes it click: Kevin's balance does **not** budge. Open `act_1.sol` and work the one TODO.

## Task 1: Implement `approveStore`

The contract already inherits `approve` from `ERC20`; your helper just forwards to it. In the body of `approveStore(address store, uint256 amount)`, return the result of calling `approve(store, amount)`. Because `approveStore` is called *by* the owner, `msg.sender` inside `approve` is that same owner — so the allowance recorded is *the caller's* credits, granted to `store`. No tokens move; a permission is written. Return the `bool` that `approve` hands back so a caller can check success.

## Task 2: Deploy and Give Kevin Something to Authorize

Open **https://remix.ethereum.org**, compile, and go to **Deploy & Run** with Environment set to **Remix VM (Cancun)**. We'll use the first three VM accounts as roles:

- Account **0** `0x5B38Da6a701c568545dCfcB03FcB875f56beddC4` — the **instructor** (deployer, holds the 1,000 WCR supply).
- Account **1** `0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2` — **Kevin**, the student.
- Account **2** `0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db` — the **RewardStore** stand-in (the spender).

With **account 0** selected, **Deploy**. Then, still on account 0, call `transfer` with `to = 0xAb84…835cb2` and `amount = 100000000000000000000` (100 WCR). Kevin now holds 100 WCR.

## Task 3: Record the "Before" Balances

Click the blue **`balanceOf`** for Kevin `0xAb84…835cb2` and for the store `0x4B20…C02db`. Write both numbers down — the whole point of this lesson is that they are *unchanged* at the end.

## Task 4: Become Kevin and Write the Note

In the account dropdown, switch to **account 1** (Kevin) — this makes Kevin the `msg.sender`, i.e. the *owner* granting permission. Find the orange **`approveStore`** button and fill it in:

- `store:` `0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db`
- `amount:` `50000000000000000000` (that's `50 * 10 ** 18` — fifty whole WCR in base units)

Click **transact**. Notice in the terminal that `from` is Kevin's address (he signed the note) and `to` is the WorkshopCredit contract — Kevin didn't send anything *to* the store; he told the *token* to remember a permission.

## Task 5: Read the `Approval` Event Out of the Log

Expand the transaction and open **logs**. Even though you called `approveStore`, the inherited `approve` fired the standard `Approval` event. Read it exactly like Tita Malou's notebook line: `owner` = Kevin (who granted), `spender` = the store (who may pull), `value` = the cap in base units.

## Task 6: The Payoff — Prove Nothing Moved

Call **`balanceOf`** again for both addresses. They must be *identical* to Task 3. Kevin granted permission to spend 50 credits and his balance did not drop by a single base unit. The store is *authorized* to hold 50 of Kevin's WCR someday, but holds none today — the difference between the note and the payment.

## Sample Output

```text
-- Task 3: before --
balanceOf(0xAb84...835cb2)  ->  0: uint256: 100000000000000000000   (Kevin: 100 WCR)
balanceOf(0x4B20...C02db)   ->  0: uint256: 0                        (Store: 0 WCR)

-- Task 4: Kevin calls approveStore(0x4B20...C02db, 50000000000000000000) --
status              0x1 Transaction mined and execution succeed
from                0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2   <-- Kevin: the owner/caller
to                  WorkshopCredit.approveStore(address,uint256) 0xd914...39138

-- Task 5: the Approval event in logs --
{
  "event": "Approval",
  "args": {
    "owner":   "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
    "spender": "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db",
    "value":   "50000000000000000000"
  }
}

-- Task 6: after (identical to before) --
balanceOf(0xAb84...835cb2)  ->  0: uint256: 100000000000000000000   (Kevin: STILL 100 WCR)
balanceOf(0x4B20...C02db)   ->  0: uint256: 0                        (Store: STILL 0 WCR)
```

## Reflection Questions

1. The transaction's `to` field is the WorkshopCredit contract, not the store — yet the store is the one being authorized. Explain in one sentence where the store's address actually appears, and why the store is *not* the recipient of this transaction.
2. `approveStore` runs, an `Approval` event fires, gas is spent — and yet both balances are byte-for-byte identical afterward. What, concretely, *did* change on-chain if no balance did?
3. If a stranger (account 2, the store) tried to call `approveStore` to authorize *itself* against Kevin's balance, whose credits would it actually be approving away, and why can't it touch Kevin's?

## Challenge: Grant It, Read It, Then Weigh the Risk

**Challenge A — Approve, then find the note in the log.** From Kevin's account, `approveStore` the store stand-in for **50 WCR** (`50000000000000000000`). Expand the transaction, open the logs, and locate the `Approval` event. Write down its three fields — `owner`, `spender`, `value`. Then call `balanceOf` on Kevin *before and after* and state whether the number changed.

**Challenge B — The unlimited allowance: convenience versus blast radius.** Some apps ask you to approve the maximum possible amount, `2**256 - 1` (`115792089237316195423570985008687907853269984665640564039457584007913129639935` base units — effectively infinite). In a few sentences, answer: (1) what is the *risk* of granting an unlimited allowance to a spender, and (2) why might a real app still ask for it anyway? Then state which default you'd choose for WCR's future RewardStore, and why.

## What You've Learned

- **`approve` (and your `approveStore` wrapper) grants permission without moving tokens** — the note, not the payment. Balances are unchanged after you approve.
- **The caller is the owner.** Inside `approveStore`, `msg.sender` is whoever clicked it, so you can only ever approve away *your own* credits — the whole security model in one rule.
- **Every successful approve emits `Approval(owner, spender, value)`** into the public log, both addresses indexed, readable by anyone forever.
- **Permission and payment are two separate acts** — `approve` today writes the note; `transferFrom` (Lesson 18) is the store actually pulling against it.
