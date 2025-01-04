# Sidequest #11: Token Staking & Rewards (DeFi Smart Contract)

## Backstory:

Neri, now a blockchain hero, seeks to bolster the economic resilience of the local communities through decentralized finance (DeFi). She proposes a staking protocol where users can stake their JuanTokens in exchange for rewards. These rewards are distributed periodically based on the amount staked.

However, Neri realizes that to maximize rewards, the smart contract should interact with an ERC20 token liquidity pool to generate yield for stakers. The contract must allow users to deposit JuanTokens into the staking contract, interact with the liquidity pool to earn rewards, and later withdraw their staked tokens along with any rewards earned.

The contract must also:

- Allow staking and withdrawal of JuanTokens.
- Calculate rewards based on the staking duration.
- Interact with an external liquidity pool for reward generation.
- Allow users to view their staked balance and earned rewards.

# Problem Overview:

In this task, you need to create a staking contract that allows users to:

- Stake their JuanTokens.
- Earn rewards from an ERC20-based liquidity pool (simulated as another contract).
- Withdraw their staked tokens and earned rewards at any time.

## Time Allotment: 20 minutes

## Solidity Topics Covered:

- DeFi Concepts – Staking and rewards systems.
- Interacting with External Contracts – Interacting with an ERC20-based liquidity pool.
- Mappings and State Variables – Managing user stakes and rewards.
- Modifiers – Checking if a user is eligible to stake or withdraw.
- Events – Emitting events for staking and rewards.

## Code Activity:

You will need to implement the following features for the contract:

- Stake function – allows users to stake their JuanTokens.
- Withdraw function – allows users to withdraw staked tokens and any earned rewards.
- Reward calculation – rewards are distributed based on the amount of tokens staked and the duration of the stake.

### Contract Template:

```solidity

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 🚩 TODO: Import ERC20 token interface and Ownable
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

contract StakingRewards is Ownable {
    IERC20 public stakingToken;
    IERC20 public rewardToken;

    mapping(address => uint256) public stakedBalance;
    mapping(address => uint256) public rewardBalance;

    uint256 public rewardRate = 100;  // Rewards per staked token (simplified)

    // 🚩 TODO: Implement constructor to set staking and reward tokens
    constructor(IERC20 _stakingToken, IERC20 _rewardToken) {
        stakingToken = _stakingToken;
        rewardToken = _rewardToken;
    }

    // 🚩 TODO: Implement staking function to deposit JuanTokens
    function stake(uint256 amount) external {
        // Ensure the user has enough tokens to stake
        require(amount > 0, "You must stake more than 0 tokens.");

        // 🏁 ANSWER: Transfer tokens to the contract and update stakedBalance
        stakingToken.transferFrom(msg.sender, address(this), amount);
        stakedBalance[msg.sender] += amount;

        // Emitting event
        emit Staked(msg.sender, amount);
    }

    // 🚩 TODO: Implement reward distribution and withdrawal
    function withdraw(uint256 amount) external {
        // Ensure the user has enough staked tokens to withdraw
        require(stakedBalance[msg.sender] >= amount, "Insufficient staked balance.");

        // 🏁 ANSWER: Transfer staked tokens and calculate rewards
        stakedBalance[msg.sender] -= amount;
        stakingToken.transfer(msg.sender, amount);

        // Distribute rewards based on the amount and reward rate
        uint256 reward = amount * rewardRate / 100;
        rewardBalance[msg.sender] += reward;
        rewardToken.transfer(msg.sender, reward);

        emit Withdrawn(msg.sender, amount, reward);
    }

    // 🚩 TODO: Implement reward calculation function
    function calculateReward(address user) public view returns (uint256) {
        // Reward calculation logic (based on staked amount)
        return stakedBalance[user] * rewardRate / 100;
    }

    // 🚩 TODO: Implement events for staking and withdrawal
    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount, uint256 reward);
}
```

## Checklist for Learners:

- Implemented stake function to accept token deposits.
- Implemented withdraw function to allow token withdrawal and reward distribution.
- Used IERC20 interface to interact with external ERC20 tokens for staking and rewards.
- Ensured that rewards are correctly calculated based on staked amounts and rate.
- Emitted events for transparency and tracking staking and withdrawal actions.

## Hints:

- You will simulate interaction with a liquidity pool. For simplicity, you can use an ERC20 token as the pool.
- Use a mapping to track each user’s staked balance and earned rewards.
- Use a modifier to ensure only staked tokens can be withdrawn and rewards are correctly calculated based on time.
- Make sure to emit events for staking and withdrawals to ensure transparency.

## Additional hints :)

- The IERC20 interface enables the contract to interact with external ERC20 tokens (both for staking and rewards).
- Rewards can be calculated as a percentage of the staked tokens, where rewardRate determines the rate of reward distribution.
- Use the transferFrom function to pull tokens from users and transfer to send tokens back.
- Ensure the withdrawal function does not allow users to withdraw more tokens than they have staked.

## Expected answer (flagged)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract StakingRewards is Ownable {
    IERC20 public stakingToken;
    IERC20 public rewardToken;

    mapping(address => uint256) public stakedBalance;
    mapping(address => uint256) public rewardBalance;

    uint256 public rewardRate = 100;  // Rewards per staked token (simplified)

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
        require(stakedBalance[msg.sender] >= amount, "Insufficient staked balance.");

        // Transfer staked tokens and calculate rewards
        stakedBalance[msg.sender] -= amount;
        stakingToken.transfer(msg.sender, amount);

        // Distribute rewards based on the amount and reward rate
        uint256 reward = amount * rewardRate / 100;
        rewardBalance[msg.sender] += reward;
        rewardToken.transfer(msg.sender, reward);

        emit Withdrawn(msg.sender, amount, reward);
    }

    function calculateReward(address user) public view returns (uint256) {
        // Reward calculation logic
        return stakedBalance[user] * rewardRate / 100;
    }

    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount, uint256 reward);
}
```

## Final thoughts

With this DeFi contract, you're building the foundation for a decentralized staking system, where users can earn rewards by staking tokens into a contract. This mimics popular DeFi applications such as **Yearn.finance** and **Aave**.
