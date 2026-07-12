# Run the Full System Test Checklist

There is **no new contract code** this lesson — both `act_1.sol` (WorkshopCredit) and `RewardStore.sol` are already finished. Your deliverable is *evidence*: a checklist, run top to bottom, with the **actual** Remix result written next to the **expected** one you commit to *first*. Open a blank note titled "WCR System Test — Expected vs Actual" beside Remix and work the tasks in order.

## Task 1: Set Up Three Accounts and Deploy Both Contracts

Open Remix, compile `act_1.sol` and `RewardStore.sol`. Under **Deploy & Run**, set Environment to **Remix VM (Cancun)** and note three accounts by role:

- **Account 1 — Instructor / Owner:** `0x5B38Da6a701c568545dCfcB03FcB875f56beddC4`
- **Account 2 — Kevin (student):** `0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2`
- **Account 3 — Ana (student):** `0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db`

From Account 1, deploy `WorkshopCredit`. Copy its address, paste it into the `RewardStore` constructor field, and deploy `RewardStore`. Then call `addItem("Turon", 100000000000000000000)` (that long integer is `100 * 10**18` — 100 WCR in base units). Read `totalSupply()` → 1,000 WCR and `itemCount()` → 1. Baseline established.

## Task 2: Prove the Happy Paths

Switch the account dropdown to match the "Who" column before each row. For every row, **write your expected result first**, then run it and record what Remix actually printed.

- **Award (Instructor):** `rewardStudent(Kevin, 200e18, "Finished final exercise")` → Kevin holds 200 WCR, `totalSupply` = 1,200. Expand the transaction: a `StudentRewarded` log *and* a `Transfer` from the zero address (that's how a mint enters the ledger).
- **Transfer (Instructor):** `transfer(Ana, 100e18)` → Instructor 900, Ana 100, one `Transfer` event.
- **Approve (Kevin):** on the token, `approve(RewardStore, 100e18)` → an `Approval` event fires, no balance moves (approve is permission, not payment). Then read `allowance(Kevin, RewardStore)` → `100000000000000000000`.
- **Buy + burn (Kevin):** read `totalSupply` first, then on the store call `buyItem(0)`. Watch three logs in order — `transferFrom` pulls Kevin's WCR into the store, `burn` sends it to the zero address, `ItemPurchased` records the sale. Re-read `totalSupply` → it drops 1,200 → 1,100, and `allowance(Kevin, store)` → 0.

## Task 3: Prove the Failure Paths — a Good User's Bad Action

These *should* revert cleanly and change nothing. Predict the exact error name first, then run.

- **Over-transfer (Ana, holds 100):** `transfer(Kevin, 1000e18)` → reverts `ERC20InsufficientBalance`. Ana's balance is untouched afterward.
- **Buy without approving (Ana, never approved):** `buyItem(0)` → reverts `ERC20InsufficientAllowance`. No purchase.
- **Buy an id that doesn't exist (Kevin):** `buyItem(1)` when only item 0 exists → the store refuses the sale. Record the *actual* revert verbatim — it may not be the error you predicted, and noticing that is the point of the exercise.

## Task 4: Prove the Permission Path — the Wrong Person

Switch to **Ana (Account 3)** and try an owner-only action: `rewardStudent(Kevin, 200e18, "Sneaky")` → reverts `OwnableUnauthorizedAccount(Ana)`, and `totalSupply` is *still* 1,200. The door is locked, not just labeled locked — and now you've watched it hold.

## Sample Output

Three refusals you'll record, straight from the Remix terminal:

```text
Error provided by the contract:
OwnableUnauthorizedAccount
Parameters:
{ "account": { "value": "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db" } }
```

```text
Error provided by the contract:
ERC20InsufficientBalance
Parameters:
{
 "sender":  { "value": "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db" },
 "balance": { "value": "100000000000000000000" },
 "needed":  { "value": "1000000000000000000000" }
}
```

And the happy `buyItem(0)` — three logs, the middle one a burn:

```text
Transfer      from: Kevin        to: RewardStore   value: 100000000000000000000
Transfer      from: RewardStore  to: 0x000...000   value: 100000000000000000000
ItemPurchased id: 0   buyer: Kevin   price: 100000000000000000000
```

Read `ERC20InsufficientBalance` like a sentence: *sender* Ana *has* 100 WCR, *needs* 1,000. The refusal comes with a receipt.

## Reflection Questions

1. Row-by-row, why is "the transaction reverted" a *success* for the failure and permission paths, but a *failure* for the happy paths? What is each row actually asserting?
2. `buyItem(1)` and `buyItem(0)`-without-approval both refuse the sale — but do they refuse with the *same* error? Why might the id-out-of-range case surprise a tester who only read the friendly `require` string in the store?
3. Ate Rina insists you write the *expected* column before running each row. What exactly do you lose if you run the row first and fill in "expected" afterward?

## Challenge

**Challenge A — Run the full checklist and record actual vs expected.** Deploy both contracts fresh and work every row top to bottom, switching accounts as the "Who" column says. In your note, write the expected result before each run, then paste the actual Remix output beside it. Track `totalSupply` across the run: it should read 1,000, then 1,200 after the award, then 1,100 after the burn. A supply that doesn't add up is the ledger telling you a step didn't do what you thought.

**Challenge B — Add one edge-case row of your own, then run it.** Invent an unhappy path the tasks above don't cover, add it as a new row (Action | Who | Expected), predict its result, and run it. Ideas: `rewardStudent` to the zero address `0x000...000`; `approve` then `buyItem` for an item priced higher than the buyer's balance; or `transfer(someone, 0)` — does a zero-value transfer succeed, and does it still emit a `Transfer` event? Whatever you pick, write your prediction *before* you run it.

## What You've Learned

- **A tested system walks all three roads** — happy, failure, and permission paths — not just the sunny one where everyone behaves.
- **A revert with the exact predicted error is a passing test**, the same way a successful happy-path call is; "reverted" is only bad news on a row that was supposed to succeed.
- **OZ v5 custom errors are readable data**: `ERC20InsufficientBalance`, `ERC20InsufficientAllowance`, and `OwnableUnauthorizedAccount` each name who tried and why the ledger said no.
- **Manual testing teaches you what a pass looks like** — so when you later run Foundry or Hardhat and it prints "10 passing," you know exactly what that green means.
