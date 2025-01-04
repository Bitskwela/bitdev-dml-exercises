# Sidequest #14: Timelock Token Contract

## Backstory:

In the Philippines, people are often caught in a cycle of financial instability due to unpredictable circumstances like inflation, health crises, and economic fluctuations. Many Filipinos have a hard time saving money because of this. In response, a new initiative called **"SaveNow"** emerges, encouraging Filipinos to save and lock their money for the long term.

Neri, being an ambitious developer, decides to help this initiative by building a timelock token. With this system, people can lock their tokens (representing their savings) for a specific period. The timelock feature ensures that the money cannot be accessed until a predetermined period has passed, encouraging better saving habits and providing a way to fight against impulsive spending.

By using blockchain technology and smart contracts, Neri aims to ensure that the SaveNow token is both secure and transparent, so users can track their locked savings while still ensuring they can't spend it until the set lock period is over.

This challenge will help you understand how to implement a Timelock mechanism in Solidity using an ERC20 token.

## Problem Overview:

In this activity, you will build a timelock contract for a token. The contract will allow a user to lock their tokens for a specific period. The user will not be able to withdraw their tokens before the lock period expires. This smart contract system will be secure, providing a transparent way for users to save for the long term.

The contract should have the following features:

- Users can lock their tokens by specifying a lock duration.
- Users will only be able to withdraw their tokens after the lock duration has passed.
- Ensure that only the owner of the tokens can withdraw them after the lock has expired.
- Use modifiers and require statements to ensure that users cannot access their tokens prematurely.

## Time Allotment: 20 minutes

## Solidity Topics Covered:

- ERC20 Tokens – Create and interact with an ERC20 token.
- Timelock Mechanism – Implement a timelock feature that locks tokens for a specified time.
- Modifiers – Create modifiers to check if the lock time has passed.
- Require Statements – Use require statements to check conditions such as lock expiry.
- Events – Emit events to notify users when tokens are locked or withdrawn.
- Mapping and Structs – Store user-specific lock data in mappings and structs.

## Code Activity:

Initial Contract Template

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TimelockToken {
    // 🚩 Define a mapping to store lock data for each user
    mapping(address => uint256) public lockExpiry;

    // ERC20 token interface
    IERC20 public token;

    constructor(address tokenAddress) {
        token = IERC20(tokenAddress);
    }

    // 🚩 TODO: Create a function to lock tokens for a certain period
    function lockTokens(uint256 amount, uint256 lockDuration) public {
        // 🚩 TODO: Ensure the user has enough tokens to lock
        // 🚩 TODO: Set the lockExpiry for the user address
        // 🚩 TODO: Transfer the tokens to the contract and lock them
    }

    // 🚩 TODO: Create a function to withdraw the tokens after lock period
    function withdrawTokens() public {
        // 🚩 TODO: Ensure the lock period has passed
        // 🚩 TODO: Transfer the tokens back to the user
    }

    // 🚩 TODO: Emit events for token locking and withdrawal
    event TokensLocked(address indexed user, uint256 amount, uint256 lockUntil);
    event TokensWithdrawn(address indexed user, uint256 amount);
}
```

## Checklist for Learners:

- [ ] Created a struct to store user-specific lock data (amount and expiry time).
- [ ] Implemented a function to lock tokens for a specified period.
- [ ] Used a modifier to check if the lock period has expired before allowing withdrawal.
- [ ] Ensured the user has sufficient tokens before locking them using require.
- [ ] Emitted events for token locking and withdrawal for transparency.
- [ ] Made sure users can’t withdraw tokens before the lock period ends.

## Hints:

- Use the `block.timestamp` to track the current time and compare it with the user’s lock period.
- Store the lock expiry time for each address in a mapping.
- Use the ERC20 transfer function to handle token transfers.
- The contract should restrict token withdrawals until the lock period has expired, preventing premature access to funds.
- Emit events for both token lock and withdrawal actions for transparency.

## Additional hints for Learners:

- Tracking Lock Data: Each user’s lock details (amount and expiry time) should be stored in a `mapping(address => LockData)`.
- Handling Token Transfer: Use the IERC20 interface’s transferFrom and transfer methods to lock and withdraw tokens.
- Security Considerations: Use modifiers to ensure that the contract only allows valid operations, such as checking the lock expiry before withdrawal.

## Expected answer (flagged)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TimelockToken {
    // Struct to hold the lock data for each user
    struct LockData {
        uint256 amount;
        uint256 lockUntil;
    }

    mapping(address => LockData) public userLocks;

    IERC20 public token;

    constructor(address tokenAddress) {
        token = IERC20(tokenAddress);
    }

    modifier hasLockExpired() {
        require(block.timestamp >= userLocks[msg.sender].lockUntil, "Lock period not expired.");
        _;
    }

    modifier hasSufficientBalance(uint256 amount) {
        require(token.balanceOf(msg.sender) >= amount, "Insufficient token balance.");
        _;
    }

    // Function to lock tokens for a certain period
    function lockTokens(uint256 amount, uint256 lockDuration) public hasSufficientBalance(amount) {
        require(amount > 0, "Amount must be greater than 0.");

        uint256 lockUntil = block.timestamp + lockDuration;

        // Store lock details
        userLocks[msg.sender] = LockData(amount, lockUntil);

        // Transfer tokens to the contract and lock them
        token.transferFrom(msg.sender, address(this), amount);

        emit TokensLocked(msg.sender, amount, lockUntil);
    }

    // Function to withdraw tokens after the lock period has passed
    function withdrawTokens() public hasLockExpired {
        uint256 amount = userLocks[msg.sender].amount;

        require(amount > 0, "No tokens to withdraw.");

        // Reset the lock data
        userLocks[msg.sender].amount = 0;

        // Transfer tokens back to the user
        token.transfer(msg.sender, amount);

        emit TokensWithdrawn(msg.sender, amount);
    }

    // Event emitted when tokens are locked
    event TokensLocked(address indexed user, uint256 amount, uint256 lockUntil);

    // Event emitted when tokens are withdrawn
    event TokensWithdrawn(address indexed user, uint256 amount);
}
```

## Final thoughts

This **Timelock Token Contract** allows users to lock their tokens for a set period of time, ensuring they cannot withdraw them until the lock has expired. By using blockchain technology, this system provides a secure and transparent way for people to save money without being able to access their funds prematurely, which is an important solution for financial discipline. This activity will help you understand how to implement a timelock mechanism using Solidity and ERC20 tokens, making it an ideal exercise for advanced Solidity learners.
