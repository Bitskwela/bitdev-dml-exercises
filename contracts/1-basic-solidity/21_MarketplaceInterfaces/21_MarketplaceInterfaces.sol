// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 1. Define the Transaction interface
interface ITransaction {
    // 🚩 TODO: Implement deposit function
    function deposit(uint256 amount) external payable;

    // 🚩 TODO: Implement withdraw function
    function withdraw(uint256 amount) external;

    // 🚩 TODO: Implement checkBalance function
    function checkBalance() external view returns (uint256);
}

// 2. Implement the interface in the Marketplace contract
contract Marketplace is ITransaction {
    mapping(address => uint256) private balances;

    // 🚩 TODO: Implement the deposit function
    function deposit(uint256 amount) external payable override {
        require(msg.value == amount, "Amount does not match sent Ether");

        balances[msg.sender] += amount;
    }

    // 🚩 TODO: Implement the withdraw function
    function withdraw(uint256 amount) external override {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    // 🚩 TODO: Implement the checkBalance function
    function checkBalance() external view override returns (uint256) {
        return balances[msg.sender];
    }
}
