# Smart contract activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayProgram {
    string public programName;
    uint256 public startingBalance;
}
```

## Task for Learners

- Use a `constructor` to initialize a community program's name and the starting balance for its funds.

  ```solidity
      constructor(string memory _programName, uint256 _startingBalance) {
          programName = _programName;
          startingBalance = _startingBalance;
      }
  ```

- Add a function named `getProgramDetails` to retrieve these details.

  ```solidity
      function getProgramDetails() public view returns (string memory, uint256) {
          return (programName, startingBalance);
      }
  ```

### Breakdown of Activity

**State Variables Defined:**

`programName`: Stores the name of the community program.

`startingBalance`: Holds the initial fund allocated to the program.

**Constructor Defined:**

```solidity
constructor(string memory _programName, uint256 _startingBalance)
```

This code performs the following:

- Accepts the program name and the starting balance as arguments when the contract is deployed.
- Initializes the programName and startingBalance state variables.

**Key Function:**

`getProgramDetails`: Returns the program name and starting balance as a tuple.
