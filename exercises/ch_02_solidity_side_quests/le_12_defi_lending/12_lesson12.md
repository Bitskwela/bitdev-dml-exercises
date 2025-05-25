---
title: "Sidequest #12: DeFi Lending Contract (Lend and Earn Interest)"

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
permaname: "sq-12-defi-lending"

# Can be the same as permaname but can be changed if needed.
slug: "sq-12-defi-lending"
---

# Sidequest #12: DeFi Lending Contract (Lend and Earn Interest)

## Backstory:

After securing the community’s infrastructure, Neri continues her mission to make the local economy more resilient. She realizes that one way to help the people is by providing a DeFi Lending Platform. In this platform, people can lend their tokens and earn interest over time.

Neri builds a simple Lending Contract where users can deposit ERC20 tokens and earn interest. However, the contract needs to ensure:

- Users can deposit tokens and start earning interest.
- Interest is calculated dynamically based on the deposit duration.
- Users can withdraw their tokens along with the accumulated interest.
- This is Neri’s next challenge. The platform must be simple but secure, allowing people to benefit from their tokens without risking them in risky investments.

## Problem Overview:

You are tasked with creating a DeFi Lending Contract where users can lend their tokens and earn interest over time. The contract should allow the following:

- Users deposit ERC20 tokens and start earning interest.
- Users can withdraw both the principal amount and earned interest.
- The contract should calculate the interest based on the time the user has staked their tokens.
- The interest rate can be fixed for simplicity, but the key challenge is to handle deposits, calculate interest, and allow withdrawals correctly.

## Time Allotment: 20 minutes

## Solidity Topics Covered:

- ERC20 Token Interactions – Working with ERC20 tokens for deposits and withdrawals.
- Mappings – Tracking users' deposits, withdrawals, and earned interest.
- Interest Calculations – Implementing basic financial calculations based on time.
- Modifiers – Ensuring that only valid actions are performed (e.g., deposit, withdraw).
- Events – Logging important actions for transparency.

## Code activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DeFiLending is Ownable {
    IERC20 public lendingToken;  // The ERC20 token that will be lent
    uint256 public interestRate = 5;  // Annual interest rate in percentage

    // Mapping to store the user's deposit and the timestamp of their deposit
    mapping(address => uint256) public userDeposits;
    mapping(address => uint256) public depositTimestamp;

    // 🚩 TODO: Implement constructor to set the lending token
    constructor(IERC20 _lendingToken) {
        lendingToken = _lendingToken;
    }

    // 🚩 TODO: Implement the deposit function where users can lend their tokens
    function deposit(uint256 amount) external {
        require(amount > 0, "Deposit amount must be greater than 0");

        // 🏁 ANSWER: Transfer tokens to the contract
        lendingToken.transferFrom(msg.sender, address(this), amount);

        // Record the user's deposit and timestamp
        userDeposits[msg.sender] += amount;
        depositTimestamp[msg.sender] = block.timestamp;

        emit Deposited(msg.sender, amount);
    }

    // 🚩 TODO: Implement the withdrawal function
    function withdraw(uint256 amount) external {
        require(userDeposits[msg.sender] >= amount, "Insufficient balance to withdraw");

        // 🏁 ANSWER: Calculate earned interest
        uint256 interest = calculateInterest(msg.sender);
        uint256 totalAmount = amount + interest;

        // Ensure enough tokens are available to withdraw
        require(lendingToken.balanceOf(address(this)) >= totalAmount, "Insufficient contract balance");

        // Update user's deposit and transfer tokens back to the user
        userDeposits[msg.sender] -= amount;
        lendingToken.transfer(msg.sender, totalAmount);

        emit Withdrawn(msg.sender, amount, interest);
    }

    // 🚩 TODO: Implement the interest calculation function
    function calculateInterest(address user) public view returns (uint256) {
        uint256 timeElapsed = block.timestamp - depositTimestamp[user];  // Time in seconds
        uint256 principal = userDeposits[user];

        // 🏁 ANSWER: Simple interest formula: Interest = (Principal * Rate * Time) / (365 * 24 * 60 * 60)
        return (principal * interestRate * timeElapsed) / (365 * 24 * 60 * 60 * 100);
    }

    // 🚩 TODO: Emit events for deposit and withdrawal actions
    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount, uint256 interest);
}
```

## Checklist for Learners:

- Implemented the `deposit` function correctly to handle token deposits and update user records.
- Implemented the `withdraw` function correctly to handle token withdrawals and interest calculation.
- Ensured that the interest is calculated based on time passed since the deposit.
- Handled safety checks to ensure the contract has enough tokens to satisfy withdrawals.
- Emitted events for deposit and withdrawal actions to track user interactions.

## Hints:

- Interest Calculation: A simple way to calculate interest is using the formula Interest = Principal _ Rate _ Time, where Rate is fixed (e.g., 5% per annum).
- Mapping Usage: Track the deposits and the last timestamp when a user deposited tokens.
- Time Mechanism: Use block.timestamp to calculate how long the user has kept their tokens in the contract.
- Withdrawal Safety: Make sure that withdrawals cannot exceed the user's available balance (including interest).

## Additional hints

- The interest calculation should be done using the simple interest formula, but you can always adjust it to suit your needs.
- Time Calculation: Use `block.timestamp` to get the current block timestamp and calculate how long the user’s tokens have been in the contract.
- Make sure to emit events for transparency and to track user activities in the system.

## Expected answer (flagged)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DeFiLending is Ownable {
    IERC20 public lendingToken;  // The ERC20 token that will be lent
    uint256 public interestRate = 5;  // Annual interest rate in percentage

    // Mapping to store the user's deposit and the timestamp of their deposit
    mapping(address => uint256) public userDeposits;
    mapping(address => uint256) public depositTimestamp;

    constructor(IERC20 _lendingToken) Ownable(msg.sender) {
        lendingToken = _lendingToken;
    }


    function deposit(uint256 amount) external {
        require(amount > 0, "Deposit amount must be greater than 0");

        // Transfer tokens to the contract
        lendingToken.transferFrom(msg.sender, address(this), amount);

        // Record the user's deposit and timestamp
        userDeposits[msg.sender] += amount;
        depositTimestamp[msg.sender] = block.timestamp;

        emit Deposited(msg.sender, amount);
    }

    function withdraw(uint256 amount) external {
        require(userDeposits[msg.sender] >= amount, "Insufficient balance to withdraw");

        // Calculate earned interest
        uint256 interest = calculateInterest(msg.sender);
        uint256 totalAmount = amount + interest;

        // Ensure enough tokens are available to withdraw
        require(lendingToken.balanceOf(address(this)) >= totalAmount, "Insufficient contract balance");

        // Update user's deposit and transfer tokens back to the user
        userDeposits[msg.sender] -= amount;
        lendingToken.transfer(msg.sender, totalAmount);

        emit Withdrawn(msg.sender, amount, interest);
    }

    function calculateInterest(address user) public view returns (uint256) {
        uint256 timeElapsed = block.timestamp - depositTimestamp[user];  // Time in seconds
        uint256 principal = userDeposits[user];

        // Simple interest formula: Interest = (Principal * Rate * Time) / (365 * 24 * 60 * 60)
        return (principal * interestRate * timeElapsed) / (365 * 24 * 60 * 60 * 100);
    }

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount, uint256 interest);
}
```

## Final thoughts

This contract introduces a simple DeFi Lending Platform, which allows users to lend tokens and earn interest over time. Users can deposit ERC20 tokens, earn interest based on how long their tokens have been in the contract, and later withdraw both their principal and earned interest. This contract mimics how traditional lending works, but in the decentralized world, providing benefits to both users and the platform.
