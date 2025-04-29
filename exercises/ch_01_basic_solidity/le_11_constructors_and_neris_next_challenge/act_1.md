## Smart contract activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayProgram {
    // 🚩 Task 1: State variables to store program details
    string public programName;
    uint256 public startingBalance;

    // 🚩 Task 2: Constructor to initialize the program
    constructor(string memory _programName, uint256 _startingBalance) {
        programName = _programName;
        startingBalance = _startingBalance;
    }

    // 🚩 Task 3: Function to retrieve program details
    function getProgramDetails() public view returns (string memory, uint256) {
        return (programName, startingBalance);
    }
}
```

## Task for Learners

- Use a `constructor` to initialize a community program's name and the starting balance for its funds.
- Add a function to retrieve these details.

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
