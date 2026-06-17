// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Token Transfer with Approval System"
// (permaname: sq-1-token-transfer-and-approval).
//
// The grader writes the student's submission to `src/SanJuanToken.sol` and drops
// this file in as `test/Exercise.t.sol`, so the import resolves against the
// assembled layout. The deployer (this test contract) receives the entire initial
// supply via the constructor.
//
// Coverage: the lesson asks the student to complete `approve()` and
// `transferFrom()`. These tests prove the full token surface — balanceOf/transfer
// happy paths, approve+allowance bookkeeping, transferFrom moving funds AND
// decrementing the allowance, plus the two revert cases ("Not enough balance",
// "Allowance exceeded") using the answer's exact strings.

import {Test} from "forge-std/Test.sol";
import {SanJuanToken} from "../src/SanJuanToken.sol";

contract SanJuanTokenTest is Test {
    SanJuanToken internal token;

    uint256 internal constant SUPPLY = 1_000_000 ether;

    address internal alice = makeAddr("alice");
    address internal bob = makeAddr("bob");
    address internal carol = makeAddr("carol");

    function setUp() public {
        // Test contract is the deployer and holds the full initial supply.
        token = new SanJuanToken(SUPPLY);
    }

    function test_initialState_metadataAndSupply() public view {
        assertEq(token.name(), "SanJuanToken", "name mismatch");
        assertEq(token.symbol(), "SJT", "symbol mismatch");
        assertEq(token.decimals(), 18, "decimals mismatch");
        assertEq(token.totalSupply(), SUPPLY, "totalSupply mismatch");
        assertEq(token.balanceOf(address(this)), SUPPLY, "deployer should hold full supply");
    }

    function test_transfer_movesBalance() public {
        bool ok = token.transfer(alice, 100 ether);
        assertTrue(ok, "transfer should return true");
        assertEq(token.balanceOf(alice), 100 ether, "recipient balance wrong");
        assertEq(token.balanceOf(address(this)), SUPPLY - 100 ether, "sender balance wrong");
    }

    function test_transfer_revertsOnInsufficientBalance() public {
        // alice has no tokens.
        vm.prank(alice);
        vm.expectRevert(bytes("Not enough balance"));
        token.transfer(bob, 1);
    }

    function test_approve_setsAllowance() public {
        bool ok = token.approve(bob, 500 ether);
        assertTrue(ok, "approve should return true");
        assertEq(token.allowance(address(this), bob), 500 ether, "allowance not set");
    }

    function test_transferFrom_movesFundsAndDecrementsAllowance() public {
        // Owner funds alice, alice approves bob, bob pulls from alice to carol.
        token.transfer(alice, 200 ether);

        vm.prank(alice);
        token.approve(bob, 150 ether);

        vm.prank(bob);
        bool ok = token.transferFrom(alice, carol, 120 ether);
        assertTrue(ok, "transferFrom should return true");

        assertEq(token.balanceOf(alice), 80 ether, "alice balance wrong after transferFrom");
        assertEq(token.balanceOf(carol), 120 ether, "carol balance wrong after transferFrom");
        assertEq(token.allowance(alice, bob), 30 ether, "allowance not decremented");
    }

    function test_transferFrom_revertsWhenAllowanceExceeded() public {
        token.transfer(alice, 200 ether);

        vm.prank(alice);
        token.approve(bob, 50 ether);

        // bob tries to pull more than approved.
        vm.prank(bob);
        vm.expectRevert(bytes("Allowance exceeded"));
        token.transferFrom(alice, carol, 100 ether);
    }

    function test_transferFrom_revertsWhenBalanceInsufficient() public {
        // alice approves bob generously but holds nothing.
        vm.prank(alice);
        token.approve(bob, 1_000 ether);

        vm.prank(bob);
        vm.expectRevert(bytes("Not enough balance"));
        token.transferFrom(alice, carol, 1 ether);
    }
}
