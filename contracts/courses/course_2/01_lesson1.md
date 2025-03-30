---
title: "Token Transfer with Approval System"
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
permaname: "sq-1-token-transfer-and-approval"

# Can be the same as permaname but can be changed if needed.
slug: "sq-1-token-transfer-and-approval"
---

# Side Quest 1: Token Transfer with Approval System

## Scenario:

The San Juan Digital Payment System is recovering, but Hackana’s minions tampered with the ERC20 token approval mechanism, creating issues in transferring funds securely between vendors and customers. Neri must fix it.

- Time Allotment: 20 minutes
- Solidity Topics Covered: ERC20, Allowances, and Approvals.
- Checklist: Approvals should restrict overspending; tokens transfer correctly.

## TODO:

Create a function to approve and transfer tokens securely.
Prevent overspending by validating allowances.

## Code activity:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// ERC20 Mock Contract
contract PaymentFixer {
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowances;

    constructor() {
        // Initial token allocation
        balances[msg.sender] = 1000;
    }

    // 🚩 TODO: Implement the approve function
    function approve(address spender, uint256 amount) public {
        allowances[msg.sender][spender] = amount;
    }

    // 🚩 TODO: Fix the transferFrom logic to respect allowances
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public {
        require(allowances[sender][msg.sender] >= amount, "Allowance exceeded");
        require(balances[sender] >= amount, "Insufficient balance");

        allowances[sender][msg.sender] -= amount;
        balances[sender] -= amount;
        balances[recipient] += amount;
    }
}

```

**Hints:**

- Modify `transferFrom` to ensure allowances are updated after each transaction.
- Double-check balance and allowance conditions.

## Expected answers (flagged)

```solidity
// 🚩 ANSWER: Deduct from allowances
allowances[sender][msg.sender] -= amount;

// 🚩 ANSWER: Update sender and recipient balances
balances[sender] -= amount;
balances[recipient] += amount;
```
