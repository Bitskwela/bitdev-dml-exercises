## Smart Contract Activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// 🚩 TODO: Declare a custom error for unauthorized access
error UnauthorizedAccess(address caller);

// 🚩 TODO: Declare a custom error for insufficient funds
error InsufficientFunds(uint256 requested, uint256 available);

contract CustomErrorExample {
    address public owner;
    uint256 public totalBalance;

    constructor() {
        owner = msg.sender;
        totalBalance = 1000; // Initial balance for testing
    }

    // Function to withdraw funds
    function withdraw(uint256 amount) public {
        // 🚩 TODO: Use the UnauthorizedAccess custom error for non-owners
        if (msg.sender != owner) {
            revert UnauthorizedAccess(msg.sender);
        }

        // 🚩 TODO: Use the InsufficientFunds custom error for insufficient balance
        if (amount > totalBalance) {
            revert InsufficientFunds(amount, totalBalance);
        }

        totalBalance -= amount;
    }

    // Function to check balance
    function checkBalance() public view returns (uint256) {
        return totalBalance;
    }
}
```

# Task for Learners

- Define a custom error related to insufficient funds.
- Implement a function that uses this custom error to revert on failure.
- Optimize error handling by replacing require or revert strings with custom errors.

### Breakdown of the Activity

**Custom Errors Defined**

- `UnauthorizedAccess(address caller)`: Throws if a non-owner tries to withdraw funds.
- `InsufficientFunds(uint256 requested, uint256 available)`: Throws if the withdrawal amount exceeds the balance.

**Functions**

- `withdraw`: Checks if the caller is the contract owner. If not, reverts with `UnauthorizedAccess`.

  Validates the balance is sufficient. If not, reverts with `InsufficientFunds`.

- `checkBalance`: Returns the current total balance.

#### Example Usage

**Successful Withdrawal:**

- Caller: Owner
- Amount: Less than or equal to `totalBalance`.
- Outcome: `totalBalance` reduces, function completes successfully.

**Failure Scenarios:**

- Unauthorized Caller: Reverts with `UnauthorizedAccess`.
- Insufficient Balance: Reverts with `InsufficientFunds`.

### Closing Story

Neri’s team successfully deploys the updated defensive contracts equipped with custom error handling. Hackana’s attempts to disrupt the blockchain are met with efficient and gas-optimized responses.

Thanks to their robust design, the community’s digital infrastructure remains intact, and Neri is hailed as the heroine who safeguarded decentralized systems for all.
