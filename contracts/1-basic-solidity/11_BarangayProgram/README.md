# Constructors – Neri’s Next Challenge

## Scene

As Neri continues to refine her blockchain solutions, she is approached by a local barangay official. The barangay has been struggling to implement an efficient registration system for residents availing of community programs like ayuda distribution and disaster relief.

Each time a program starts, they manually input basic information, causing delays and errors.

The official asks, **“Puwede mo bang gawing automated ito, at ready agad kapag simulan namin ang programa?”** (_Can you automate this so it’s ready as soon as we start the program?_)

Neri smiles and thinks about constructors in Solidity. She realizes she can create a smart contract that initializes important information (like program details) right when the contract is deployed, saving time and effort.

## Solidity Topics: Constructor

### How to use Constructor

A constructor is a special function in Solidity that runs only once—at the time the contract is deployed. It’s typically used to initialize state variables or set up critical configurations for the contract.

#### Key Points:

- A contract can only have one `constructor`.
- Constructors can accept arguments, allowing deployment-time customization.
- It’s optional—if no constructor is defined, Solidity creates a default constructor.

#### Example usage

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ConstructorExample {
    uint256 public value;

    // Constructor to initialize `value`
    constructor(uint256 _initialValue) {
        value = _initialValue;
    }
}
```

### Use Cases:

- Setting up admin roles.
- Initializing state variables like tokens or program details.
- Configuring contract parameters for specific use cases.

### Task for Learners

- Use a `constructor` to initialize a community program's name and the starting balance for its funds.
- Add a function to retrieve these details.

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
