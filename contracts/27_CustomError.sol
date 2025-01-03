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
