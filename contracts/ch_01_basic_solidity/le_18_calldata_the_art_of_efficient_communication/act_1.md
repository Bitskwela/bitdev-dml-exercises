## Smart Contract Activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EfficientDataTransfer {
    // Task 1: Accept a string input using calldata
    function echoData() external pure returns (string memory) {}

    // Task 2: Compare gas efficiency
    function memoryData() public pure returns (string memory) {}
}
```

# Task for Learners

Hackana is exploiting contracts with inefficient memory usage during external function calls. Your task is to:

- Complete the function `echoData` and accepts a `calldata` input.

  ```solidity
    function echoData(string calldata data) external pure returns (string memory) {
        return data;
    }

  ```

- Implement the function `memoryData` to accept a `memory` input.
  ```solidity
      function memoryData(string memory data) public pure returns (string memory) {
            return data;
    }
  ```
