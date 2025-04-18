// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayWallet {
    // 🚩 Task 1: State variable to track total Ether received
    uint256 public totalReceived;

    // 🚩 Task 2: Receive function to handle direct Ether transfers
    receive() external payable {
        totalReceived += msg.value;
    }

    // 🚩 Task 3: Fallback function to handle invalid calls
    fallback() external payable {
        // Log invalid calls
        emit InvalidCall(msg.sender, msg.value, msg.data);
    }

    // Event for logging fallback activity
    event InvalidCall(address sender, uint256 value, bytes data);
}
