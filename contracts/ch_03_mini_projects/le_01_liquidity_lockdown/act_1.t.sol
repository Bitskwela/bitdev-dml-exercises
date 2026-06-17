// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Liquidity Lockdown" (proj-1-liquidity-lockdown).
// The student builds a time-locked ETH vault: deposit sets a lock, withdraw is
// blocked until the lock expires.

import {Test} from "forge-std/Test.sol";
import {LiquidityLocker} from "../src/LiquidityLocker.sol";

contract LiquidityLockerTest is Test {
    LiquidityLocker internal locker;

    address internal alice = address(0xA11CE);
    address internal bob = address(0xB0B);

    function setUp() public {
        // Test contract is the deployer, therefore the owner.
        locker = new LiquidityLocker();
        vm.deal(alice, 10 ether);
        vm.deal(bob, 10 ether);
    }

    function test_owner_isDeployer() public view {
        assertEq(locker.owner(), address(this), "deployer should be owner");
    }

    function test_deposit_recordsPerUserBalance() public {
        vm.prank(alice);
        locker.deposit{value: 2 ether}();
        assertEq(locker.deposits(alice), 2 ether, "alice deposit not recorded");

        vm.prank(bob);
        locker.deposit{value: 3 ether}();
        assertEq(locker.deposits(bob), 3 ether, "bob deposit not recorded");
        // alice's balance must be untouched by bob's deposit.
        assertEq(locker.deposits(alice), 2 ether, "alice balance leaked");
    }

    function test_deposit_setsLockInFuture() public {
        vm.prank(alice);
        locker.deposit{value: 1 ether}();
        assertGt(locker.lockEnd(), block.timestamp, "lock must be in the future");
    }

    function test_deposit_revertsOnZeroValue() public {
        vm.prank(alice);
        vm.expectRevert(bytes("Must deposit ETH"));
        locker.deposit{value: 0}();
    }

    function test_withdraw_revertsWhileLocked() public {
        vm.prank(alice);
        locker.deposit{value: 1 ether}();

        vm.prank(alice);
        vm.expectRevert(bytes("Still locked"));
        locker.withdraw();
    }

    function test_withdraw_succeedsAfterUnlockAndReturnsEth() public {
        vm.prank(alice);
        locker.deposit{value: 1 ether}();

        uint256 balanceBefore = alice.balance;

        // Jump past the 60-second lock window.
        vm.warp(block.timestamp + 61);

        vm.prank(alice);
        locker.withdraw();

        assertEq(alice.balance, balanceBefore + 1 ether, "alice did not get ETH back");
        assertEq(locker.deposits(alice), 0, "deposit not zeroed after withdraw");
    }

    function test_withdraw_revertsWhenNoFunds() public {
        // Give the contract a live lock window via a different user's deposit.
        vm.prank(alice);
        locker.deposit{value: 1 ether}();
        vm.warp(block.timestamp + 61);

        // Bob never deposited; once unlocked he hits the "No funds" guard.
        vm.prank(bob);
        vm.expectRevert(bytes("No funds"));
        locker.withdraw();
    }

    // Required to receive Ether if ownership tests ever route ETH here.
    receive() external payable {}
}
