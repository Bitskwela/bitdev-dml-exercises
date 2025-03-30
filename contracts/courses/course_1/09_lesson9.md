---
title: "Structing the Defense"
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
permaname: "structing-the-defense"

# Can be the same as permaname but can be changed if needed.
slug: "structing-the-defense"
---

# _Struct_-ing the Defense

## Scene

After securing a way to map data effectively, Neri realizes she needs to store more complex information. Hackana's malware has been manipulating multiple fields, like customer IDs, purchase histories, and timestamps, all tied to one record.

Neri decides to use Solidity’s struct to create a robust, flexible data model to store multi-field data securely in her decentralized solution.

## Solidity Topics: Struct

A `struct` is a custom data type in Solidity that allows developers to group multiple variables under one structure. It’s ideal for organizing complex data.

### Key Features of Structs

- They can hold different types of data (e.g., `strings`, `integers`, `booleans`).
- Structs can be stored in mappings or arrays for further organization.

**Example:**

```solidity
// Example of Student Struct
struct Student {
    uint256 id;
    string name;
    string course;
}
```

**How to use struct in Solidity**

- Defining a Struct:

  - Use the `struct` keyword

    - Example:

      ```solidity
      // Example of Vehicle Struct
          struct Vehicle {
              uint256 id;
              string make;
              string model;
          }
      ```

- Create and assign values

  - Example:

    ```solidity
    Vehicle newVehicle = Vehicle(1, "Honda", "Civic");
    ```

- Store in a mapping

  - Example:

  ```solidity
    mapping(address => Vehicle) public carOwners;
  ```

- Cheatsheet in accessing and updating fields:

  - Access: `carOwners[msg.sender].model;`

  - Update: `carOwners[msg.sender].model = “BMW”;`

### Task for Learners

- Define a struct called Customer to store:
  - A customer’s name (string).
  - Their wallet address (address).
  - Their current balance (uint256).
- Write functions to:
  - Add a new customer.
  - Retrieve customer details.

## Smart contract activiy

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CustomerRegistry {
    // 🚩 Task 1: Define a struct for customer data
    struct Customer {
        string name;
        address walletAddress;
        uint256 balance;
    }

    // 🚩 Task 2: Create a mapping to store customers by their wallet address
    mapping(address => Customer) public customers;

    // 🚩 Task 3: Add a function to add a new customer
    function addCustomer(string memory _name, uint256 _balance) public {
        customers[msg.sender] = Customer({
            name: _name,
            walletAddress: msg.sender,
            balance: _balance
        });
    }

    // 🚩 Task 4: Add a function to retrieve customer details
    function getCustomer(
        address _walletAddress
    ) public view returns (string memory, address, uint256) {
        Customer memory customer = customers[_walletAddress];
        return (customer.name, customer.walletAddress, customer.balance);
    }
}
```

### Breakdown of Activity

**Struct Defined:**

- Customer:

  - `name` (`string`): Customer’s name.
  - `walletAddress` (`address`): Customer’s wallet address.
  - `balance` (`uint256`): Customer’s current balance.

- Mapping Used:

  - `customers`: Stores `Customer` structs, keyed by their wallet address.

- Key Functions:
  - `addCustomer`:
    - Accepts the customer’s name and initial balance as inputs.
    - Creates a `Customer` struct instance and assigns it to the customers mapping for the sender’s address.
  - `getCustomer`:
    - Takes a wallet address as input.
    - Retrieves the associated `Customer` struct and returns its fields: `name`, `walletAddress`, and `balance`.
