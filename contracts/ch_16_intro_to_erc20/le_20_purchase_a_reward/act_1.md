# Give the Store a Cashier (buyItem)

The store from Lesson 19 has a menu but no way to charge for it. Open `act_1.sol` — everything from last lesson is intact (`credit`, the `Item` struct, `items`, `addItem`, `itemCount`), plus a new `ItemPurchased` event. Your job is the one new function: `buyItem`. It runs on the exact `approve` → `transferFrom` machinery from Lessons 16-18 — only now the *spender* is the store contract itself.

## Task 1: Grab the Item and Guard the Door

At the top of `buyItem(uint256 id)`, load the item the buyer wants: take a **storage reference** to `items[id]` (a reference to the real stored struct, not a copy). Then `require` that the item's `active` flag is `true`, with the reason string `"RewardStore: item not available"`. If it isn't active, the whole transaction reverts before any credits move.

## Task 2: Pull the Payment with `transferFrom`

Call the token's `transferFrom` through the `credit` reference to pull the price out of the buyer and into the store:

- **from** = `msg.sender` (the student who called `buyItem`)
- **to** = `address(this)` (this store contract — where the WCR lands)
- **amount** = the item's `price`

From the token's point of view, the spender here is the **store's address**, so this only works if the buyer already called `approve(storeAddress, price)` on the token. If they didn't, the token reverts with `ERC20InsufficientAllowance` and nothing moves.

## Task 3: Log the Purchase

After the pull succeeds, `emit ItemPurchased` with the `id`, the buyer (`msg.sender`), and the item's `price`. One `buyItem` call now leaves *two* events in the log: the token's `Transfer` and your store's `ItemPurchased`.

## Sample Output

Two accounts: **Account 1** = Dan the instructor, **Account 2** (`0xAb84...5cb2`) = Kevin the student. Deploy `WorkshopCredit`, `transfer` Kevin 200 WCR, deploy `RewardStore` wired to the token, then `addItem("Turon", 100 * 10**18)`.

**The impatient way — buy WITHOUT approving.** As Kevin, call `buyItem(0)`. The token refuses cleanly:

```text
transact to RewardStore.buyItem errored: revert.
Reason: custom error ERC20InsufficientAllowance(address,uint256,uint256).
Parameters: {
 "spender":   "0xf8e81D47203A594245E36C48e151709F0C19fBe8",   // the STORE
 "allowance": "0",
 "needed":    "100000000000000000000"
}
```

Kevin never signed the note, so the store's `transferFrom` was rejected. Nothing moved.

**The right way — approve, then buy.** Still as Kevin, on the **WorkshopCredit** instance call `approve(storeAddress, 100000000000000000000)`, then on the **RewardStore** call `buyItem(0)`. It succeeds, and one call emits two events:

```text
[
  {
    "from": "0xd9145CCE52D386f254917e481eB44e9943F39138",   // the WCR token
    "event": "Transfer",
    "args": {
      "from":  "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2", // Kevin
      "to":    "0xf8e81D47203A594245E36C48e151709F0C19fBe8", // the store
      "value": "100000000000000000000"
    }
  },
  {
    "from": "0xf8e81D47203A594245E36C48e151709F0C19fBe8",   // the RewardStore
    "event": "ItemPurchased",
    "args": {
      "id":    "0",
      "buyer": "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2", // Kevin
      "price": "100000000000000000000"
    }
  }
]
```

Read the ledger before and after:

```text
Read call              | Before buy | After buy
-----------------------|-----------:|----------:
balanceOf(Kevin)       |   200 WCR  |  100 WCR
balanceOf(store)       |     0 WCR  |  100 WCR
allowance(Kevin,store) |   100 WCR  |    0 WCR
```

Kevin is down 100, the store is up 100, and the allowance is spent back to zero — so a second `buyItem(0)` without a fresh `approve` meets that same `ERC20InsufficientAllowance`. The whole exchange sits in the log for anyone to verify.

## Reflection Questions

1. Kevin has 200 WCR but `buyItem` still reverts before he approves. Whose address is the `spender` in the `ERC20InsufficientAllowance` error — and why is it that address, not Kevin's?
2. `buyItem` uses `credit.transferFrom(msg.sender, address(this), item.price)`. What would go wrong if you naively used `credit.transfer(address(this), item.price)` instead? (Hint: whose balance does `transfer` spend?)
3. After the purchase, the 100 WCR sits in the store contract. Is that a bug, or a not-yet? What later lesson removes those spent credits from circulation?

## Challenge: Run the Register

**Challenge A — The full happy path.** From a clean deploy, run the whole flow yourself: deploy WorkshopCredit, fund a student with 200 WCR, deploy RewardStore wired to the token, `addItem("Turon", 100 * 10**18)`, then — as the student — `approve` the store for 100 WCR and `buyItem(0)`. Confirm the student's balance dropped by 100, the store's rose by 100, and locate *both* the `Transfer` and `ItemPurchased` events in the transaction log.

**Challenge B — Trigger the refusal on purpose.** Call `buyItem(0)` from a student who has WCR but never called `approve`. Read the `ERC20InsufficientAllowance` error and write down its three fields (`spender`, `allowance`, `needed`). Then, in two or three sentences, explain to Tita Malou why it's a *good* thing the store cannot pull credits without permission — connect it to what would happen to every WCR holder if any contract could take tokens freely.

## What You've Learned

- **Paying a contract is a two-step handshake:** the buyer `approve`s, then the contract pulls with `transferFrom` — a contract can never take your tokens on its own.
- **When the store calls `transferFrom`, the store is the spender** — so the buyer must approve the store's *deployed address*, and `buyItem` pulls from `msg.sender` into `address(this)`.
- **`require(item.active, "...")` is your own guard** — true continues, false reverts the whole transaction with a reason string.
- **One `buyItem` call emits two events** — a `Transfer` from the token and an `ItemPurchased` from the store — and the store *holds* the collected WCR until burning arrives later.
