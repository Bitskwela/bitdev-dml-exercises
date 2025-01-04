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
