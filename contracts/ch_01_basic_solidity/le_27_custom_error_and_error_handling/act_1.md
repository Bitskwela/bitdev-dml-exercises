## Smart Contract Activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract CustomErrorExample {
    address public owner;
    uint256 public totalBalance;

    constructor() {
        owner = msg.sender;
        totalBalance = 1000;
    }

    function withdraw(uint256 amount) public {
        if (msg.sender != owner) {}

        if (amount > totalBalance) {}

        totalBalance -= amount;
    }

    function checkBalance() public view returns (uint256) {
        return totalBalance;
    }
}
```

# Task for Learners

- Define a custom error related to insufficient funds. (Should be defined at the top of the contract)
  ```solidity
  error InsufficientFunds(uint256 requested, uint256 available);
  ```
- Define a custom error for unauthorized access. (Should be defined at the top of the contract)

  ```solidity
  error UnauthorizedAccess(address caller);
  ```

- Inside the `withdraw` function, implement the custom errors for better error handling.

  ```solidity
  function withdraw(uint256 amount) public {
      if (msg.sender != owner) {
          revert UnauthorizedAccess(msg.sender);
      }

      if (amount > totalBalance) {
          revert InsufficientFunds(amount, totalBalance);
      }

      totalBalance -= amount;
  }
  ```

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
