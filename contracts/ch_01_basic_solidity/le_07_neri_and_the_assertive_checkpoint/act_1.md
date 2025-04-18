# Task for Learners

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
