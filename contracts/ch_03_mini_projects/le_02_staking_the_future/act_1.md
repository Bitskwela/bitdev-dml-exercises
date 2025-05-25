# Smart contract activity:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

contract SimpleStaker {
    IERC20 public stakingToken;
    uint256 public lockDuration = 60; // 1 minute
    struct Stake {
        uint256 amount;
        uint256 unlockTime;
    }

    mapping(address => Stake) public stakes;

    constructor(address _token) {
        stakingToken = IERC20(_token);
    }

    function stake(uint256 amount) public {}

    function unstake() public {}
}

```

**Time Allotment: 1 hour**

## Tasks for students

Topics Covered: ERC20, Staking, Timestamp Logic, Rewards

- Complete the `stake` function to:

  - Accept a specified amount of tokens from the user.
  - Ensure the user has enough balance and allowance to stake.
  - Update the user's stake with the amount and set an unlock time based on `lockDuration`. Utilize the `stakes` mapping to track user stakes.

  ```solidity
  function stake(uint256 amount) public {
    require(amount > 0, "Nothing to stake");
    stakingToken.transferFrom(msg.sender, address(this), amount);
    stakes[msg.sender] = Stake(amount, block.timestamp + lockDuration);
  }
  ```

- Complete the `unstake` function to:

  - Allow users to withdraw their staked tokens after the lock period has expired.
  - Ensure the user has a valid stake and that the unlock time has passed.
  - Transfer the staked tokens back to the user and reset their stake.

  ```solidity
  function unstake() public {
    Stake memory userStake = stakes[msg.sender];
    require(userStake.amount > 0, "Nothing staked");
    require(block.timestamp >= userStake.unlockTime, "Still locked");

    uint256 reward = (userStake.amount * 110) / 100;
    delete stakes[msg.sender];

    stakingToken.transfer(msg.sender, reward);
  }
  ```
