---
title: "Waking Up to Chaos"
description: "A short description of this document."

# This is the date the document was last updated.  Format: YYYY-MM-DD.  
date: "2025-03-01"

# For SEO purposes
tags: ["markdown", "metadata", "example"]

# Currently supported types: 
# NormalExercise - Just a simple module.  Does not require user input.
# ActivityExercise - Where the user needs to submit a code and verify.  As of now, no backend verification.
# May be supported in the future:
# VideoExercise - For exercises that are just videos.
type: "NormalExercise"

# Note: Permanames are unique and immutable. Once set, they cannot be changed.  You may change the filename but not this.
permaname: "waking-up-to-chaos"

# Can be the same as permaname but can be changed if needed.
slug: "waking-up-to-chaos"
---

# Waking Up to Chaos
## Scene
Neri starts her day in San Juan City. Her news feed is filled with reports of system glitches: double charges on transport, failed payments at palengkes (wet markets), and delays in online banking. On her way to work, she encounters issues like malfunctioning jeepney QR scanners and overhears a vendor struggling with a GCash payment.

Neri begins her journey to revolutionize the Philippines' chaotic systems by revisiting what she learned about blockchain. She knows that blockchain’s transparency, immutability, and decentralization can prevent issues like double charges and payment failures.

To help her start, let's dive into the fundamentals of Solidity: Contracts, State Variables, and Pragma. These are the building blocks of any smart contract, much like how jeepney routes and stops are vital to organized commuting.

Neri realizes that just like her morning starts with a solid plan (coffee, commute, and news), any blockchain application starts with a contract — a blueprint for defining what the system should do. She decides to create her first blockchain contract to simulate a simple, immutable record-keeping system for payments.

Solidity Topics:
- **Contracts**: A contract in Solidity is like a container for the logic and data of your application. It’s where you define what your application does and how it behaves.
- **Pragma**: The pragma specifies the version of the Solidity compiler to use, ensuring your code works as intended without unexpected behavior. It’s like specifying the operating system version for running an app.
- **State Variables**: These are variables that hold data, similar to a notebook where Neri might jot down payment records from jeepneys or palengkes. They are stored permanently on the blockchain.

## Sample Syntax
A `contract` in Solidity is similar to a class in object-oriented programming. It is the core building block of Ethereum applications, where you define variables, functions, and logic.

```
contract MyFirstContract {
    // Contract content goes here
}
```

The `pragma` directive specifies the Solidity compiler version the contract is compatible with. This ensures your code runs as intended with a specific compiler version.

```
pragma solidity ^0.8.0;  
```

State variables are used to store persistent data on the blockchain. Their values are saved to the Ethereum blockchain, making them accessible even after contract execution ends.

```
contract StateVariablesExample {
    // Example state variables
    uint256 public count; // Unsigned integer to store a number
    address public owner; // Address type to store Ethereum addresses
    string public greeting; // String type to store text
}
```
