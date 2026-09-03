// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Understand Token Decimals"
// (permaname: erc20-understand-decimals).
//
// This is the correction of Lesson 8: the naive `_mint(msg.sender, 1000)` becomes
// `1000 * 10 ** decimals()`, so a wallet shows 1,000 WCR instead of
// 0.000000000000001000. The starter here is precisely Lesson 8's answer, so the
// gate turns entirely on the scaling factor.
//
// The expected figure is written as `1000 * 10 ** 18` rather than a literal so
// the intent — a thousand WHOLE tokens — stays readable in the failure message.

import {Test} from "forge-std/Test.sol";
import {WorkshopCredit} from "../src/WorkshopCredit.sol";

contract WorkshopCreditTest is Test {
    WorkshopCredit internal credit;

    /// A thousand whole tokens, expressed the way the answer expresses it.
    uint256 internal constant WHOLE_TOKENS = 1000;
    uint256 internal constant EXPECTED_SUPPLY = WHOLE_TOKENS * 10 ** 18;

    function setUp() public {
        credit = new WorkshopCredit();
    }

    /// The task: scale the mint by 10 ** decimals().
    function test_totalSupply_isScaledByDecimals() public view {
        assertEq(
            credit.totalSupply(),
            EXPECTED_SUPPLY,
            "mint 1000 * 10 ** decimals(), not a bare 1000"
        );
    }

    /// Names the Lesson 8 mistake explicitly, so the report reads as a diagnosis.
    function test_supply_isNotTheNaiveBaseUnitAmount() public view {
        assertTrue(
            credit.totalSupply() != WHOLE_TOKENS,
            "1000 base units is 0.000000000000001000 WCR: scale by decimals()"
        );
    }

    /// The scaling must derive from decimals(), which is 18 for this token.
    function test_scaling_matchesTheTokensDecimals() public view {
        assertEq(credit.decimals(), 18, "decimals() must be the inherited 18");
        assertEq(
            credit.totalSupply() / (10 ** credit.decimals()),
            WHOLE_TOKENS,
            "supply must be exactly 1000 whole tokens"
        );
    }

    /// The deployer holds all of it, in the same scaled units.
    function test_deployerHoldsTheScaledSupply() public view {
        assertEq(
            credit.balanceOf(address(this)),
            EXPECTED_SUPPLY,
            "the deployer must hold the whole scaled supply"
        );
    }

    /// Transfers are denominated in base units too — half a token is expressible.
    function test_fractionalTransfersAreExpressible() public {
        address student = address(0xA11CE);
        uint256 half = 10 ** 18 / 2;

        assertTrue(credit.transfer(student, half), "transfer failed");
        assertEq(credit.balanceOf(student), half, "0.5 WCR should be representable");
        assertEq(credit.totalSupply(), EXPECTED_SUPPLY, "supply must not change on transfer");
    }

    /// Metadata from the earlier lessons must survive the fix.
    function test_metadata_isPreserved() public view {
        assertEq(credit.name(), "Workshop Credit", "name() regressed");
        assertEq(credit.symbol(), "WCR", "symbol() regressed");
    }
}
