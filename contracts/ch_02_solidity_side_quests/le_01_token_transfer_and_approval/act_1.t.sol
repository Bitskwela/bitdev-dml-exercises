// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Token Transfer with Approval System"
// (permaname: sq-1-token-transfer-and-approval).
//
// The starter already ships a working `transfer`; `approve` and `transferFrom`
// are the empty bodies. Both compile — a function with a declared return and no
// return statement yields the zero value — so they silently return false and
// grant nothing. Every assertion here is therefore about state actually moving.
//
// The grader writes the submission to src/SanJuanToken.sol (spec.json ->
// source_file). The constructor takes the initial supply, so setUp mints it here.

import {Test} from "forge-std/Test.sol";
import {SanJuanToken} from "../src/SanJuanToken.sol";

contract SanJuanTokenTest is Test {
    SanJuanToken internal token;

    uint256 internal constant SUPPLY = 1_000_000 ether;

    address internal alice = address(0xA11CE);
    address internal bob = address(0xB0B);

    function setUp() public {
        token = new SanJuanToken(SUPPLY);
    }

    /// The pre-existing behaviour must survive the change.
    function test_constructor_seedsTheDeployer() public view {
        assertEq(token.totalSupply(), SUPPLY, "totalSupply not set");
        assertEq(token.balanceOf(address(this)), SUPPLY, "deployer was not credited");
        assertEq(token.name(), "SanJuanToken", "name regressed");
        assertEq(token.symbol(), "SJT", "symbol regressed");
        assertEq(token.decimals(), 18, "decimals regressed");
    }

    /// Task 1: approve must record the allowance and report success.
    function test_approve_recordsTheAllowance() public {
        assertTrue(token.approve(bob, 500 ether), "approve must return true");
        assertEq(token.allowance(address(this), bob), 500 ether, "allowance not recorded");
    }

    /// Approval is permission, not payment.
    function test_approve_movesNoTokens() public {
        token.approve(bob, 500 ether);

        assertEq(token.balanceOf(address(this)), SUPPLY, "the approver was debited");
        assertEq(token.balanceOf(bob), 0, "the spender was credited");
    }

    /// Approving again overwrites rather than accumulating.
    function test_approve_overwrites() public {
        token.approve(bob, 500 ether);
        token.approve(bob, 100 ether);

        assertEq(token.allowance(address(this), bob), 100 ether, "approve must overwrite");
    }

    /// Task 2: an approved spender moves someone else's tokens.
    function test_transferFrom_movesTokensWithinTheAllowance() public {
        token.approve(bob, 500 ether);

        vm.prank(bob);
        assertTrue(token.transferFrom(address(this), alice, 200 ether), "must return true");

        assertEq(token.balanceOf(alice), 200 ether, "recipient not credited");
        assertEq(token.balanceOf(address(this)), SUPPLY - 200 ether, "owner not debited");
    }

    /// Spending draws the allowance down — otherwise it is an infinite licence.
    function test_transferFrom_consumesTheAllowance() public {
        token.approve(bob, 500 ether);

        vm.prank(bob);
        token.transferFrom(address(this), alice, 200 ether);

        assertEq(token.allowance(address(this), bob), 300 ether, "allowance not consumed");
    }

    /// No approval means no transfer. This is the access control.
    function test_transferFrom_revertsWithoutAnAllowance() public {
        vm.prank(bob);
        vm.expectRevert(bytes("Allowance exceeded"));
        token.transferFrom(address(this), alice, 1 ether);
    }

    /// Beyond the allowance is refused even when the owner is rich.
    function test_transferFrom_revertsBeyondTheAllowance() public {
        token.approve(bob, 100 ether);

        vm.prank(bob);
        vm.expectRevert(bytes("Allowance exceeded"));
        token.transferFrom(address(this), alice, 101 ether);
    }

    /// An allowance is a ceiling, not a balance: the owner must hold the tokens.
    function test_transferFrom_revertsWhenTheOwnerIsShort() public {
        vm.prank(alice);
        token.approve(bob, 500 ether);

        vm.prank(bob);
        vm.expectRevert(bytes("Not enough balance"));
        token.transferFrom(alice, bob, 1 ether);
    }

    /// Moving tokens never creates them.
    function test_transferFrom_preservesTotalSupply() public {
        token.approve(bob, 500 ether);

        vm.prank(bob);
        token.transferFrom(address(this), alice, 200 ether);

        assertEq(token.totalSupply(), SUPPLY, "supply must not change");
    }
}
