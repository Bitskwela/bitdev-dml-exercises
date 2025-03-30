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
        require(
            block.timestamp >= userLocks[msg.sender].lockUntil,
            "Lock period not expired."
        );
        _;
    }

    modifier hasSufficientBalance(uint256 amount) {
        require(
            token.balanceOf(msg.sender) >= amount,
            "Insufficient token balance."
        );
        _;
    }

    // Function to lock tokens for a certain period
    function lockTokens(
        uint256 amount,
        uint256 lockDuration
    ) public hasSufficientBalance(amount) {
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
