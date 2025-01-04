// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract StakingRewards is Ownable {
    IERC20 public stakingToken;
    IERC20 public rewardToken;

    mapping(address => uint256) public stakedBalance;
    mapping(address => uint256) public rewardBalance;

    uint256 public rewardRate = 100; // Rewards per staked token (simplified)

    constructor(IERC20 _stakingToken, IERC20 _rewardToken) Ownable(msg.sender) {
        stakingToken = _stakingToken;
        rewardToken = _rewardToken;
    }

    function stake(uint256 amount) external {
        require(amount > 0, "You must stake more than 0 tokens.");

        // Transfer tokens to the contract and update stakedBalance
        stakingToken.transferFrom(msg.sender, address(this), amount);
        stakedBalance[msg.sender] += amount;

        // Emitting event
        emit Staked(msg.sender, amount);
    }

    function withdraw(uint256 amount) external {
        require(
            stakedBalance[msg.sender] >= amount,
            "Insufficient staked balance."
        );

        // Transfer staked tokens and calculate rewards
        stakedBalance[msg.sender] -= amount;
        stakingToken.transfer(msg.sender, amount);

        // Distribute rewards based on the amount and reward rate
        uint256 reward = (amount * rewardRate) / 100;
        rewardBalance[msg.sender] += reward;
        rewardToken.transfer(msg.sender, reward);

        emit Withdrawn(msg.sender, amount, reward);
    }

    function calculateReward(address user) public view returns (uint256) {
        // Reward calculation logic
        return (stakedBalance[user] * rewardRate) / 100;
    }

    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount, uint256 reward);
}
