# Smart Contract Activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AntiHackanaLedger {
    function updateBalance(address _user, uint256 _newBalance) public {}

    function getBalance(address _user) public view returns (uint256) {}
}
```

## Task for Learners

- Declare a `mapping` to create a simple ledger that stores user balances. This mapping should associate a user's wallet address (`address`) with their balance (`uint256`).

  ```solidity
  mapping(address => uint256) public userBalances;
  ```

- Create a function named `updateBalance` to update balances for a given user. This function should take a user's address and a new balance as parameters.

  ```solidity
  function updateBalance(address _user, uint256 _newBalance) public {
      userBalances[_user] = _newBalance; // Update the user's balance
  }
  ```

- Add a function to retrieve the balance of a specific user. Name this function `getBalance`, and ensure it takes a user's address as a parameter and returns the corresponding balance.

  ```solidity
  function getBalance(address _user) public view returns (uint256) {
      return userBalances[_user];
  }
  ```

### Breakdown of the Activity

**Variables Defined:**

`userBalances`: A mapping that associates a user’s wallet address (`address`) with their balance (`uint256`). This allows the contract to keep track of each user's balance in a decentralized manner. This mapping is public, enabling other contracts or users to access the balance information directly.

**Key Functions:**

- `updateBalance`:
  Takes a user’s address (`_user`) and a new balance (`_newBalance`) as inputs.
  Updates the `userBalances` mapping with the new value for the specified address. This function does not have any access control, meaning anyone can call it to update the balance for any address. In a real-world scenario, you would typically include access control mechanisms to restrict who can update balances.
  This could be done using modifiers or by implementing ownership checks.

- `getBalance`:
  Accepts a user’s address (`_user`) as input.
  Fetches and returns the associated balance from the `userBalances` mapping. This function is marked as `view`, indicating that it does not modify the state of the contract and can be called without sending a transaction. It is important to ensure that the balance retrieval does not expose sensitive information or allow for manipulation of the state. Additionally, consider implementing access control to restrict who can call this function, especially in scenarios where sensitive data might be involved.
