// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Create the Initial Supply"
// (permaname: erc20-create-initial-supply).
//
// The lesson's answer mints a NAIVE 1000 — raw base units, which a wallet shows
// as 0.000000000000001000 WCR. That is deliberate: Lesson 9 exists to explain
// why. So this suite asserts exactly 1000 base units and nothing about decimals
// scaling; asserting 1000 * 10**18 here would fail the lesson's own answer and
// pre-empt the next lesson's punchline.
//
// The starter's constructor body is empty, so totalSupply() is 0.

import {Test} from "forge-std/Test.sol";
import {WorkshopCredit} from "../src/WorkshopCredit.sol";

contract WorkshopCreditTest is Test {
    WorkshopCredit internal credit;

    function setUp() public {
        credit = new WorkshopCredit();
    }

    /// Task: _mint must run in the constructor, so supply exists at deployment.
    function test_totalSupply_isMintedAtDeployment() public view {
        assertEq(credit.totalSupply(), 1000, "constructor must mint 1000 base units");
    }

    /// _mint(msg.sender, ...) credits the deployer, not the contract.
    function test_deployerHoldsTheEntireSupply() public view {
        assertEq(credit.balanceOf(address(this)), 1000, "the deployer must hold the supply");
        assertEq(credit.balanceOf(address(credit)), 0, "the contract must not hold the supply");
    }

    /// Supply exists means it can move — the mint is real balance, not a number.
    function test_mintedSupply_isSpendable() public {
        address student = address(0xA11CE);

        assertTrue(credit.transfer(student, 250), "transfer of minted supply failed");
        assertEq(credit.balanceOf(student), 250, "recipient balance wrong");
        assertEq(credit.balanceOf(address(this)), 750, "sender balance wrong");
        assertEq(credit.totalSupply(), 1000, "transferring must not change total supply");
    }

    /// Minting creates tokens from nowhere: the ledger's from-address is zero.
    function test_supplyIsBackedByBalances() public view {
        assertEq(
            credit.balanceOf(address(this)),
            credit.totalSupply(),
            "every minted token must be held by someone"
        );
    }

    /// Metadata from Lesson 7 must survive adding the mint.
    function test_metadata_isPreserved() public view {
        assertEq(credit.name(), "Workshop Credit", "name() regressed");
        assertEq(credit.symbol(), "WCR", "symbol() regressed");
    }
}
