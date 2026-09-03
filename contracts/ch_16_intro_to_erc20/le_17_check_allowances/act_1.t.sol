// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Check Allowances"
// (permaname: erc20-check-allowances).
//
// The starter returns a hard-coded 0, which happens to be the RIGHT answer for
// any pair that never approved anything. That makes the "no allowance" case
// worthless as a gate, so every assertion here reads back a NON-zero allowance,
// and the read is cross-checked against `allowance()` itself so a student cannot
// pass by re-deriving the number some other way.

import {Test} from "forge-std/Test.sol";
import {WorkshopCredit} from "../src/WorkshopCredit.sol";

contract WorkshopCreditTest is Test {
    WorkshopCredit internal credit;

    uint256 internal constant LIMIT = 200 * 10 ** 18;

    address internal alice = address(0xA11CE);
    address internal store = address(0x570E);
    address internal other = address(0x07E4);

    function setUp() public {
        credit = new WorkshopCredit();
    }

    /// The task: report the live remaining allowance for an owner/spender pair.
    function test_remainingFor_reportsAGrantedAllowance() public {
        credit.approve(store, LIMIT);

        assertEq(credit.remainingFor(address(this), store), LIMIT, "granted allowance not reported");
    }

    /// Names the starter's failure mode: a real grant must not read as zero.
    function test_remainingFor_isNotHardCodedZero() public {
        credit.approve(store, LIMIT);

        assertTrue(credit.remainingFor(address(this), store) > 0, "remainingFor still returns 0");
    }

    /// It must be a pass-through to allowance(), not an independent guess.
    function test_remainingFor_agreesWithAllowance() public {
        credit.approve(store, LIMIT);

        assertEq(
            credit.remainingFor(address(this), store),
            credit.allowance(address(this), store),
            "remainingFor disagrees with allowance()"
        );
    }

    /// The two arguments are owner then spender, and are not interchangeable.
    function test_remainingFor_respectsArgumentOrder() public {
        credit.approve(store, LIMIT);

        assertEq(credit.remainingFor(store, address(this)), 0, "owner and spender look swapped");
    }

    /// An allowance is per pair — one grant must not leak to another spender.
    function test_remainingFor_isPerOwnerSpenderPair() public {
        credit.approve(store, LIMIT);

        assertEq(credit.remainingFor(address(this), other), 0, "allowance leaked to another spender");
        assertEq(credit.remainingFor(alice, store), 0, "allowance leaked to another owner");
    }

    /// "Remaining" is the point: spending must draw the reported figure down.
    function test_remainingFor_shrinksAsTheSpenderSpends() public {
        credit.transfer(alice, 500 * 10 ** 18);

        vm.prank(alice);
        credit.approve(store, LIMIT);

        vm.prank(store);
        credit.transferFrom(alice, store, 50 * 10 ** 18);

        assertEq(
            credit.remainingFor(alice, store),
            LIMIT - 50 * 10 ** 18,
            "the reported allowance must be the live remainder"
        );
    }

    /// Reading a permission must never change it.
    function test_remainingFor_isReadOnly() public {
        credit.approve(store, LIMIT);
        credit.remainingFor(address(this), store);

        assertEq(credit.allowance(address(this), store), LIMIT, "reading changed the allowance");
    }
}
