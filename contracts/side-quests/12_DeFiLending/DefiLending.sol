// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DeFiLending is Ownable {
    IERC20 public lendingToken; // The ERC20 token that will be lent
    uint256 public interestRate = 5; // Annual interest rate in percentage

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
        require(
            userDeposits[msg.sender] >= amount,
            "Insufficient balance to withdraw"
        );

        // Calculate earned interest
        uint256 interest = calculateInterest(msg.sender);
        uint256 totalAmount = amount + interest;

        // Ensure enough tokens are available to withdraw
        require(
            lendingToken.balanceOf(address(this)) >= totalAmount,
            "Insufficient contract balance"
        );

        // Update user's deposit and transfer tokens back to the user
        userDeposits[msg.sender] -= amount;
        lendingToken.transfer(msg.sender, totalAmount);

        emit Withdrawn(msg.sender, amount, interest);
    }

    function calculateInterest(address user) public view returns (uint256) {
        uint256 timeElapsed = block.timestamp - depositTimestamp[user]; // Time in seconds
        uint256 principal = userDeposits[user];

        // Simple interest formula: Interest = (Principal * Rate * Time) / (365 * 24 * 60 * 60)
        return
            (principal * interestRate * timeElapsed) /
            (365 * 24 * 60 * 60 * 100);
    }

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount, uint256 interest);
}
