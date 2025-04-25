# Task for Learners

- Use a `mapping` to create a simple ledger that stores user balances.
- Add functionality to:

  - Update balances for a given user.
  - Retrieve the balance of a specific user.

## Smart Contract Activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AntiHackanaLedger {
    // 🚩 Task 1: Declare a mapping to track user balances
    mapping(address => uint256) public userBalances;

    // 🚩 Task 2: Function to update user balance
    function updateBalance(address _user, uint256 _newBalance) public {
        userBalances[_user] = _newBalance; // Update the user's balance
    }

    // 🚩 Task 3: Function to retrieve user balance
    function getBalance(address _user) public view returns (uint256) {
        return userBalances[_user]; // Return the user's balance
    }
}
```

### Breakdown of the Activity

**Variables Defined:**

`userBalances`: A mapping that associates a user’s wallet address (`address`) with their balance (`uint256`).

**Key Functions:**

- `updateBalance`:
  Takes a user’s address (`_user`) and a new balance (`_newBalance`) as inputs.
  Updates the `userBalances` mapping with the new value for the specified address.

- `getBalance`:
  Accepts a user’s address (`_user`) as input.
  Fetches and returns the associated balance from the `userBalances` mapping.
