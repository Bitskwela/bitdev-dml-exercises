// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TransactionTracker {
    // 🚩 Task 1: Declare state variables to store caller address and transaction time
    address public caller;
    uint256 public transactionTime;

    // 🚩 Task 2: Function to log caller address and timestamp
    function logTransaction() public {
        // Store the caller's address and current block timestamp
        caller = msg.sender; // Global variable to get the function caller's address
        transactionTime = block.timestamp; // Global variable for the current block's timestamp
    }
}
