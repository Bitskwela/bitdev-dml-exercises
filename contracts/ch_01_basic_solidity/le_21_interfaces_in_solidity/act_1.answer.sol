// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITransaction {
    function deposit(uint256 amount) external payable;

    function withdraw(uint256 amount) external;

    function checkBalance() external view returns (uint256);
}

contract Marketplace is ITransaction {
    mapping(address => uint256) private balances;

    function deposit(uint256 amount) external payable override {
        require(msg.value == amount, "Amount does not match sent Ether");

        balances[msg.sender] += amount;
    }

    function withdraw(uint256 amount) external override {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function checkBalance() external view override returns (uint256) {
        return balances[msg.sender];
    }
}
