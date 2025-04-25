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
