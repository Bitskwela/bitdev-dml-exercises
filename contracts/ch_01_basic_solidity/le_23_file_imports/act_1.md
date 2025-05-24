## Smart Contract Activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Calculator {
    function calculateSum(uint256 x, uint256 y) public {}

    function calculateProduct(uint256 x, uint256 y) public {}
}
```

## Task for Learners

- Import a library named `MathLibrary` that contains reusable functions for addition and multiplication.

  ```solidity
  import "./MathLibrary.sol";
  ```

- Use the library in a contract named `Calculator` to perform addition and multiplication operations and create two functions: `calculateSum` and `calculateProduct` that utilize the library functions.

  ```solidity
  contract Calculator {
      function calculateSum(uint256 x, uint256 y) public pure returns (uint256) {
          return MathLibrary.add(x, y);
      }

      function calculateProduct(
          uint256 x,
          uint256 y
      ) public pure returns (uint256) {
          return MathLibrary.multiply(x, y);
      }
  }
  ```

### Breakdown of Activity

**File Organization:**

- **MathLibrary.sol**: Contains the reusable library logic.

- **Calculator.sol**: Imports the library and uses it in the main contract.

**Import Statement:**

The import `"./MathLibrary.sol";` ensures the library functions are available in the main contract.

**Library Usage:**

`MathLibrary.add(x, y)` and `MathLibrary.multiply(x, y)` are used to execute the operations without duplicating code.

**Reusability:**

This modular approach makes it easy to test, maintain, and extend functionality.

### Closing Story

Neri’s team, equipped with modular libraries, deploys their newly organized smart contract system. The strategy pays off as they swiftly counter Hackana’s latest attack.

This victory solidifies their belief in the importance of reusable, modular code in defending decentralized systems.
