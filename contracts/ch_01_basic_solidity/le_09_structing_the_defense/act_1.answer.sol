// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CustomerRegistry {
    struct Customer {
        string name;
        address walletAddress;
        uint256 balance;
    }

    mapping(address => Customer) public customers;

    function addCustomer(string memory _name, uint256 _balance) public {
        customers[msg.sender] = Customer({
            name: _name,
            walletAddress: msg.sender,
            balance: _balance
        });
    }

    function getCustomer(
        address _walletAddress
    ) public view returns (string memory, address, uint256) {
        Customer memory customer = customers[_walletAddress];
        return (customer.name, customer.walletAddress, customer.balance);
    }
}
