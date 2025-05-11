// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITransaction {}

contract Marketplace is ITransaction {
    mapping(address => uint256) private balances;

    function deposit(uint256 amount) external {}

    function withdraw(uint256 amount) external {}

    function checkBalance() external view returns (uint256) {}
}
