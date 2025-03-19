// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EfficientDataTransfer {
    // 🚩 Task 1: Accept a string input using calldata
    function echoData(
        string calldata data
    ) external pure returns (string memory) {
        // Calldata is read-only and more gas-efficient
        return data;
    }

    // 🚩 Task 2: Compare gas efficiency
    function memoryData(
        string memory data
    ) public pure returns (string memory) {
        return data; // Memory allows modifications, less efficient
    }
}
