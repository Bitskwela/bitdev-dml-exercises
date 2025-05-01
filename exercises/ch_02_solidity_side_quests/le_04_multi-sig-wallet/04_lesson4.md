---
title: "Side Quest 4: Multi-Signature Wallet"
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
permaname: "sq-4-multi-sig-wallet"

# Can be the same as permaname but can be changed if needed.
slug: "sq-4-multi-sig-wallet"
---

# Side Quest 4: Multi-Signature Wallet

## Scenario:

Hackana’s minions disabled trust among digital board members. Neri needs to implement a multisig wallet to restore trust for large fund transfers.

- Time Allotment: 20 minutes
- Solidity Topics Covered: Multisig Wallets, Threshold Approval Logic.
- Checklist: Minimum approvals required for execution, track signatories.

## TODO:

- Implement logic for requiring multiple signatures.
- Add a function to execute transactions after threshold approvals.

## Code Activity:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultiSigWallet {
    address[] public signers;
    uint256 public approvalThreshold;

    constructor(address[] memory _signers, uint256 _threshold) {
        signers = _signers;
        approvalThreshold = _threshold;
    }

    // 🚩 TODO: Track approvals and execute only when threshold is met
    function executeTransaction() public {
        // Logic to check approvals
    }
}
```

**Hints:**

- Track approvals using a mapping.
- Require `approvalThreshold` to be met before executing.

## Expected answer (flagged)

```solidity
// 🚩 ANSWER: Track approvals
mapping(address => bool) public approvals;

// 🚩 ANSWER: Check threshold and execute
require(approvalCount >= approvalThreshold, "Not enough approvals");
```
