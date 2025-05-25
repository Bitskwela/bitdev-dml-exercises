// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

contract SimpleStaker {
    IERC20 public stakingToken;
    uint256 public lockDuration = 60; // 1 minute for faster testing
    struct Stake {
        uint256 amount;
        uint256 unlockTime;
    }

    mapping(address => Stake) public stakes;

    constructor(address _token) {
        stakingToken = IERC20(_token);
    }

    // TODO: Implement staking
    function stake(uint256 amount) public {}

    // TODO: Implement unstaking with 10% reward
    function unstake() public {}
}
