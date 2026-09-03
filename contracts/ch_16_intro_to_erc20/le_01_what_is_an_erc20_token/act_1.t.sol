// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "What Is an ERC-20 Token?"
// (permaname: erc20-what-is-a-token).
//
// The grader writes the student's submission to `src/WorkshopLedger.sol`
// (spec.json -> source_file), so the import below resolves against that
// assembled layout, NOT the content-repo filename.
//
// The lesson's four tasks: (1) a public `balanceOf` mapping, (2) a public
// `totalCredits`, (3) `award` crediting both, (4) `transfer` moving credits
// with a balance check. Each has at least one test that fails on the starter,
// where every task body is a TODO comment.

import {Test} from "forge-std/Test.sol";
import {WorkshopLedger} from "../src/WorkshopLedger.sol";

contract WorkshopLedgerTest is Test {
    WorkshopLedger internal ledger;

    address internal constant MARIA = address(0xA11CE);
    address internal constant JUAN = address(0xB0B);

    function setUp() public {
        ledger = new WorkshopLedger();
    }

    /// Task 1 + 2: the ledger starts empty, and both fields are readable.
    /// A missing `public` on either one fails to compile, which the grader
    /// reports as a compile error rather than a wrong answer.
    function test_initialState_isEmpty() public view {
        assertEq(ledger.balanceOf(MARIA), 0, "balances should start at zero");
        assertEq(ledger.totalCredits(), 0, "totalCredits should start at zero");
    }

    /// Task 3: awarding credits must move BOTH the recipient's balance and the
    /// supply. Crediting only one is the most likely half-done answer.
    function test_award_creditsBalanceAndTotal() public {
        ledger.award(MARIA, 50);

        assertEq(ledger.balanceOf(MARIA), 50, "award did not credit the student");
        assertEq(ledger.totalCredits(), 50, "award did not raise totalCredits");
    }

    /// Task 3: awards accumulate rather than overwrite, and each student's
    /// balance is tracked separately.
    function test_award_accumulatesPerStudent() public {
        ledger.award(MARIA, 30);
        ledger.award(MARIA, 20);
        ledger.award(JUAN, 5);

        assertEq(ledger.balanceOf(MARIA), 50, "repeat awards must add, not replace");
        assertEq(ledger.balanceOf(JUAN), 5, "each student holds their own balance");
        assertEq(ledger.totalCredits(), 55, "totalCredits must count every award");
    }

    /// Task 4: a transfer debits the sender and credits the recipient.
    function test_transfer_movesCreditsBetweenHolders() public {
        ledger.award(MARIA, 100);

        vm.prank(MARIA);
        ledger.transfer(JUAN, 40);

        assertEq(ledger.balanceOf(MARIA), 60, "sender was not debited");
        assertEq(ledger.balanceOf(JUAN), 40, "recipient was not credited");
    }

    /// Task 4: the lesson's central idea — a transfer MOVES credits, it never
    /// creates them, so the supply is untouched.
    function test_transfer_leavesTotalCreditsUnchanged() public {
        ledger.award(MARIA, 100);

        vm.prank(MARIA);
        ledger.transfer(JUAN, 40);

        assertEq(ledger.totalCredits(), 100, "a transfer must not change the supply");
    }

    /// Task 4: the balance check. Without the `require`, an underflow would
    /// revert anyway under 0.8.x — but with the wrong message, so asserting the
    /// reason is what proves the student wrote the check the lesson asked for.
    function test_transfer_revertsWhenSenderCannotAfford() public {
        ledger.award(MARIA, 10);

        vm.prank(MARIA);
        vm.expectRevert(bytes("not enough credits"));
        ledger.transfer(JUAN, 11);
    }

    /// Edge case: spending the entire balance is allowed — the check is
    /// `>=`, not `>`.
    function test_transfer_allowsSpendingTheWholeBalance() public {
        ledger.award(MARIA, 25);

        vm.prank(MARIA);
        ledger.transfer(JUAN, 25);

        assertEq(ledger.balanceOf(MARIA), 0, "sender should be emptied");
        assertEq(ledger.balanceOf(JUAN), 25, "recipient should hold it all");
    }

    /// Edge case: a holder with nothing cannot transfer anything.
    function test_transfer_revertsForAHolderWithNoCredits() public {
        vm.prank(JUAN);
        vm.expectRevert(bytes("not enough credits"));
        ledger.transfer(MARIA, 1);
    }
}
