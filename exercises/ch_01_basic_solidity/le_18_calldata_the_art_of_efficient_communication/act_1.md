# Task for Learners

Hackana is exploiting contracts with inefficient memory usage during external function calls. Your task is to:

- Create a function that accepts a `calldata` input and uses it efficiently.
- Demonstrate how `calldata` can optimize gas usage compared to memory.

## Smart Contract Activity

```solidity
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
```
