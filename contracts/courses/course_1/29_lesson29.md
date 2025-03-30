---
title: "Writing Secured Smart Contracts"

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
type: "ActivityExercise"

# Note: Permanames are unique and immutable. Once set, they cannot be changed.  You may change the filename but not this.
permaname: "writing-smart-contracts"

# Can be the same as permaname but can be changed if needed.
slug: "writing-smart-contracts"
---

# Writing Secured Smart Contracts

## Scene: The Final Showdown

The battle reaches its peak. Hackana, furious over its inability to breach Neri's defenses, unleashes a catastrophic attack aimed at destabilizing the entire blockchain infrastructure.

As chaos looms, Neri rallies her team one last time. They realize that ultimate security lies not just in technology but in thoughtful design. Together, they craft an unbreachable fortress: a secure smart contract that withstands even Hackana's most devious exploits.

## Solidity Topic: Writing Secured Smart Contracts

**What is a Secure Smart Contract?**

A secure contract is one that is resistant to common vulnerabilities, ensuring that funds, data, and functionality remain protected from malicious actors. Security is a mindset that permeates every line of code.

### Best Practices for Security in Solidity

- Check for Reentrancy: Prevent functions from being called before their execution is complete.
  - Use `checks-effects-interactions` pattern.
  - Implement the `ReentrancyGuard` from OpenZeppelin.
- Validate Input: Always validate user inputs and parameters using `require()` or `revert()`.
- Avoid Floating Pragma: Lock the compiler version to prevent unexpected behavior in new releases.
- Use Access Control: Restrict sensitive functions with `onlyOwner` or other modifiers.
- Avoid tx.origin for Authentication: Use msg.sender instead.
- Test Extensively: Run audits and use testing tools like MythX and Slither.

### Example Key Security Best Practices

Checks-Effects-Interaction Pattern – The **Checks-Effects-Interactions pattern** is a best practice in Solidity to avoid reentrancy attacks and ensure safer contract execution. It involves organizing the steps of a function in three phases:

**Checks:** Validate the conditions and inputs before making any state changes.

- Ensure the caller is authorized or that the parameters are correct.

**Effects:** Modify the contract's state after validation.

- Update state variables to reflect changes caused by the function execution.

**Interactions:** After validating and updating state, interact with external contracts (e.g., transferring tokens, calling other contracts).

- Interactions should be done last to avoid potential reentrancy attacks.

By following this pattern, you prevent external calls (like transfers or contract interactions) from affecting the contract's state before it is updated, thus mitigating the risk of reentrancy.

#### Code example

```solidity
function safeTransfer(address recipient, uint256 amount) public {
    require(balances[msg.sender] >= amount, "Insufficient balance."); // Checks
    balances[msg.sender] -= amount; // Effects
    (bool success, ) = recipient.call{value: amount}(""); // Interactions
    require(success, "Transfer failed.");
}
```

**In this example:**

- Checks: Ensure the sender has enough balance.
- Effects: Decrease the sender's balance before interacting with the recipient.
- Interactions: Finally, transfer funds to the recipient, ensuring that the contract state is updated before any external interactions.

**Reentrancy Guard** – A Reentrancy Guard is a security feature that **prevents reentrancy attacks**, a common vulnerability in smart contracts where an external contract calls back into the calling contract before its initial execution is finished. This can lead to unintended outcomes, such as draining funds from a contract.

The `ReentrancyGuard` is provided by OpenZeppelin's library, which introduces a nonReentrant modifier to functions. This modifier ensures that the function cannot be re-entered during its execution. If the function is already being executed, any subsequent calls will fail until the first execution is completed.

**Code Example:**

```solidity
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
contract SafeContract is ReentrancyGuard {
    function safeAction() public nonReentrant {
        // Add Logic here
    }
}
```

_In this example, the nonReentrant modifier ensures that the withdraw function cannot be called again before the previous one is finished, preventing reentrancy attacks._

### Smart Contract Activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import OpenZeppelin utilities for security
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract SecureDonation is Ownable, ReentrancyGuard {
    constructor() Ownable(msg.sender) ReentrancyGuard() {}

    // State variable to track total donations
    uint256 public totalDonations;

    // Mapping to store donations per user
    mapping(address => uint256) public donations;

    // Function to accept donations
    function donate() external payable nonReentrant {
        require(msg.value > 0, "Donation must be greater than zero.");

        // 🚩 TODO: Update the state variable (donations mapping) first before updating totalDonations
        donations[msg.sender] += msg.value;
        totalDonations += msg.value;
    }

    // 🚩 TODO: Add a function for the owner to withdraw funds. Add reentrancy guard
    function withdraw() external onlyOwner nonReentrant {
        require(totalDonations > 0, "No funds to withdraw.");

        // Transfer all funds to the owner
        (bool success, ) = owner().call{value: address(this).balance}("");
        require(success, "Withdrawal failed.");
    }
}
```

#### Breakdown of the Activity

**Imports**:

- `Ownable`: Manages owner-specific functionality.
- `ReentrancyGuard`: Prevents reentrancy attacks.
  **State Variables:**

- `totalDonations`: Tracks the total ETH received.
- `donations`: Maps user addresses to their contributions.

**Donation Function:**

- `donate()`: Accepts ETH while ensuring the donation is non-zero.
- nonReentrant: Blocks reentrancy attacks.

**Withdraw Function:**

- Restricted to the `owner` via `onlyOwner`.
- Transfers contract balance safely using `.call`.

## Closing Story

As Neri's secure smart contract goes live, Hackana's final attack begins. However, every exploit attempt is met with impenetrable defenses. Reentrancy attacks fail, input manipulations are rejected, and funds remain protected. With no vulnerabilities left to exploit, Hackana disintegrates, defeated by Neri's brilliance.

The city of San Juan rejoices, its blockchain infrastructure restored and fortified. Neri's journey inspires a new wave of secure development, ensuring a future where trust in technology is unshakable. She stands as a hero, not just for her technical skills but for her unwavering commitment to a secure digital world.
