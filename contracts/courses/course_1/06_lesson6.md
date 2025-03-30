---
title: "Protecting the Donation Fund"
description: "A short description of this document."

# This is the date the document was last updated.  Format: YYYY-MM-DD.
date: "2025-03-30"

# For SEO purposes
tags: ["markdown", "metadata", "bitskwela", "solidity"]

# Currently supported types:
# NormalExercise - Just a simple module.  Does not require user input.
# ActivityExercise - Where the user needs to submit a code and verify.  As of now, no backend verification.
# May be supported in the future:
# VideoExercise - For exercises that are just videos.
type: "NormalExercise"

# Note: Permanames are unique and immutable. Once set, they cannot be changed.  You may change the filename but not this.
permaname: "protecting-the-donation-fund"

# Can be the same as permaname but can be changed if needed.
slug: "protecting-the-donation-fund"
---

# Protecting the donation fund

## Scene

Neri’s fight against Hackana intensifies as she encounters a new challenge: unauthorized access attempts to her blockchain-based systems. Hackana’s bots are trying to exploit her donation contracts by calling restricted functions.

Determined to secure her system, Neri learns about function _modifiers_ — a Solidity feature that adds an extra layer of control and protection to her smart contracts.

## Solidity Topics: Function modifiers

What are Function Modifiers?

Function modifiers are used to alter the behavior of functions in Solidity. They allow developers to reuse common logic across multiple functions, ensuring specific conditions are met before or after a function is executed.

### Key Uses of Modifiers:

- Restricting access to certain functions (e.g., only the owner can execute).
- Checking preconditions or postconditions.
- Reducing code duplication by centralizing repetitive checks.

### Sample Syntax:

```solidity
modifier onlyOwner() {
    require(msg.sender == owner, "Not the owner");
    _;
}
```

_The underscore (`_`) is a placeholder that represents the rest of the function’s body. The modifier code runs before the function body by default.\_

### Task for Learners

Secure a function to ensure **only the contract owner** can execute it using a modifier. This task helps learners understand how to centralize access control in their contracts.

### Smart Contract Activity

Here’s a simple donation contract where only the owner can withdraw funds using a function modifier.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SecureFund {
    address public owner;
    uint256 public totalDonations;

    constructor() {
        owner = msg.sender; // Set the deployer as the owner
    }

    // 🚩 Task 1: Add a modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // Function to donate funds
    function donate() public payable {
        require(msg.value > 0, "Donation must be greater than zero");
        totalDonations += msg.value;
    }

    // 🚩 Task 2: Add function modifier to withdraw funds and only the owner can call this
    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
```

### Expected Results:

- Non-owners attempting to call withdraw will see the error: **"Not the owner."**
- Owners can withdraw funds seamlessly, transferring the balance to their address.

### Breakdown of the Activity:

- Variables Defined:
  - `owner`: Stores the address of the contract deployer.
  - `totalDonations`: Tracks the total donations received.
- Modifier Defined:
  - `onlyOwner`: Ensures only the owner can call specific functions, protecting the withdrawal process from unauthorized access.
- Functions:
  - `donate`: Accepts Ether donations and updates the total donations.
  - `withdraw`: Allows the owner to withdraw all funds, but only after passing the onlyOwner modifier check.
- Key Concepts Introduced:
  - Access Control: Demonstrates how to use modifiers to limit who can call specific functions.
  - Dynamic Ownership: The owner is set dynamically during contract deployment.
