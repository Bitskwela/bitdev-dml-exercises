// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Liquidity Lockdown"
// (permaname: proj-1-liquidity-lockdown).
//
// Both functions are empty in the starter, so a deposit records nothing and a
// withdrawal pays nothing — the suite asserts the ledger and the ETH separately
// for exactly that reason.
//
// Time is controlled with `vm.warp`, so the 60-second lock is tested at its
// boundary rather than by waiting: one second early must revert, and the lock
// second itself must succeed.
//
// Every depositor is an EOA because the answer pays out with `.transfer`, whose
// 2300-gas stipend a contract recipient would not survive.

import {Test} from "forge-std/Test.sol";
import {LiquidityLocker} from "../src/LiquidityLocker.sol";

contract LiquidityLockerTest is Test {
    LiquidityLocker internal locker;

    uint256 internal constant LOCK_SECONDS = 60;

    address internal alice = address(0xA11CE);
    address internal bob = address(0xB0B);

    function setUp() public {
        locker = new LiquidityLocker();
        vm.deal(alice, 10 ether);
        vm.deal(bob, 10 ether);
    }

    /// Constructor behaviour, carried over unchanged.
    function test_constructor_recordsTheOwner() public view {
        assertEq(locker.owner(), address(this), "the deployer must be the owner");
    }

    /// Task 1: the deposit is credited to the depositor.
    function test_deposit_recordsTheDeposit() public {
        vm.prank(alice);
        locker.deposit{value: 1 ether}();

        assertEq(locker.deposits(alice), 1 ether, "the deposit was not recorded");
        assertEq(address(locker).balance, 1 ether, "the contract did not keep the ETH");
    }

    /// Task 1: the lock clock starts on deposit.
    function test_deposit_startsTheLock() public {
        vm.prank(alice);
        locker.deposit{value: 1 ether}();

        assertEq(locker.lockEnd(), block.timestamp + LOCK_SECONDS, "lockEnd was not set");
    }

    /// An empty deposit is refused rather than silently accepted.
    function test_deposit_revertsOnZero() public {
        vm.prank(alice);
        vm.expectRevert(bytes("Must deposit ETH"));
        locker.deposit{value: 0}();
    }

    /// Repeat deposits accumulate rather than replacing.
    function test_deposit_accumulates() public {
        vm.startPrank(alice);
        locker.deposit{value: 1 ether}();
        locker.deposit{value: 2 ether}();
        vm.stopPrank();

        assertEq(locker.deposits(alice), 3 ether, "deposits must accumulate");
    }

    /// Task 2: the lock actually locks.
    function test_withdraw_revertsWhileLocked() public {
        vm.startPrank(alice);
        locker.deposit{value: 1 ether}();

        vm.expectRevert(bytes("Still locked"));
        locker.withdraw();
        vm.stopPrank();

        assertEq(locker.deposits(alice), 1 ether, "a blocked withdrawal changed the ledger");
    }

    /// One second before the deadline is still locked.
    function test_withdraw_revertsOneSecondEarly() public {
        vm.prank(alice);
        locker.deposit{value: 1 ether}();

        vm.warp(locker.lockEnd() - 1);

        vm.prank(alice);
        vm.expectRevert(bytes("Still locked"));
        locker.withdraw();
    }

    /// Task 2: once the lock expires, the ETH comes back.
    function test_withdraw_paysOutAfterTheLock() public {
        vm.prank(alice);
        locker.deposit{value: 1 ether}();

        vm.warp(locker.lockEnd());

        uint256 before = alice.balance;
        vm.prank(alice);
        locker.withdraw();

        assertEq(alice.balance, before + 1 ether, "the withdrawal did not pay out");
        assertEq(locker.deposits(alice), 0, "the ledger was not cleared");
        assertEq(address(locker).balance, 0, "the ETH is still in the contract");
    }

    /// Withdrawing twice must not pay twice.
    function test_withdraw_cannotBeRepeated() public {
        vm.prank(alice);
        locker.deposit{value: 1 ether}();
        vm.warp(locker.lockEnd());

        vm.startPrank(alice);
        locker.withdraw();

        vm.expectRevert(bytes("No funds"));
        locker.withdraw();
        vm.stopPrank();
    }

    /// A depositor may only take their own funds, not the pool's.
    function test_withdraw_paysOnlyTheCallersDeposit() public {
        vm.prank(alice);
        locker.deposit{value: 1 ether}();
        vm.prank(bob);
        locker.deposit{value: 4 ether}();

        vm.warp(locker.lockEnd());

        uint256 before = alice.balance;
        vm.prank(alice);
        locker.withdraw();

        assertEq(alice.balance, before + 1 ether, "alice took the wrong amount");
        assertEq(locker.deposits(bob), 4 ether, "bob's deposit was touched");
        assertEq(address(locker).balance, 4 ether, "the pool was drained");
    }

    /// Someone who never deposited has nothing to take.
    function test_withdraw_revertsForANonDepositor() public {
        vm.prank(alice);
        locker.deposit{value: 1 ether}();
        vm.warp(locker.lockEnd());

        vm.prank(bob);
        vm.expectRevert(bytes("No funds"));
        locker.withdraw();
    }
}
