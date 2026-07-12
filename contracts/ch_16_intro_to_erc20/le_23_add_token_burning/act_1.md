# Teach the Token to Burn, Then Watch the Supply Fall

Two small edits finish the whole system. Open `act_1.sol` — it's the Lesson 22 token, complete and untouched except for two empty functions at the bottom. Fill them in, then deploy it alongside the provided `RewardStore.sol` (already wired to burn on every redemption) and watch `totalSupply` drop from 1,200 to 1,100 the instant Kevin claims his turon. The token compiles as shipped, but `burn` and `burnFrom` do nothing until you give them a body.

## Task 1: Finish `burn`

`burn(uint256 amount)` destroys the **caller's own** credits — the mirror of `transfer`. In its body, call the inherited internal helper `_burn` on `msg.sender` for `amount`. That single line lowers `msg.sender`'s balance **and** decreases `totalSupply`, and it emits `Transfer(msg.sender, 0x0, amount)` — a credit walking out the zero-address door. Notice there is no `onlyOwner` here: burning your own credits is always allowed, because they're yours to destroy.

## Task 2: Finish `burnFrom`

`burnFrom(address account, uint256 amount)` destroys **someone else's** credits, but only up to an allowance they granted you — the mirror of `transferFrom`. Two internal calls, in order:

1. `_spendAllowance(account, _msgSender(), amount)` — check the caller's allowance from `account` and deduct it. This reverts with `ERC20InsufficientAllowance` if the caller wasn't approved for at least `amount`.
2. `_burn(account, amount)` — then destroy the credits.

Order matters: the allowance is checked and spent *before* anything burns, so a short allowance reverts the whole call and nothing changes. Compile with the green checkmark before deploying.

## Task 3: Deploy both contracts

On **Remix VM (Cancun)**, compile both `act_1.sol` and `RewardStore.sol` (green check on each), then:

1. Deploy **WorkshopCredit** from the instructor account (Account 0). Copy its address.
2. Deploy **RewardStore**, pasting the WorkshopCredit address into the `creditToken` field.
3. On the store, `addItem("Turon", 100000000000000000000)` — that's 100 WCR in base units (`100 * 10**18`).
4. Reward Kevin so he has something to spend. From the instructor account on the token, call `rewardStudent(<Kevin>, 200000000000000000000, "Finished final exercise")`.

## Task 4: Record `totalSupply` before any redemption

On the token, read `totalSupply`. The starting 1,000 plus Kevin's 200 gives **1,200 WCR** — write this number down. You're about to watch it fall.

## Task 5: Redeem, then read the burn in the logs

Switch the **Account** dropdown to **Kevin's account** and run the redemption:

1. On the **token**, `approve(<RewardStore address>, 100000000000000000000)` — Kevin lets the store pull 100 WCR.
2. On the **store**, `buyItem(0)`.

Expand the `buyItem` transaction in the terminal. Read the logs in order — pull, then burn, then the receipt. There are **two** `Transfer` events from one purchase: the pull *into* the store, then the burn *to* the zero address.

## Task 6: Read the three numbers that moved

Click the blue buttons and compare against Task 4. `balanceOf(Kevin)` fell by 100; `balanceOf(store)` is **0** (it pulled 100 in, then burned 100 out — net zero); and `totalSupply` dropped from 1,200 to **1,100**. The spent credit is gone. Anyone can now read `totalSupply` and know it means *credits still live in the workshop*, not *credits ever printed*.

## Sample Output

```text
// Task 4 — totalSupply BEFORE any redemption (1,000 start + Kevin's 200):
totalSupply() -> 1200000000000000000000

// Task 5 — buyItem(0) as Kevin; the decoded logs, in order:
logs:
  - WorkshopCredit.Transfer(
        from:  0xKevin...,
        to:    0xStore...,       // transferFrom: 100 WCR pulled into the store
        value: 100000000000000000000 )

  - WorkshopCredit.Transfer(
        from:  0xStore...,
        to:    0x0000000000000000000000000000000000000000,   // burn: 100 WCR out the zero-address door
        value: 100000000000000000000 )

  - RewardStore.ItemPurchased(
        id:    0,
        buyer: 0xKevin...,
        price: 100000000000000000000 )

// Task 6 — the numbers, read back:
balanceOf(Kevin) -> 100000000000000000000     // 200 -> 100 WCR (spent 100)
balanceOf(Store) -> 0                          // pulled 100 in, burned 100 out: net ZERO
totalSupply()    -> 1100000000000000000000     // 1200 -> 1100 WCR: the spent credit is GONE
```

## Reflection Questions

1. One `buyItem` call produced **two** `Transfer` events. What does each one represent, and why does the second one (to `0x0`) change `totalSupply` when a normal transfer between two accounts never does?
2. `burn` has no `onlyOwner` modifier, but `rewardStudent` does. Explain the asymmetry: why is *creating* credits the guarded power while *destroying your own* is always allowed?
3. After the redemption, `balanceOf(store)` is 0 even though it pulled 100 WCR in. Trace the two lines of `buyItem` and explain how the store's balance ends up net zero — and what would `totalSupply` do instead if you deleted the `credit.burn(item.price)` line?

## Challenge

**Challenge A — Watch the total fall twice.** Reward Kevin another 100 WCR if he's short, then run the full loop a **second** time: `approve(store, 100 WCR)` → `buyItem(0)`. *Before* you read it, predict the new `totalSupply` and the new `balanceOf(store)`. Then read both and confirm your prediction. Explain in one sentence why the store's balance never grows no matter how many turon are redeemed.

**Challenge B — Two stories about supply.** Suppose next year another workshop copies your store but *removes* the `credit.burn(item.price)` line, so the store keeps every redeemed credit. In 3-4 sentences, answer: after 500 turon redemptions, what does *their* `totalSupply` tell a parent who reads it, versus what *yours* tells? Which store can answer "how many credits are still out there that students could spend?" from a single number — and why does that matter for tiwala?

## What You've Learned

- **`burn(amount)` calls `_burn(msg.sender, amount)`** — destroys your own credits, dropping both your balance and `totalSupply`; the mirror of `transfer`, and never `onlyOwner`.
- **`burnFrom(account, amount)` calls `_spendAllowance` then `_burn`** — the mirror of `transferFrom`, destroying another account's credits only within an allowance and reverting `ERC20InsufficientAllowance` if short.
- **One redemption emits two `Transfer` events** — a pull into the store, then a burn to `0x0` — and only the burn moves `totalSupply`.
- **Burning on redemption makes the supply honest:** the store nets zero, `totalSupply` falls by the price, and the total stops meaning "credits ever printed" and starts meaning "credits still live." The contracts are now complete.
