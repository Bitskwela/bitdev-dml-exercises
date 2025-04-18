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
