// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HackanaDefense {
    uint256 public criticalData;
    address public owner;

    constructor() {
        owner = msg.sender; // Set contract deployer as owner
    }

    // 🚩 Task 1: Use `assert()` to ensure criticalData never goes negative
    function updateCriticalData(uint256 _newData) public {
        criticalData = _newData;
        assert(criticalData >= 0); // Ensure the value is always non-negative
    }

    // 🚩 Task 2: Use `revert()` to ensure only the owner can update data
    function restrictedUpdate(uint256 _newData) public {
        if (msg.sender != owner) {
            revert("Access denied: Only the owner can update critical data.");
        }
        criticalData = _newData;
    }
}
