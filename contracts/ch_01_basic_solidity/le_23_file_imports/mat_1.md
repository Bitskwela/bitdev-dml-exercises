# File Imports

![23.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_23_file_imports/23.0%20-%20COVER.png)

## Scene

Neri’s team has created multiple reusable code snippets, such as libraries and interfaces, to speed up development during their battle against Hackana. As she organizes her files, she realizes that importing these files will simplify her main contract.

With Hackana’s next attack targeting cryptographic vulnerabilities, Neri must quickly utilize her imported tools.

## Solidity Topics: File Imports

![23.1 - File Imports](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_23_file_imports/23.1.png)

### How to use

In Solidity, the import statement allows developers to include code from other files into a smart contract. This practice helps in organizing the codebase by splitting logic into reusable modules.

### More Info about File imports

**Syntax for importing files**

```solidity
import "./FileName.sol"; // Relative path
import "@openzeppelin/contracts/utils/Address.sol"; // Package import
```

**Best practices**

- Use relative paths (`./`) for local imports.
- Prefer libraries like _OpenZeppelin_ for standardized solutions.
- Keep file structures logical and maintainable.

**Example use cases**

- Reusing libraries, interfaces, or custom error definitions.

### Sample file imports in Solidity

**Example 1** – Importing a local file. You can organize your contracts by placing related code into separate files and importing them.

```solidity
// File: MathLibrary.sol
pragma solidity ^0.8.0;

library MathLibrary {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }
}
```

Now import **MathLibrary** in another file:

```solidity
// File: Calculator.sol
pragma solidity ^0.8.0;

import "./MathLibrary.sol"; // Importing from the same directory

contract Calculator {
    function calculateSum(uint256 x, uint256 y) public pure returns (uint256) {
        return MathLibrary.add(x, y);
    }
}
```

**Example 2** – Importing file from Openzeppelin. Many Solidity projects rely on prebuilt libraries like OpenZeppelin.

```solidity
// Importing from an Openzeppelin package
import "@openzeppelin/contracts/utils/Address.sol";

contract Example {
    using Address for address;

    function checkIfContract(address account) public view returns (bool) {
        return account.isContract();
    }
}
```

#### Explanation

**Local File Imports (./)**

Use `./` to refer to files in the same directory.

_Example:_

`import "./MathLibrary.sol"`

**Third-Party Library Imports**
Use the library path when installed via tools like npm.

_Example:_

`import "@openzeppelin/contracts/utils/Address.sol";`

**Why Use Imports?**

- **Reusability**: Write code once and use it across multiple contracts.
- **Modularity**: Keep contracts clean by separating logic into smaller, maintainable pieces.
- **Standardization**: Use battle-tested libraries like OpenZeppelin to avoid reinventing the wheel.

**Best Practice**

Always verify imported files and ensure compatibility with your Solidity version (`pragma`).

This makes your code clean, reusable, and easier to understand while promoting best practices.
