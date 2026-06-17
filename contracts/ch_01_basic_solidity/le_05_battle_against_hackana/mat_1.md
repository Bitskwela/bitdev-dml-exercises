# Neri's Battle Against Hackana — Validation & Error Handling in Solidity

![5.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_05_battle_against_hackana/5.0%20-%20COVER.png)

## Scene

As Hackana's malware spreads across the country, Neri watches it drain bank accounts, knock government websites offline, and push unauthorized transactions through systems that never bothered to check them. The pattern is always the same: **a function trusted its input and paid the price.**

Neri's counter-move is a discipline, not a gadget: every function she writes will *refuse to run* unless its preconditions are provably true. She builds a **Community Fund** contract where people can donate and the owner can withdraw — but only when the amount is right, the sender is allowed, and the math can't be gamed. If any check fails, the transaction reverts and the blockchain is left exactly as it was, as if the attack never happened.

That "all-or-nothing" guarantee is what makes smart contracts trustworthy. Let's learn the three tools that enforce it: **`require`**, **`revert` + custom errors**, and **`assert`**.

![5.1](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_05_battle_against_hackana/5.1.png)

## Why validation is the whole game

On Ethereum, a transaction is **atomic**: either every state change inside it succeeds, or the entire transaction is rolled back and nothing persists (the caller still pays gas for the work done up to the failure). There is no "half-executed" contract.

That means a single well-placed check can make an entire class of exploits *impossible* — not "discouraged," impossible. Hackana can't withdraw funds it doesn't own if the very first line of `withdraw()` rejects non-owners and reverts.

The mental model: **validate first, change state second, talk to the outside world last** (the Checks-Effects-Interactions pattern, which you'll master in Lesson 30). Today is about the "validate first" half.

## 1. `require` — guard your preconditions

`require` checks a condition before the function does any real work. If the condition is `false`, execution stops, all changes so far revert, and an optional reason is returned to the caller.

```solidity
function donate(uint256 amount) external payable {
    require(amount > 0, "Donation must be greater than zero");
    require(msg.value == amount, "Sent ETH must match the stated amount");
    // ...only runs if BOTH checks passed
}
```

Use `require` for the things that depend on **who called, with what, and in what state**:

- **Input validation** — `require(amount > 0, "...")`
- **Access control** — `require(msg.sender == owner, "Not the owner")`
- **State preconditions** — `require(!isPaused, "Contract is paused")`
- **Return-value checks** — `(bool ok, ) = to.call{value: v}(""); require(ok, "Transfer failed");`

When a `require` fails it **reverts and refunds the remaining gas** to the caller — they only pay for the work actually done before the check tripped.

## 2. `revert` + custom errors — the modern, gas-efficient way

Since Solidity **0.8.4**, the idiomatic way to fail is a **custom error**. It's cheaper than a string message (a 4-byte selector instead of a stored string), and it can carry structured data that a frontend or another contract can decode.

```solidity
// Declare errors at file or contract scope
error Unauthorized(address caller);
error InsufficientFunds(uint256 requested, uint256 available);

function withdraw(uint256 amount) external {
    if (msg.sender != owner) revert Unauthorized(msg.sender);
    if (amount > totalDonations) revert InsufficientFunds(amount, totalDonations);
    // ...
}
```

Two equivalent styles — pick the one that reads best:

```solidity
// if + revert (great when the error carries data)
if (amount == 0) revert("Donation must be greater than zero");

// require with a custom error (Solidity 0.8.26+ supports this form)
require(amount > 0, ZeroDonation());
```

> **Why custom errors win:** on a failed `require("Donation must be greater than zero")`, that whole string is compiled into your bytecode and returned on every revert. `error ZeroDonation()` is just a 4-byte selector — smaller contract, cheaper reverts, and the data (`requested`, `available`, etc.) is machine-readable.

## 3. `assert` — catch the "this should be impossible" bugs

`assert` is **not** for validating user input. It documents an **invariant** — something that must be true if your code is correct. A failing `assert` signals a *bug in the contract*, not a bad caller.

```solidity
// Invariant: per-user balances can never sum to more than the contract's total
assert(totalDonations >= donations[msg.sender]);
```

A failing `assert` raises a `Panic(uint256)` error and reverts. (Note: since Solidity **0.8.0**, a failed `assert` refunds the remaining gas just like `revert` — it no longer burns all of it, which was the old pre-0.8.0 behavior you may still see in outdated tutorials.)

## Which one do I reach for?

| Situation | Use | Failure type |
|---|---|---|
| Bad/missing user input, wrong caller, wrong state | `require` / `revert CustomError()` | `Error(string)` or your custom error |
| A condition that should be unreachable if the code is correct (invariant) | `assert` | `Panic(uint256)` |
| You want to attach data to the failure (and save gas) | custom error + `revert` | your custom error |

Rule of thumb: **`require`/`revert` blame the caller; `assert` blames the code.**

## Worked example — the Community Fund's guards

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CommunityFund {
    address public fundOwner;
    uint256 public totalDonations;

    constructor() {
        fundOwner = msg.sender;
    }

    function donate(uint256 amount) external payable {
        require(amount > 0, "Donation must be greater than zero");
        require(msg.value == amount, "Insufficient Ether provided");
        totalDonations += amount;
    }

    function withdraw(uint256 amount) external {
        require(msg.sender == fundOwner, "Only the owner can withdraw funds");
        require(amount <= totalDonations, "Not enough funds");
        totalDonations -= amount;
        (bool success, ) = payable(fundOwner).call{value: amount}("");
        require(success, "Transfer failed");
    }
}
```

Trace Hackana's attempts against it: donate 0 → reverts. Lie about `msg.value` → reverts. Withdraw as a stranger → reverts. Over-withdraw → reverts. Every illegitimate path dead-ends at a guard, and the fund's state is never corrupted.

## Common mistakes to avoid

1. **Using `assert` for input validation.** It signals a bug, not a bad request, and produces a confusing `Panic` instead of a clear reason. Use `require`/`revert`.
2. **Changing state before validating.** Put your checks at the top so a revert never leaves partial work behind.
3. **Ignoring return values.** Low-level `.call` returns a success boolean — `require(success, "...")` it. Likewise, non-standard ERC-20 `transfer` calls can return `false` instead of reverting.
4. **Stuffing logic into the reason string.** Keep messages short, or better, switch to custom errors.
5. **Validating in the wrong place.** Re-validate in every externally callable function; never assume an earlier call already checked.

## What's next

You now know how to *reject* bad transactions. In the coming lessons you'll add **modifiers** (Lesson 6) to reuse guards like `onlyOwner`, dedicated **custom errors** (Lesson 27), and finally the full **Checks-Effects-Interactions + ReentrancyGuard** defense (Lesson 30) that closes the door on reentrancy entirely.

## References

- Solidity docs — Error handling: `assert`, `require`, `revert` — https://docs.soliditylang.org/en/latest/control-structures.html#error-handling-assert-require-revert-and-exceptions
- Solidity docs — Custom errors — https://docs.soliditylang.org/en/latest/contracts.html#errors-and-the-revert-statement
- Solidity by Example — Error handling — https://solidity-by-example.org/error/

## Closing

Neri deploys the Community Fund and watches the dashboard. Donations flow in; Hackana's probing transactions bounce off, each one reverted before it can touch a single wei. "Hindi sa lakas," she tells her team, "kundi sa tamang pag-iingat." (Not by force, but by the right precautions.) One validated function at a time, she's turning chaos into a system people can trust.
