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

# Task for Learners

- Update and use `assert()` on the `updateCriticalData` function to ensure that an important condition, like the integrity of a stored value, always holds. For example, if you have a variable that should never be negative, you can use `assert()` to check this condition.

  ```solidity
    function updateCriticalData(uint256 _newData) public {
        criticalData = _newData;
        assert(criticalData >= 0);
    }
  ```

- Update and use `revert()` on the `restrictedUpdate` function to validate user input and provide a helpful error message when something goes wrong. For instance, if you want to restrict access to a function so that only the contract owner can call it, you can use `revert()` to throw an error if someone else tries to call it.

  ```solidity
    function restrictedUpdate(uint256 _newData) public {
          if (msg.sender != owner) {
              revert("Access denied: Only the owner can update critical data.");
          }
          criticalData = _newData;
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

**`assert()`** is used here for internal validation to check invariants like non-negative values. It ensures that the contract's internal state remains consistent and correct. If the assertion fails, it indicates a serious error in the contract logic, and the transaction is reverted, consuming all gas.

**`revert()`** halts execution if unauthorized users attempt to modify critical data, ensuring secure access. It allows for graceful error handling and provides a clear message to the user about what went wrong, making it easier to debug and understand the contract's behavior.

### Why It Matters

This activity emphasizes the importance of using `assert()` and `revert()` in Solidity to ensure the integrity and security of smart contracts. By implementing these functions, Neri can protect her contracts from unauthorized access and data corruption, ultimately enhancing the reliability of her anti-Hackana mission. Additionally, understanding these mechanisms is crucial for developers to build secure and robust decentralized applications. It also highlights the need for thorough testing and validation in smart contract development to prevent vulnerabilities and ensure user trust.
