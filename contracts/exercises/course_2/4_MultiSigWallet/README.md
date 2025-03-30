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
