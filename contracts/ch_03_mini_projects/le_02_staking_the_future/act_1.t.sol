// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Staking the Future" (proj-2-staking-the-future).
// The student builds an ERC20 staker: stake() pulls tokens in via transferFrom
// and records a locked stake; unstake() returns 110% after the lock expires.
//
// SimpleStaker.sol declares its own minimal `interface IERC20`, so this suite
// ships a self-contained MockERC20 with matching signatures instead of relying
// on any helper token file.

import {Test} from "forge-std/Test.sol";
import {SimpleStaker} from "../src/SimpleStaker.sol";

contract MockERC20 {
    string public name = "Mock Staking Token";
    string public symbol = "MOCK";
    uint8 public decimals = 18;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    function mint(address to, uint256 amount) external {
        balanceOf[to] += amount;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        return true;
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        require(balanceOf[msg.sender] >= amount, "MOCK: balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        require(balanceOf[from] >= amount, "MOCK: balance");
        uint256 allowed = allowance[from][msg.sender];
        require(allowed >= amount, "MOCK: allowance");
        if (allowed != type(uint256).max) {
            allowance[from][msg.sender] = allowed - amount;
        }
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        return true;
    }
}

contract SimpleStakerTest is Test {
    MockERC20 internal token;
    SimpleStaker internal staker;

    address internal user = address(0xA11CE);

    uint256 internal constant USER_BALANCE = 1_000 ether;
    uint256 internal constant STAKE_AMOUNT = 100 ether;

    function setUp() public {
        token = new MockERC20();
        staker = new SimpleStaker(address(token));

        // Fund the user and pre-fund the staker so it can pay the 10% reward.
        token.mint(user, USER_BALANCE);
        token.mint(address(staker), 1_000 ether);

        vm.prank(user);
        token.approve(address(staker), type(uint256).max);
    }

    function test_constructor_setsStakingToken() public view {
        assertEq(address(staker.stakingToken()), address(token), "wrong staking token");
    }

    function test_stake_movesTokensIntoStakerAndRecordsStake() public {
        vm.prank(user);
        staker.stake(STAKE_AMOUNT);

        assertEq(token.balanceOf(user), USER_BALANCE - STAKE_AMOUNT, "user balance not reduced");

        (uint256 amount, uint256 unlockTime) = staker.stakes(user);
        assertEq(amount, STAKE_AMOUNT, "staked amount not recorded");
        assertEq(unlockTime, block.timestamp + staker.lockDuration(), "unlock time wrong");
    }

    function test_stake_revertsOnZeroAmount() public {
        vm.prank(user);
        vm.expectRevert(bytes("Nothing to stake"));
        staker.stake(0);
    }

    function test_unstake_revertsWhileLocked() public {
        vm.prank(user);
        staker.stake(STAKE_AMOUNT);

        vm.prank(user);
        vm.expectRevert(bytes("Still locked"));
        staker.unstake();
    }

    function test_unstake_revertsWhenNothingStaked() public {
        vm.prank(user);
        vm.expectRevert(bytes("Nothing staked"));
        staker.unstake();
    }

    function test_unstake_returnsPrincipalPlusTenPercentReward() public {
        vm.prank(user);
        staker.stake(STAKE_AMOUNT);

        // Balance after staking = USER_BALANCE - STAKE_AMOUNT.
        uint256 balanceAfterStake = token.balanceOf(user);

        vm.warp(block.timestamp + staker.lockDuration() + 1);

        vm.prank(user);
        staker.unstake();

        // Reward is 110% of the staked principal.
        uint256 expectedPayout = (STAKE_AMOUNT * 110) / 100;
        assertEq(
            token.balanceOf(user),
            balanceAfterStake + expectedPayout,
            "payout should be 110% of stake"
        );

        // Stake record is cleared.
        (uint256 amount, ) = staker.stakes(user);
        assertEq(amount, 0, "stake not cleared after unstake");
    }
}
