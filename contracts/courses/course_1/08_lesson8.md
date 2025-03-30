---
title: "Mapping the Problem Away"
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
permaname: "mapping-the-problem-away"

# Can be the same as permaname but can be changed if needed.
slug: "mapping-the-problem-away"
---

# Mapping the problem away

## Scene

Neri tracks Hackana’s digital trail and discovers it’s siphoning funds and data by exploiting poorly managed user records in centralized systems. To counteract, she decides to build a decentralized data registry using Solidity’s mapping, which efficiently organizes and retrieves data.

Neri realizes that by designing a robust mapping-based solution, she can secure sensitive data like user balances, records, or permissions against tampering.

## Solidity Topics: `mapping`

A `mapping` is a reference type in Solidity that associates keys to values. It functions like a dictionary or hash table and is highly efficient for lookups.

**Syntax:**

```solidity
mapping(address => uint256) public balances;
```

**Key Characteristics:**

- Keys are unique and can’t be iterated directly (no for loop).
- Common key types: `address`, `uint`, `bytes32`.
- Common value types: `uint`, `bool`, `string`, or even nested `mappings`.

**How to use mapping in Solidity**

- Declare a Mapping:

  - Syntax: `mapping(keyType => valueType) visibility name;`
  - Example: `mapping(address => uint256) public balances;`
    - **Explanation**: This maps the user address and their corresponding balances
      - `keyType: address` (user address).
      - `valueType: uint256` (user balance).

- Setting a mapping’s value:

  - Use the `mappingName[key] = value` syntax.

    **Example:** `balances[msg.sender] = 1000;`

    - **Explanation**: We’re assigning 1000 balance to the sender’s address

- Retrieving a mapping value:

  - Access the value using the `mappingName[key]` syntax.

    **Example:** `uint256 myBalance = balances[msg.sender];`

    - **Explanation:** We’re retrieving the sender’s balance by referencing it’s wallet address as a parameter

- Update a Value: - Simply assign a new value to the key.
  - **Example**: `balances[msg.sender] = balances[msg.sender] + 500;`
    - **Explanation**: We’re assigning additional `500` balance on the sender’s current balance

## Task for Learners

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
