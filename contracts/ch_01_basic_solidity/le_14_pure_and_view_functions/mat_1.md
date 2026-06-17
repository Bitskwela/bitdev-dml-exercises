# Pure and View Functions — Reading and Transforming Data Without Touching State

![14.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_14_pure_and_view_functions/14.0%20-%20COVER.png)

## Scene

Neri is working with the Barangay San Juan officials to digitize their public records. One concern keeps coming up: how can residents *check* barangay service fees — IDs, permits, certifications — and even compute "how much for five certifications?" without anyone accidentally *changing* the official records?

While brainstorming, Neri reaches for two of Solidity's most useful tools: **`view`** and **`pure`** functions. One lets the contract read the records without altering them; the other does pure arithmetic with no records involved at all. Together they make a public, read-only window into the barangay's data.

## Why this matters

In the barangay, looking up a fee and paying a fee are two completely different acts. Looking is free, harmless, and should never accidentally edit the official ledger. Paying changes the records and must be deliberate.

Solidity bakes this exact distinction into the language. A function can **promise** that it won't modify state (`view`) or that it won't even *read* state (`pure`), and the **compiler enforces that promise**. Break it — try to write to a state variable inside a `view`, or read one inside a `pure` — and your code won't even compile. That is not bureaucracy; it is a safety contract. Anyone reading `getCertificationFee()` knows, with certainty, that calling it can't drain a wallet or corrupt a record. This lesson makes the boundary crisp using the `BarangayServiceFees` contract.

## The three mutability levels

Every function sits in exactly one of three buckets, ordered by how much it is allowed to touch:

| Level | Can read state? | Can write state? | Costs gas when called on its own? | Keyword |
|---|---|---|---|---|
| **State-changing** | Yes | **Yes** | **Yes** — sends a transaction | *(none — the default)* |
| **View** | Yes | No | No (free read via `eth_call`) | `view` |
| **Pure** | **No** | No | No (free read via `eth_call`) | `pure` |

Read it top to bottom as a tightening promise: a normal function can do anything, `view` gives up the right to *write*, and `pure` gives up the right to even *read*. The stricter the promise, the more a caller can trust the function — and the more aggressively the compiler can optimize it.

> **"No gas" has an important asterisk.** A `view`/`pure` function is free **only when called directly from outside** the blockchain (a frontend doing `eth_call`, a wallet showing a balance). The moment another contract's *transaction* calls it as part of on-chain execution, it runs inside that transaction and its computation is paid for like any other code. "Read-only = free" is true for off-chain reads, not a blanket rule.

## `view` — read the records, change nothing

A `view` function may **read** state variables but is forbidden from **modifying** them. Use it whenever you want to surface a value that already lives in the contract — like the current barangay certification fee.

```solidity
uint256 public certificationFee = 100; // fee for one certification, in state

// READS certificationFee, changes nothing -> view
function getCertificationFee() public view returns (uint256) {
    return certificationFee;
}
```

The compiler will reject any attempt to write inside a `view`:

```solidity
function getCertificationFee() public view returns (uint256) {
    certificationFee = 200; // COMPILE ERROR: cannot modify state in a view function
    return certificationFee;
}
```

What counts as "modifying state" (and is therefore banned in `view`): assigning to a state variable, emitting an event, creating another contract, sending ETH, calling a non-view function, or using low-level `selfdestruct`. If you do none of those but *do* read state, `view` is your label.

> **Analogy:** checking the price of a fish at the palengke. You are just *looking* at the listahan — not buying, not changing the price tag.

## `pure` — compute from inputs only, ignore the records entirely

A `pure` function is stricter: it may **neither read nor modify** state. Everything it needs must arrive through its parameters; everything it produces goes out through its return value. It is a self-contained calculator.

```solidity
// Operates ONLY on its input + literals. Never touches state -> pure
function calculateTotalCost(
    uint256 numberOfCertifications
) public pure returns (uint256) {
    return numberOfCertifications * 100;
}
```

Here is the subtlety the whole lesson hinges on. `calculateTotalCost` multiplies by the **literal `100`**, not by the `certificationFee` state variable. That literal is baked into the code — it is not "state." The moment you reach for the state variable instead, the function is no longer `pure`:

```solidity
//  Reads certificationFee (a STATE variable) -> this must be `view`, NOT `pure`
function calculateTotalCost(uint256 numberOfCertifications) public view returns (uint256) {
    return numberOfCertifications * certificationFee;
}

//  Trying to keep `pure` while reading state WON'T COMPILE:
function calculateTotalCost(uint256 numberOfCertifications) public pure returns (uint256) {
    return numberOfCertifications * certificationFee; // ERROR: reading state in a pure function
}
```

This is the single most common `pure`/`view` mistake: **the instant a function reads even one state variable, it cannot be `pure` — it must be at least `view`.** If you want a truly `pure` calculator, pass every value it needs (including the fee) as a parameter:

```solidity
//  Fee comes in as an argument, so no state is touched -> legitimately pure
function calculateCost(
    uint256 numberOfCertifications,
    uint256 feePerCertification
) public pure returns (uint256) {
    return numberOfCertifications * feePerCertification;
}
```

> **Analogy:** calculating the change you'll get after paying for the fish. You're just doing arithmetic in your head — you don't even need to look at the price tag again, because you already hold the numbers.

## Combining them in `BarangayServiceFees`

The activity contract uses one of each — the cleanest possible illustration of the boundary:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayServiceFees {
    uint256 public certificationFee = 100; // state: fee for one certification

    // VIEW: reads the stored fee, changes nothing
    function getCertificationFee() public view returns (uint256) {
        return certificationFee;
    }

    // PURE: computes from the input alone (multiplies by a literal, reads no state)
    function calculateTotalCost(
        uint256 numberOfCertifications
    ) public pure returns (uint256) {
        return numberOfCertifications * 100;
    }
}
```

A resident calls `getCertificationFee()` to *see* the official price (a read of state → `view`). Anyone can call `calculateTotalCost(5)` to find the total for five certifications (math on the input → `pure`). Neither call sends a transaction, neither costs the resident gas, and the compiler guarantees neither can ever alter the barangay's records.

## A quick decision guide

Ask two questions, in order:

1. **Does the function write to state** (assign a state variable, emit an event, send ETH, call something that does)? → Then it is **state-changing**; use no mutability keyword.
2. If not, **does it read any state variable?** → **Yes** = `view`. **No** (works purely from its parameters) = `pure`.

That's the whole rule. Reach for the strictest level the function honestly qualifies for — it documents intent and lets the compiler catch accidental writes for you.

## Gas & security notes

- **Always label correctly.** A function that *could* be `view`/`pure` but is left unlabeled still works, but you lose the compiler guarantee and the off-chain "free call" benefit. The compiler will even warn you when a function can be tightened to `view` or `pure`.
- **Read-only ≠ trustless input.** `view`/`pure` only constrain *this contract's* state. They don't validate arguments. `calculateTotalCost(type(uint256).max)` would still revert on overflow — mutability keywords are not a substitute for input validation (Lesson 5).
- **`pure` is the most auditable.** Because it depends on nothing but its inputs, a `pure` function always returns the same output for the same input — easy to reason about, test, and reuse. Prefer pushing logic into `pure` helpers when you can.

## Common mistakes to avoid

1. **Marking a state-reading function `pure`.** The classic error: `return numberOfCertifications * certificationFee;` in a `pure` function. Reading `certificationFee` makes it `view`. To stay `pure`, pass the fee in as a parameter.
2. **Marking a writer as `view`.** Assigning to a state variable, or emitting an event, inside a `view` is a compile error. If it changes anything, drop the keyword.
3. **Expecting `view`/`pure` to always be free.** They are free for off-chain `eth_call`s only. Called inside another transaction, they cost gas like normal code.
4. **Forgetting `returns`.** A `view`/`pure` function that hands back a value still needs an explicit `returns (...)` clause — the keyword describes mutability, not the return signature.
5. **Over-restricting.** Don't force a function to be `pure` by smuggling state in through parameters if it genuinely belongs to the contract's data — sometimes `view` is simply the honest, correct choice.

## What's next

You can now read and compute without risk. Next you will write **state-changing** functions that *do* modify the ledger, and learn to guard them. **Lesson 5 (Battle Against Hackana)** layers on `require`/`revert` validation, and later lessons add **modifiers** and **events** so your state-changing functions stay safe and observable. Look back at Lesson 2's `isTransactionSuccessful()` — that was your first `view` function, now fully explained.

## References

- Solidity docs — View functions: https://docs.soliditylang.org/en/latest/contracts.html#view-functions
- Solidity docs — Pure functions: https://docs.soliditylang.org/en/latest/contracts.html#pure-functions
- Solidity docs — State Mutability: https://docs.soliditylang.org/en/latest/contracts.html#state-mutability
- Solidity by Example — View and Pure Functions: https://solidity-by-example.org/view-and-pure-functions/

## Closing

Neri demonstrates the two functions to the barangay officials. A resident pulls out her phone, taps `getCertificationFee()`, and sees `100` — the real, current price, straight from the ledger. Then she taps `calculateTotalCost(3)` and instantly gets `300` for her three certifications.

A vendor watching nearby smiles: **"Neri, parang ganito rin 'yung ginagawa ng tindahan ko kapag nagkukwenta ng presyo!"** (*Neri, this feels just like how my store calculates prices!*)

Neri nods: **"Tama ka! Kaya ang smart contracts ay kayang mag-digitize ng proseso kahit simple lang ang kailangan."** (*Exactly! Smart contracts can digitize even simple processes.*) The barangay captain nods approvingly, already imagining the next service to bring on-chain.
