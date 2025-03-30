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
