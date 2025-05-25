// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LiquidityLocker {
    address public owner;
    uint256 public lockEnd;
    mapping(address => uint256) public deposits;

    constructor() {
        owner = msg.sender;
    }

    function deposit() external payable {
        require(msg.value > 0, "Must deposit ETH");
        deposits[msg.sender] += msg.value;
        lockEnd = block.timestamp + 60; // 1 minute lock
    }

    function withdraw() external {
        require(block.timestamp >= lockEnd, "Still locked");
        uint256 amount = deposits[msg.sender];
        require(amount > 0, "No funds");
        deposits[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}
