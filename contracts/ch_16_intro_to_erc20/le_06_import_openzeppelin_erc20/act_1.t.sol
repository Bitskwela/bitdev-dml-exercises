// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Import OpenZeppelin ERC20"
// (permaname: erc20-import-openzeppelin).
//
// The starter is shipped deliberately broken: `contract WorkshopCredit is ERC20`
// with no constructor, which cannot compile because the base demands a name and
// a symbol. The lesson is to read that error and satisfy it with a base
// constructor call. So this suite proves the inheritance is real — the token
// answers the full ERC-20 surface it never implemented — rather than merely that
// two strings came back.
//
// The OpenZeppelin import resolves through the spec's `allowed_imports`
// remapping, which maps the lesson's version-pinned prefix onto the copy the
// grader image vendors.

import {Test} from "forge-std/Test.sol";
import {WorkshopCredit} from "../src/WorkshopCredit.sol";

contract WorkshopCreditTest is Test {
    WorkshopCredit internal credit;

    function setUp() public {
        credit = new WorkshopCredit();
    }

    /// Task 3: the base constructor must receive the token's name.
    function test_name_comesFromTheBaseConstructor() public view {
        assertEq(credit.name(), "Workshop Credit", "name() must return Workshop Credit");
    }

    /// Task 3: and its symbol.
    function test_symbol_comesFromTheBaseConstructor() public view {
        assertEq(credit.symbol(), "WCR", "symbol() must return WCR");
    }

    /// Inheriting ERC20 brings decimals() for free — 18 is the base default.
    function test_decimals_isInheritedDefault() public view {
        assertEq(credit.decimals(), 18, "decimals() must be the inherited 18");
    }

    /// Minting arrives in Lesson 8. Inheriting alone must not create supply.
    function test_totalSupply_isStillZero() public view {
        assertEq(credit.totalSupply(), 0, "no tokens should exist yet");
        assertEq(credit.balanceOf(address(this)), 0, "the deployer holds nothing yet");
    }

    /// The point of inheriting: real, tested bodies the student did not write.
    function test_inheritedWriteFunctions_areCallable() public {
        address spender = address(0xB0B);

        assertTrue(credit.approve(spender, 42), "approve() was not inherited");
        assertEq(credit.allowance(address(this), spender), 42, "allowance() not tracked");
        assertTrue(credit.transfer(address(0xA11CE), 0), "transfer() was not inherited");
    }

    /// Inherited behaviour includes the guards: an over-spend still reverts.
    function test_inheritedTransfer_revertsWithoutBalance() public {
        vm.expectRevert();
        credit.transfer(address(0xA11CE), 1);
    }
}
