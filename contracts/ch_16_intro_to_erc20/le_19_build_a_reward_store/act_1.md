# Build the Storefront (RewardStore v1)

Build **version 1** of the reward store: a second contract that holds the token's address and a catalog of items. It does **not** take payment yet — that's Lesson 20. Open `act_1.sol`. The scaffold is already there — the `credit` reference, the `Item` struct, the `items` array, the `ItemAdded` event, and a constructor that wires the store to WCR. Your job is the two empty functions.

Read the scaffold first. The constructor takes an `address creditToken` and stores it as `credit = IERC20(creditToken)` — that single `immutable` line is the whole "the store knows which token it accepts." You don't touch it; you just build on top of it.

## Task 1: `addItem` — Write a Price Card

Fill in `addItem(string calldata name, uint256 price)`:

1. Append a new `Item` to the `items` array — built from the incoming `name`, the incoming `price`, and `true` for `active` (a freshly listed reward is available). Use the array's `.push(...)` method.
2. Emit `ItemAdded` so the ledger records the listing. The new item's **id** is its index — and because you just pushed it to the end, that index is `items.length - 1`. Pass that id, plus the `name` and `price`.

No access control today — anyone can call this. Restricting it to the instructor is Lesson 21's `onlyOwner`.

## Task 2: `itemCount` — Count the Shelf

Fill in `itemCount()` so it returns how many items have been listed. That's just the array's length — `items.length`. It's a `view` function: it reads state and changes nothing.

## Sample Output

The store needs a token to point at, so order matters: **deploy the token first, then feed its address to the store.** In Remix (Environment = Remix VM), addresses shortened:

```text
// 1. Deploy WorkshopCredit (from Lesson 9). It lands at, say:
0xd9145CCE52D386f254917e481eB44e9943F39138

// 2. Deploy RewardStore, pasting that address into the creditToken field:
creditToken:  0xd9145CCE52D386f254917e481eB44e9943F39138

// 3. Confirm the wiring — click blue `credit`:
credit()      ->  0xd9145CCE52D386f254917e481eB44e9943F39138

// 4. Empty catalog:
itemCount()   ->  0

// 5. Add the first reward. 100 WCR in base units = 100 * 10**18:
addItem("Turon", 100000000000000000000)
```

Expand that transaction's decoded **logs** and you'll see your event:

```text
{
  "event": "ItemAdded",
  "args": { "id": "0", "name": "Turon", "price": "100000000000000000000" }
}
```

Then read the catalog back:

```text
itemCount()   ->  1

items(0)  ->  0: string  name    Turon
              1: uint256 price   100000000000000000000
              2: bool    active  true
```

There it is — your first price card, stored on-chain, readable by anyone: name, price in base units, and `active = true`.

## Reflection Questions

1. `credit` is `immutable`. What would a student be unable to trust about the store if `credit` could be reassigned after deployment — and what real-world swap does `immutable` prevent?
2. The store holds WCR's *address*, not a copy of everyone's balances. Why is a copy a bad idea? Think about two different stores each keeping their own tally of the same student's WCR.
3. The item's **id** is just its index in the `items` array. What's the id of the *third* item you add, and why isn't it `3`?

## Challenge: Stock the Shelves

**Challenge A — Add a second item.** With the store deployed and wired to WCR, add a *second* reward: a secondhand USB stick priced at **500 WCR**. Work out the base-unit number yourself (`500 * 10**18`), call `addItem`, then verify with `itemCount()` and `items(1)`. Confirm your original Turon at `items(0)` is untouched.

**Challenge B — Why an address, not a copy?** In two or three sentences, explain why the store references the token by address instead of keeping its own private copy of who-holds-how-many WCR. Tie it to Tita Malou trying to verify a balance, and to two stores disagreeing about the same student — and to the smudged-notebook problem from Lesson 1.

## What You've Learned

- A **project can be many contracts**: `RewardStore` is a second contract that cooperates with `WorkshopCredit` instead of duplicating it.
- A contract references another **by address + interface** — `credit = IERC20(creditToken)` stores WCR's location and how to call it, never a copy.
- **`immutable`** locks `credit` at deployment, so the token a store accepts is a promise anyone can verify.
- A **struct** (`Item`) groups related fields, and a **dynamic array** (`Item[]`) grows a catalog with `.push()`, using each item's zero-based index as its id.
