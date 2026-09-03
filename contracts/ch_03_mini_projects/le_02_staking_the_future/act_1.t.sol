// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Staking the Future"
// (permaname: proj-2-staking-the-future).
//
// The staking token is a mock declared here rather than the repo's
// `SanJuanToken.sol`: the student's file declares its own `IERC20`, imports
// nothing, and only ever needs *a* token that answers transfer/transferFrom.
// Pulling the repo helper in as an `extra_source` would add a `^0.8.27` pragma
// this bundle pins below, for no gain.
//
// The staker is pre-funded with a reward float, because unstake pays 110% and a
// contract that only holds the principal would fail for lack of tokens rather
// than for a missing implementation — two very different report messages.
//
// Only `SimpleStaker` is imported by name, so the student's `IERC20` declaration
// does not collide with OpenZeppelin's in this file.

import {Test} from "forge-std/Test.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {SimpleStaker} from "../src/SimpleStaker.sol";

/// Minimal staking token: whatever the student's IERC20 expects, this answers.
contract StakeToken is ERC20 {
    constructor() ERC20("SanJuanToken", "SJT") {
        _mint(msg.sender, 1_000_000 ether);
    }
}

contract SimpleStakerTest is Test {
    StakeToken internal token;
    SimpleStaker internal staker;

    uint256 internal constant STAKE = 100 ether;
    uint256 internal constant LOCK_SECONDS = 60;

    address internal alice = address(0xA11CE);
    address internal bob = address(0xB0B);

    function setUp() public {
        token = new StakeToken();
        staker = new SimpleStaker(address(token));

        // Reward float, so a correct unstake can pay its 10% bonus.
        token.transfer(address(staker), 10_000 ether);

        token.transfer(alice, 1_000 ether);
        token.transfer(bob, 1_000 ether);

        vm.prank(alice);
        token.approve(address(staker), type(uint256).max);
        vm.prank(bob);
        token.approve(address(staker), type(uint256).max);
    }

    /// Constructor behaviour, carried over unchanged.
    function test_constructor_wiresTheToken() public view {
        assertEq(address(staker.stakingToken()), address(token), "staking token not stored");
        assertEq(staker.lockDuration(), LOCK_SECONDS, "lockDuration regressed");
    }

    /// Task 1: staking pulls the tokens in.
    function test_stake_pullsTheTokensIn() public {
        uint256 before = token.balanceOf(address(staker));

        vm.prank(alice);
        staker.stake(STAKE);

        assertEq(token.balanceOf(alice), 900 ether, "the staker was not debited");
        assertEq(token.balanceOf(address(staker)), before + STAKE, "the contract did not receive the stake");
    }

    /// Task 1: the stake and its unlock time are recorded.
    function test_stake_recordsAmountAndUnlockTime() public {
        vm.prank(alice);
        staker.stake(STAKE);

        (uint256 amount, uint256 unlockTime) = staker.stakes(alice);
        assertEq(amount, STAKE, "the staked amount was not recorded");
        assertEq(unlockTime, block.timestamp + LOCK_SECONDS, "the unlock time was not set");
    }

    /// Staking nothing is refused rather than silently recorded.
    function test_stake_revertsOnZero() public {
        vm.prank(alice);
        vm.expectRevert(bytes("Nothing to stake"));
        staker.stake(0);
    }

    /// Task 2: the lock actually locks.
    function test_unstake_revertsWhileLocked() public {
        vm.startPrank(alice);
        staker.stake(STAKE);

        vm.expectRevert(bytes("Still locked"));
        staker.unstake();
        vm.stopPrank();
    }

    /// One second early is still locked.
    function test_unstake_revertsOneSecondEarly() public {
        vm.prank(alice);
        staker.stake(STAKE);

        (, uint256 unlockTime) = staker.stakes(alice);
        vm.warp(unlockTime - 1);

        vm.prank(alice);
        vm.expectRevert(bytes("Still locked"));
        staker.unstake();
    }

    /// Task 2: unstaking returns the principal plus a 10% reward.
    function test_unstake_paysPrincipalPlusTenPercent() public {
        vm.prank(alice);
        staker.stake(STAKE);

        (, uint256 unlockTime) = staker.stakes(alice);
        vm.warp(unlockTime);

        vm.prank(alice);
        staker.unstake();

        assertEq(token.balanceOf(alice), 900 ether + 110 ether, "expected principal + 10% reward");
    }

    /// The stake record is cleared, so it cannot be claimed twice.
    function test_unstake_clearsTheStake() public {
        vm.prank(alice);
        staker.stake(STAKE);
        (, uint256 unlockTime) = staker.stakes(alice);
        vm.warp(unlockTime);

        vm.startPrank(alice);
        staker.unstake();

        (uint256 amount, uint256 unlock) = staker.stakes(alice);
        assertEq(amount, 0, "the stake record was not cleared");
        assertEq(unlock, 0, "the unlock time was not cleared");

        vm.expectRevert(bytes("Nothing staked"));
        staker.unstake();
        vm.stopPrank();
    }

    /// Someone who never staked has nothing to claim.
    function test_unstake_revertsForANonStaker() public {
        vm.warp(block.timestamp + LOCK_SECONDS + 1);

        vm.prank(bob);
        vm.expectRevert(bytes("Nothing staked"));
        staker.unstake();
    }

    /// Stakes are per account: one unstake must not touch another's position.
    function test_stakesAreIndependentPerAccount() public {
        vm.prank(alice);
        staker.stake(STAKE);
        vm.prank(bob);
        staker.stake(200 ether);

        (, uint256 unlockTime) = staker.stakes(alice);
        vm.warp(unlockTime);

        vm.prank(alice);
        staker.unstake();

        (uint256 bobAmount,) = staker.stakes(bob);
        assertEq(bobAmount, 200 ether, "another account's stake was affected");
    }
}
