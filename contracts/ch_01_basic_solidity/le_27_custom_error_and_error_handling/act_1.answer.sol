// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

error UnauthorizedAccess(address caller);

error InsufficientFunds(uint256 requested, uint256 available);

contract CustomErrorExample {
    address public owner;
    uint256 public totalBalance;

    constructor() {
        owner = msg.sender;
        totalBalance = 1000;
    }

    function withdraw(uint256 amount) public {
        if (msg.sender != owner) {
            revert UnauthorizedAccess(msg.sender);
        }

        if (amount > totalBalance) {
            revert InsufficientFunds(amount, totalBalance);
        }

        totalBalance -= amount;
    }

    function checkBalance() public view returns (uint256) {
        return totalBalance;
    }
}
