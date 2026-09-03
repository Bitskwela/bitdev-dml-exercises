// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Transfer Tokens"
// (permaname: erc20-transfer-tokens).
//
// The starter compiles with an empty `awardClass` body, so it is a silent no-op:
// the transaction succeeds and nobody is paid. Every assertion here is therefore
// about balances actually moving.
//
// `awardClass` calls the inherited `transfer` internally, which keeps msg.sender
// as the original caller — so the credits come out of the CALLER's balance, not
// the contract's. The prank tests below pin that down, because a student who
// reaches for `_transfer(address(this), ...)` would otherwise pass.

import {Test} from "forge-std/Test.sol";
import {WorkshopCredit} from "../src/WorkshopCredit.sol";

contract WorkshopCreditTest is Test {
    WorkshopCredit internal credit;

    uint256 internal constant EXPECTED_SUPPLY = 1000 * 10 ** 18;
    uint256 internal constant EACH = 10 * 10 ** 18;

    address internal alice = address(0xA11CE);
    address internal bob = address(0xB0B);
    address internal carol = address(0xCA401);

    function setUp() public {
        credit = new WorkshopCredit();
    }

    function _class() internal view returns (address[] memory students) {
        students = new address[](3);
        students[0] = alice;
        students[1] = bob;
        students[2] = carol;
    }

    /// The task: every student in the list is paid `amountEach`.
    function test_awardClass_paysEveryStudent() public {
        credit.awardClass(_class(), EACH);

        assertEq(credit.balanceOf(alice), EACH, "alice was not paid");
        assertEq(credit.balanceOf(bob), EACH, "bob was not paid");
        assertEq(credit.balanceOf(carol), EACH, "carol was not paid");
    }

    /// The credits come out of the caller's balance — the loop is real spending.
    function test_awardClass_debitsTheCaller() public {
        credit.awardClass(_class(), EACH);

        assertEq(
            credit.balanceOf(address(this)),
            EXPECTED_SUPPLY - 3 * EACH,
            "the caller must fund every award"
        );
    }

    /// Transferring never creates or destroys credits.
    function test_awardClass_preservesTotalSupply() public {
        credit.awardClass(_class(), EACH);

        assertEq(credit.totalSupply(), EXPECTED_SUPPLY, "supply must not change on transfer");
    }

    /// Whoever calls is whoever pays — not the contract, and not the deployer.
    function test_awardClass_paysFromWhoeverCalls() public {
        credit.transfer(alice, 100 * 10 ** 18);

        address[] memory recipients = new address[](1);
        recipients[0] = bob;

        vm.prank(alice);
        credit.awardClass(recipients, EACH);

        assertEq(credit.balanceOf(bob), EACH, "bob was not paid by alice");
        assertEq(credit.balanceOf(alice), 100 * 10 ** 18 - EACH, "alice was not debited");
        assertEq(credit.balanceOf(address(credit)), 0, "the contract must never hold credits");
    }

    /// An empty class list is a no-op, not a revert.
    function test_awardClass_toleratesAnEmptyList() public {
        address[] memory none = new address[](0);
        credit.awardClass(none, EACH);

        assertEq(credit.balanceOf(address(this)), EXPECTED_SUPPLY, "an empty list must cost nothing");
    }

    /// Running out mid-loop must revert the whole batch, not pay some students.
    function test_awardClass_revertsWhenTheCallerRunsOut() public {
        credit.transfer(alice, EACH);

        address[] memory recipients = new address[](2);
        recipients[0] = bob;
        recipients[1] = carol;

        vm.prank(alice);
        vm.expectRevert();
        credit.awardClass(recipients, EACH);

        assertEq(credit.balanceOf(carol), 0, "a reverted batch must pay nobody");
    }

    /// The inherited single transfer must still work alongside the new helper.
    function test_plainTransfer_stillWorks() public {
        assertTrue(credit.transfer(alice, EACH), "transfer() regressed");
        assertEq(credit.balanceOf(alice), EACH, "transfer() moved nothing");
    }
}
