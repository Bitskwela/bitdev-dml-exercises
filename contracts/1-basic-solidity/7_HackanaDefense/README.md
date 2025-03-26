# Neri and the Assertive Checkpoint

## Scene

Neri’s anti-Hackana mission intensifies as the rogue malware starts tampering with crucial government databases, causing data mismatches and unauthorized access.

As she analyzes the issue, Neri identifies the importance of building systems that halt operations completely when a critical error occurs to prevent further damage. To secure her smart contracts, she studies `assert()` and `revert()` in Solidity.

## Solidity Topics: `assert()` and `revert()`

- `assert()`: Used to check for conditions that should never fail under normal execut ion. If the condition evaluates to false, the transaction is reverted, and all changes are undone. It consumes all remaining gas, making it suitable for internal errors or invariants.

  **Example use case: Validating internal states or ensuring critical assumptions remain true.**

- `revert()`: A function that stops execution and reverts the transaction explicitly. It allows you to provide an error message or perform additional cleanup before halting the contract.

  **Example use case: Handling errors and providing user-friendly feedback.**

### Task for Learners

- Use `assert()` to ensure that an important condition, like the integrity of a stored value, always holds.
- Use `revert()` to validate user input and provide a helpful error message when something goes wrong.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HackanaDefense {
    uint256 public criticalData;
    address public owner;

    constructor() {
        owner = msg.sender; // Set contract deployer as owner
    }

    // 🚩 Task 1: Use `assert()` to ensure criticalData never goes negative
    function updateCriticalData(uint256 _newData) public {
        criticalData = _newData;
        assert(criticalData >= 0); // Ensure the value is always non-negative
    }

    // 🚩 Task 2: Use `revert()` to ensure only the owner can update data
    function restrictedUpdate(uint256 _newData) public {
        if (msg.sender != owner) {
            revert("Access denied: Only the owner can update critical data.");
        }
        criticalData = _newData;
    }
}
```

### Breakdown of the Activity

- Variables Defined:

  - criticalData: Tracks a sensitive piece of information in the system.
  - owner: Stores the address of the contract deployer, who is the only one authorized to perform specific actions.

- Key Functions:
  - `updateCriticalData`:
    - Updates the `criticalData` value.
    - Uses a`ssert()` to ensure the `criticalData` is always non-negative.
    - Demonstrates the role of `assert()` in maintaining internal contract consistency.
  - `restrictedUpdate`:
    - Updates the `criticalData` value, but only allows the owner to perform this action.
    - Uses `revert()` to provide a user-friendly error message when an unauthorized user attempts to access this function.

**`assert()`** is used here for internal validation to check invariants like non-negative values.

**`revert()`** halts execution if unauthorized users attempt to modify critical data, ensuring secure access.
