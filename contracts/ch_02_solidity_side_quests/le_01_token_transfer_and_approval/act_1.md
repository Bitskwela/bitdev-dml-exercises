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