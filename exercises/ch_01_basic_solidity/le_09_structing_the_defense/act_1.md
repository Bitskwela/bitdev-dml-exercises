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

### Task for Learners

- Define a struct called Customer to store:

  - A customer’s name (string).
  - Their wallet address (address).
  - Their current balance (uint256).

  ```solidity
  struct Customer {
      string name;
      address walletAddress;
      uint256 balance;
  }
  ```

- Create a public mapping called `customers` to store Customer structs, keyed by their wallet address. This allows you to easily look up customer information using their wallet address.

  ```solidity
  mapping(address => Customer) public customers;
  ```

- Write functions to:
  - Add a new customer. This function should take the customer’s name and initial balance as parameters and create a new Customer struct instance. The function should store this instance in the `customers` mapping using the sender’s address as the key.
    ```solidity
    function addCustomer(string memory _name, uint256 _balance) public {
        customers[msg.sender] = Customer({
            name: _name,
            walletAddress: msg.sender,
            balance: _balance
        });
    }
    ```
  - Retrieve customer details. This function should take a wallet address as a parameter and return the associated Customer struct’s fields: name, wallet address, and balance.
    ```solidity
    function getCustomer(
        address _walletAddress
    ) public view returns (string memory, address, uint256) {
        Customer memory customer = customers[_walletAddress];
        return (customer.name, customer.walletAddress, customer.balance);
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
