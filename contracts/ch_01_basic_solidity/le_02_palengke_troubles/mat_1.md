# Palengke Troubles — Data Types, State Variables & Mappings

![2.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_02_palengke_troubles/2.0%20-%20COVER.png)

## Scene

After work, Neri heads to the palengke (wet market) to buy her groceries. Chaos reigns as vendors deal with failed QR transactions and confusion over cash payments. One vendor, Ate Linda, gets shortchanged because she could not calculate exact change properly. Another vendor complains about inconsistent records, leading to mistrust among customers.

Neri reflects on how blockchain's immutability can solve this. If payment records were on-chain and all parties agreed on a shared, transparent ledger, these disputes could vanish. She remembers how **data types** in Solidity define and structure information, ensuring it is accurate, consistent, and secure — and how a **mapping** can give every vendor their own tamper-proof running total.

## Why this matters

Ate Linda's problem is not bad math — it is bad *bookkeeping*. Cash records can be erased, QR receipts can be lost, and "trust me, I remember the amount" is not a system. A smart contract fixes this at the root: once you write a sale into contract storage, it is **permanent, public, and verifiable**. Nobody can quietly edit yesterday's totals.

But the contract can only be as trustworthy as the *shape* of its data. If you store a vendor's sales in a type that can't go negative, no buggy code can ever make their balance dip below zero. If you key every vendor's total to their wallet address, two vendors can never collide. **Choosing the right data type is the first security decision you make.** This lesson builds the `PalengkeLedger` contract one variable at a time so that structure is rock-solid.

## The two homes for data: storage vs. the stack

Before the types themselves, one idea that trips up every beginner: **where does a value live?**

- **State variables** are declared at contract level (outside any function). They live in **storage** — written permanently to the blockchain, persisting between transactions, and costing gas to change. `totalSales` is a state variable; its value survives long after the transaction that set it.
- **Local variables** and function parameters live only for the duration of one call (on the stack or in memory) and then vanish. The `_saleAmount` argument passed into `recordSale` is gone the moment the function returns.

Keep this distinction in mind: every type below behaves differently depending on whether it is a persistent state variable or a throwaway local.

## The core value types

In Solidity, data types structure information like numbers, text, or true/false flags. These are the building blocks of `PalengkeLedger`.

### Boolean (`bool`) — a yes/no flag

Holds exactly `true` or `false`. Perfect for "did this happen?" questions — like whether the last sale went through.

```solidity
bool public transactionStatus; // defaults to false
```

> Every state variable in Solidity starts at its **zero value** automatically — there is no `null`/`undefined`. A `bool` starts `false`, a `uint256` starts `0`, a `string` starts `""`, an `address` starts `address(0)`. You never have to initialize them just to avoid garbage values.

### Unsigned integers (`uint`) — whole numbers that can't go negative

`uint` is a container for **non-negative whole numbers** — zero and up, never negative.

- The keyword is followed by a bit-width: `uint8`, `uint16`, … `uint256`. More bits means a larger maximum value (`uint8` tops out at 255; `uint256` goes up to ~1.15 × 10⁷⁷).
- Plain `uint` is an alias for `uint256`, which is the default you should reach for. Smaller types only save gas in specific packing scenarios — until you know those, use `uint256`.

```solidity
uint256 numberOfMangoes = 10;     // valid
// uint256 numberOfMangoes = -10; // ERROR: uint cannot be negative
```

This is exactly why `totalSales` and per-vendor sales are `uint256`: you can never have negative sales, and the type *enforces* that.

> **Overflow is checked since Solidity 0.8.** If a `uint256` would overflow past its max (or underflow below 0), the transaction automatically reverts instead of silently wrapping around. That is why the old `SafeMath` library is no longer needed — the compiler protects you for free. (You can opt out inside an `unchecked { }` block when you have proven it is safe and want the gas savings, but that is an advanced optimization.)

### Signed integers (`int`) — when negatives are real

`int` stores **both positive and negative** whole numbers. Same bit-widths (`int8` … `int256`), and plain `int` means `int256`.

```solidity
int256 profit = 100;  // a good day
int256 loss = -50;    // a bad day
```

Use `int` only when a value can genuinely be negative — like a vendor's net profit/loss. For a *running total of sales*, which only ever grows, `uint256` is the correct and safer choice.

### String (`string`) — human-readable text

Holds UTF-8 text, like a vendor's name.

```solidity
string public vendorName;
```

> **Gas note:** strings are expensive to store and compare on-chain. They are fine for a small label like a vendor name, but never loop over strings or use them as a substitute for an enum/ID. If you find yourself comparing strings, you usually want a `bytes32` or an `enum` instead.

### Address (`address`) — an on-chain identity

Represents a 20-byte Ethereum account (a user's wallet or another contract). This is *the* primary key of the blockchain world — it is how you identify "who."

```solidity
address vendorWallet = 0xDF744BA5808cde3e87B3390A8A3DcE5cCB349068;
```

There is also `address payable` (an address you are allowed to send ETH to) — you will meet it when you handle money in later lessons. For *identifying* a vendor, plain `address` is what we use.

## Arrays — ordered lists of the same type

When you need an ordered collection (e.g., the recent transaction amounts), use an array.

```solidity
// Fixed-size: exactly 3 slots, length can never change
uint256[3] public recentTransactions = [1, 2, 3];

// Dynamic: grows and shrinks at runtime
uint256[] public productPrices = [10, 20, 30, 40, 50];

// You can hold any type, including strings
string[] public vendorNames = ["Aling Nena", "Mang Juan", "Ate Maria"];
```

> **Gotcha:** never loop over an *unbounded* dynamic array in a function that changes state. If the array grows large, the loop can exceed the block gas limit and your function becomes permanently un-callable. For "look up one vendor's total," a **mapping** (next section) is the right tool — it is O(1) and gas-cheap, no loop required.

## Mappings — the key→value lookup that powers the ledger

A `mapping` links a **key** to a **value**, like a hash table or dictionary. This is the heart of `PalengkeLedger`: it lets every vendor have their *own* running sales total, looked up instantly by wallet address.

```solidity
// Vendor wallet address  ->  their cumulative sales
mapping(address => uint256) public vendorSales;
```

Reading and writing is array-like, using the key inside brackets:

```solidity
vendorSales[_vendor] += _saleAmount;        // add to this vendor's total
uint256 total = vendorSales[someVendor];    // read a vendor's total
```

Three things to internalize about mappings:

1. **Every possible key already "exists" at its zero value.** `vendorSales[anyBrandNewAddress]` returns `0` — not an error. There is no "key not found." This is why `+=` works on a brand-new vendor: `0 + amount`.
2. **You can't enumerate a mapping.** There is no `.length`, no way to loop over its keys, no "give me all vendors." A mapping only answers "what is the value for *this* key?" If you also need the list of keys, you maintain a separate array alongside it.
3. **The `public` keyword auto-generates a getter.** `mapping(address => uint256) public vendorSales;` gives you a free `vendorSales(address)` view function — no need to write one by hand.

> **Why a mapping beats an array here:** with `vendorSales[_vendor]` you jump straight to one vendor's total in a single, cheap operation, no matter how many thousands of vendors exist. An array would force you to scan through everyone to find a match — slow, and eventually gas-prohibitive.

## Putting it together — the `PalengkeLedger` contract

Here is the full contract this lesson's activity builds. Every concept above appears in it.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PalengkeLedger {
    string public vendorName;            // text label
    uint256 public totalSales;           // non-negative running total
    bool public transactionStatus;       // did the last sale succeed?

    // Each vendor's cumulative sales, keyed by wallet address
    mapping(address => uint256) public vendorSales;

    function recordSale(
        address _vendor,
        string memory _vendorName,
        uint256 _saleAmount
    ) public {
        vendorName = _vendorName;             // update the latest vendor name
        totalSales += _saleAmount;            // grow the market-wide total
        vendorSales[_vendor] += _saleAmount;  // grow THIS vendor's total
        transactionStatus = true;             // flag the sale as successful
    }

    // "view" because it only reads state, never changes it (Lesson 14)
    function isTransactionSuccessful() public view returns (bool) {
        return transactionStatus;
    }
}
```

Trace one sale: `recordSale(0xLinda…, "Ate Linda", 250)` records the name, adds `250` to both the market total and Ate Linda's personal total, and flips the success flag. Call it again for Ate Linda and her `vendorSales` total climbs to `500` — automatically, with overflow protection, permanently on-chain. No more shortchanging, no more lost records.

> **Note on `string memory`:** the `_vendorName` parameter is marked `memory` because reference types (strings, arrays, structs) passed into functions must declare a **data location**. `memory` means "a temporary copy that disappears when the function ends." Value types like `address`, `uint256`, and `bool` don't need this — they are copied by value automatically.

## Common mistakes to avoid

1. **Using `int` for things that can't be negative.** Sales, balances, counts, and IDs should be `uint256`. Using a signed `int` throws away the compiler's "can never go below zero" guarantee.
2. **Reaching for tiny types prematurely.** `uint8` looks efficient but its max is 255 — a sale of 300 would revert. Default to `uint256` unless you have measured a packing benefit.
3. **Forgetting the data location on reference types.** `string _vendorName` without `memory` (or `calldata`) won't compile. Value types never need it.
4. **Trying to loop over a mapping.** Mappings have no length and no iteration. If you need the full list of vendors, keep a separate `address[]` array.
5. **Expecting a "missing key" error.** Reading an unset mapping key returns the zero value, not a revert. Don't treat `0` as proof the key was never written — track existence with a separate `bool` flag if it matters.
6. **Assuming `string` comparison is cheap.** Comparing or storing large strings burns gas. Use IDs, `enum`s, or `bytes32` for anything you compare frequently.

## What's next

You now know how to *shape* and *store* data. In **Lesson 3** you will write functions that act on it with proper visibility (`public`/`external`/`internal`/`private`). In **Lesson 5 (Battle Against Hackana)** you will add `require`/`revert` guards so bad data can never enter the ledger in the first place. And in **Lesson 14** you will formalize the `view` keyword you saw on `isTransactionSuccessful` and meet its sibling, `pure`.

## References

- Solidity docs — Types: https://docs.soliditylang.org/en/latest/types.html
- Solidity docs — Mapping Types: https://docs.soliditylang.org/en/latest/types.html#mapping-types
- Solidity docs — Data location & assignment behaviour: https://docs.soliditylang.org/en/latest/types.html#data-location
- Solidity by Example — State Variables & Mappings: https://solidity-by-example.org/state-variables/ and https://solidity-by-example.org/mapping/

## Closing

The next morning, Neri shows Ate Linda a prototype: every sale tapped into a phone, every total updated on a shared ledger nobody can secretly edit. Ate Linda squints at her own `vendorSales` total on the screen and grins. "Hindi na ako maloloko sa sukli — nakasulat na lahat." (No one can cheat me on change anymore — it's all written down.) One well-typed variable at a time, Neri is turning palengke chaos into a record everyone can trust.
