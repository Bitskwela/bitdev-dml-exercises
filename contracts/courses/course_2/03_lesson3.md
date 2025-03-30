---
title: "Side Quest 3: Reentrancy Fix"
description: "A short description of this document."

# This is the date the document was last updated.  Format: YYYY-MM-DD.
date: "2025-03-30"

# For SEO purposes
tags: ["markdown", "metadata", "bitskwela", "solidity"]

# Currently supported types:
# NormalExercise - Just a simple module.  Does not require user input.
# ActivityExercise - Where the user needs to submit a code and verify.  As of now, no backend verification.
# May be supported in the future:
# VideoExercise - For exercises that are just videos.
type: "ActivityExercise"

# Note: Permanames are unique and immutable. Once set, they cannot be changed.  You may change the filename but not this.
permaname: "sq-3-reentrancy-fix"

# Can be the same as permaname but can be changed if needed.
slug: "sq-3-reentrancy-fix"
---

# Side Quest 3: Reentrancy Fix

## Scenario:

One of Hackana’s minions left behind a reentrancy vulnerability in the Palengke digital wallet system. Vendors are losing funds when attackers withdraw repeatedly in a single transaction. Neri must fix the wallet.

- Time Allotment: 20 minutes
- Solidity Topics Covered: Reentrancy, Best Practices.
- Checklist: Prevent reentrancy, use Checks-Effects-Interactions pattern.

## TODO:

- Fix the withdrawal function to prevent reentrancy.
- Use a ReentrancyGuard or a boolean lock.

## Code Activity:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PalengkeWallet {
    mapping(address => uint256) public balances;

    // 🚩 TODO: Fix the vulnerability
    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        balances[msg.sender] -= amount; // Update balance after
    }
}
```

**Hints:**

- Deduct balances before making the external call.
- Consider using a ReentrancyGuard for extra security.

## Expected answer (flagged)

```solidity
// 🚩 ANSWER: Deduct balances before external call
balances[msg.sender] -= amount;

// 🚩 ANSWER: Use Checks-Effects-Interactions pattern
(bool success, ) = msg.sender.call{value: amount}("");
require(success, "Transfer failed");

```
