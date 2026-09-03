// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Spend with transferFrom"
// (permaname: erc20-spend-with-transferfrom).
//
// `collectFrom` is the checkout counter: the CALLER pulls credits out of someone
// else's balance, within the allowance that person granted. Because it calls the
// inherited `transferFrom` internally, msg.sender stays the original caller — so
// the allowance that gets spent belongs to the caller, not to the token contract.
// Every test pranks a distinct collector to hold that invariant down.
//
// The starter's body is empty: it collects nothing and reverts on nothing.

import {Test} from "forge-std/Test.sol";
import {WorkshopCredit} from "../src/WorkshopCredit.sol";

contract WorkshopCreditTest is Test {
    WorkshopCredit internal credit;

    uint256 internal constant FUNDED = 500 * 10 ** 18;
    uint256 internal constant LIMIT = 200 * 10 ** 18;
    uint256 internal constant PULL = 50 * 10 ** 18;

    address internal alice = address(0xA11CE);
    address internal store = address(0x570E);

    function setUp() public {
        credit = new WorkshopCredit();
        credit.transfer(alice, FUNDED);

        vm.prank(alice);
        credit.approve(store, LIMIT);
    }

    /// The task: an approved spender can pull credits to itself.
    function test_collectFrom_movesCreditsToTheCaller() public {
        vm.prank(store);
        credit.collectFrom(alice, PULL);

        assertEq(credit.balanceOf(store), PULL, "the collector did not receive the credits");
        assertEq(credit.balanceOf(alice), FUNDED - PULL, "the payer was not debited");
    }

    /// Spending draws down the allowance it spent.
    function test_collectFrom_consumesTheAllowance() public {
        vm.prank(store);
        credit.collectFrom(alice, PULL);

        assertEq(credit.allowance(alice, store), LIMIT - PULL, "allowance was not consumed");
    }

    /// Beyond the allowance is refused, even when the payer is rich.
    function test_collectFrom_revertsBeyondTheAllowance() public {
        vm.prank(store);
        vm.expectRevert();
        credit.collectFrom(alice, LIMIT + 1);

        assertEq(credit.balanceOf(store), 0, "a refused collection must move nothing");
    }

    /// No approval at all means no collection — this is the access control.
    function test_collectFrom_revertsWithoutAnApproval() public {
        address stranger = address(0x5748);

        vm.prank(stranger);
        vm.expectRevert();
        credit.collectFrom(alice, 1);
    }

    /// The allowance spent is the CALLER's, not the contract's or the owner's.
    function test_collectFrom_spendsTheCallersOwnAllowance() public {
        address stranger = address(0x5748);

        vm.prank(stranger);
        vm.expectRevert();
        credit.collectFrom(alice, PULL);

        assertEq(credit.allowance(alice, store), LIMIT, "another caller consumed the store's allowance");
    }

    /// Allowance is a ceiling, not a balance: the payer must still hold the credits.
    function test_collectFrom_revertsWhenThePayerIsShort() public {
        address broke = address(0xB204E);

        vm.prank(broke);
        credit.approve(store, LIMIT);

        vm.prank(store);
        vm.expectRevert();
        credit.collectFrom(broke, PULL);
    }

    /// Pulling credits never mints them.
    function test_collectFrom_preservesTotalSupply() public {
        vm.prank(store);
        credit.collectFrom(alice, PULL);

        assertEq(credit.totalSupply(), 1000 * 10 ** 18, "supply must not change");
    }

    /// Repeated pulls draw the same allowance down until it is exhausted.
    function test_collectFrom_canBeCalledUntilTheAllowanceRunsOut() public {
        vm.startPrank(store);
        credit.collectFrom(alice, LIMIT / 2);
        credit.collectFrom(alice, LIMIT / 2);

        assertEq(credit.allowance(alice, store), 0, "the allowance should be exhausted");

        vm.expectRevert();
        credit.collectFrom(alice, 1);
        vm.stopPrank();

        assertEq(credit.balanceOf(store), LIMIT, "the collector should hold exactly the limit");
    }
}
