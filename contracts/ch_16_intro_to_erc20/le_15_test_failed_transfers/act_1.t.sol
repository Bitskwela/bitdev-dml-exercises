// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Test Failed Transfers"
// (permaname: erc20-test-failed-transfers).
//
// The lesson is about failing LOUDLY and EARLY: a `require` with a readable
// message, checked before the inherited transfer would revert with a bare custom
// error. So the suite asserts the exact revert string, not merely that something
// reverted — a student who deletes the require and leans on ERC20's own guard
// would otherwise pass a test that says "reverts".
//
// The starter's body is empty, which means it neither transfers nor reverts.

import {Test} from "forge-std/Test.sol";
import {WorkshopCredit} from "../src/WorkshopCredit.sol";

contract WorkshopCreditTest is Test {
    WorkshopCredit internal credit;

    uint256 internal constant SUPPLY = 1000 * 10 ** 18;

    address internal alice = address(0xA11CE);
    address internal bob = address(0xB0B);

    function setUp() public {
        credit = new WorkshopCredit();
    }

    /// The happy path still has to work — a guard that blocks everything is not a guard.
    function test_sendExactly_transfersWhenFunded() public {
        credit.sendExactly(alice, 100 * 10 ** 18);

        assertEq(credit.balanceOf(alice), 100 * 10 ** 18, "funded transfer did not arrive");
        assertEq(credit.balanceOf(address(this)), SUPPLY - 100 * 10 ** 18, "sender not debited");
    }

    /// The task: reject an over-spend with the lesson's own message.
    function test_sendExactly_revertsWithTheCustomMessage() public {
        vm.prank(alice);
        vm.expectRevert(bytes("WCR: not enough credits"));
        credit.sendExactly(bob, 1);
    }

    /// The guard is a strict `>=`: spending your exact balance is allowed.
    function test_sendExactly_allowsSpendingTheExactBalance() public {
        credit.transfer(alice, 50 * 10 ** 18);

        vm.prank(alice);
        credit.sendExactly(bob, 50 * 10 ** 18);

        assertEq(credit.balanceOf(bob), 50 * 10 ** 18, "an exact-balance send must succeed");
        assertEq(credit.balanceOf(alice), 0, "alice should be emptied");
    }

    /// One unit over the balance is the boundary the require has to catch.
    function test_sendExactly_revertsOneUnitOverTheBalance() public {
        credit.transfer(alice, 50 * 10 ** 18);

        vm.prank(alice);
        vm.expectRevert(bytes("WCR: not enough credits"));
        credit.sendExactly(bob, 50 * 10 ** 18 + 1);
    }

    /// A reverted transfer moves nothing — state is rolled back entirely.
    function test_failedSend_leavesBalancesUntouched() public {
        credit.transfer(alice, 10 * 10 ** 18);

        vm.prank(alice);
        vm.expectRevert(bytes("WCR: not enough credits"));
        credit.sendExactly(bob, 99 * 10 ** 18);

        assertEq(credit.balanceOf(alice), 10 * 10 ** 18, "alice's balance changed on a failure");
        assertEq(credit.balanceOf(bob), 0, "bob received credits from a failed send");
        assertEq(credit.totalSupply(), SUPPLY, "supply changed on a failure");
    }

    /// A zero-balance account cannot send anything at all.
    function test_sendExactly_revertsForAnEmptyAccount() public {
        vm.prank(bob);
        vm.expectRevert(bytes("WCR: not enough credits"));
        credit.sendExactly(alice, 1 * 10 ** 18);
    }
}
