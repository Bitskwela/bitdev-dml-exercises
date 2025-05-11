# Libraries of Hope

## Scene

A New Ally in the Fight Against Hackana

Neri’s battle against Hackana intensifies. She finds herself overwhelmed by the sheer complexity of the attacks, with Hackana spreading chaos through vulnerabilities in digital wallets and public infrastructures.

As she consults her blockchain tools, she remembers a powerful concept she once learned: **libraries**.

Libraries act as powerful utilities, reusable modules that can simplify complex logic and enable secure, reliable functions. With this new realization, Neri crafts a library she can deploy quickly to bolster San Juan City's defenses against Hackana's malware, focusing on wallet encryption and transaction validation.

## Solidity Topics: Libraries

**What are Libraries in Solidity?**

Libraries in Solidity are reusable, stateless pieces of code that help developers avoid redundancy. These are particularly useful for performing complex calculations or tasks that need to be repeated across multiple smart contracts.

Libraries cannot hold state or be destroyed, ensuring that their logic is consistent and reliable.

### Key Characteristics of Libraries:

- Libraries are deployed only once and can be linked to other contracts.
- Functions in libraries can be called using `libraryName.functionName` or attached to a type.
- They cannot have state variables, inherit other contracts, or receive Ether.

### When to Use Libraries?

- When you need reusable code across multiple contracts.
- For offloading frequently used, gas-intensive operations to a shared module.

### Example on how Libraries works

**1. Define the library**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Define the library
library MathLibrary {
    // Function to add 2 numbers
    function add(uint256 a, uint256 b) internal pure returns(uint256) {
        return a + b;
    }

    // Function to subract 2 numbers
    function subtract(uint256 a, uint256 b) internal pure
    returns (uint256) {
        require(a >= b, "Underflow. a is less than b");
        return a - b;
    }
}
```

**2. Use the defined library on another contract:**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import the library
import "./MathLibrary.sol";

contract Calculator {
    // Use the functions from the MathLibrary
    function getSum(uint256 x, uint256 y) public pure returns(uint256) {
        return MathLibrary.add(x, y);
    }

    function getDifference(uint256 x, uint256 y) public pure returns(uint256) {
        return MathLibrary.subtract(x, y);
    }
}
```

**Library Definition:**

- `MathLibrary` is a stateless library containing reusable functions (add and subtract) to handle arithmetic operations.
- The `internal` keyword ensures the functions are only accessible within the same contract or contracts that use the library.

**Library Usage:**

- The **Calculator** contract imports the library to access its functions.
- Functions like `getSum` and `getDifference` utilize the library’s operations directly.

**Key Points:**

- Libraries avoid code duplication and enhance modularity.
- They are useful for tasks like math operations, string manipulations, or any shared logic.
- Use `libraryName.functionName` to call the library functions.
