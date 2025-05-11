// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TransactionTracker {
    address public caller;
    uint256 public transactionTime;

    function updateTransaction() public {
        caller = msg.sender;
        transactionTime = block.timestamp;
    }
}
