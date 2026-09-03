// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Read Token Information"
// (permaname: erc20-read-token-information).
//
// The starter returns a hard-coded ("", "", 0, 0) tuple, so it compiles and even
// "works" — it just lies. The gate therefore checks that each slot is wired to
// the corresponding getter, and, crucially, that the summary TRACKS state rather
// than repeating constants: after a mint-free change to supply (a transfer does
// not change it, so the fourth slot is compared against totalSupply() directly)
// the reported values must still agree with the token.

import {Test} from "forge-std/Test.sol";
import {WorkshopCredit} from "../src/WorkshopCredit.sol";

contract WorkshopCreditTest is Test {
    WorkshopCredit internal credit;

    uint256 internal constant EXPECTED_SUPPLY = 1000 * 10 ** 18;

    function setUp() public {
        credit = new WorkshopCredit();
    }

    /// The task: one call returns all four pieces of token information.
    function test_creditSummary_returnsEveryField() public view {
        (string memory name_, string memory symbol_, uint8 decimals_, uint256 supply_) =
            credit.creditSummary();

        assertEq(name_, "Workshop Credit", "summary slot 1 must be name()");
        assertEq(symbol_, "WCR", "summary slot 2 must be symbol()");
        assertEq(decimals_, 18, "summary slot 3 must be decimals()");
        assertEq(supply_, EXPECTED_SUPPLY, "summary slot 4 must be totalSupply()");
    }

    /// Names the starter's failure mode explicitly.
    function test_creditSummary_isNotAnEmptyPlaceholder() public view {
        (string memory name_, string memory symbol_, uint8 decimals_, uint256 supply_) =
            credit.creditSummary();

        assertTrue(bytes(name_).length > 0, "summary still returns an empty name");
        assertTrue(bytes(symbol_).length > 0, "summary still returns an empty symbol");
        assertTrue(decimals_ > 0, "summary still returns 0 decimals");
        assertTrue(supply_ > 0, "summary still returns 0 supply");
    }

    /// Each slot must come from the real getter, not a duplicated literal.
    function test_creditSummary_agreesWithTheGetters() public view {
        (string memory name_, string memory symbol_, uint8 decimals_, uint256 supply_) =
            credit.creditSummary();

        assertEq(name_, credit.name(), "summary name disagrees with name()");
        assertEq(symbol_, credit.symbol(), "summary symbol disagrees with symbol()");
        assertEq(decimals_, credit.decimals(), "summary decimals disagrees with decimals()");
        assertEq(supply_, credit.totalSupply(), "summary supply disagrees with totalSupply()");
    }

    /// Reading is free and non-mutating: calling it must change nothing.
    function test_creditSummary_isReadOnly() public {
        credit.creditSummary();

        assertEq(credit.totalSupply(), EXPECTED_SUPPLY, "reading changed the supply");
        assertEq(credit.balanceOf(address(this)), EXPECTED_SUPPLY, "reading changed a balance");
    }

    /// The summary must follow the ledger, not a snapshot taken at deployment.
    function test_creditSummary_tracksLaterState() public {
        credit.transfer(address(0xA11CE), 400 * 10 ** 18);

        (,,, uint256 supply_) = credit.creditSummary();
        assertEq(supply_, credit.totalSupply(), "summary supply must be read live");
    }
}
