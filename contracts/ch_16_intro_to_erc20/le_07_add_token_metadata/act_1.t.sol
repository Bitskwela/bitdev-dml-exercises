// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Add Token Metadata"
// (permaname: erc20-add-token-metadata).
//
// Unlike Lesson 6, this starter COMPILES — it hands ERC20 two empty strings. So
// a compile check would pass a wrong answer, and the whole gate rests on the
// stored values being the real ones. The empty-string assertions below are
// therefore not decoration: they are the only thing separating the starter from
// the answer.
//
// totalSupply() stays 0 here on purpose. Supply is Lesson 8's job, and asserting
// it now would mark a correct Lesson 7 answer wrong.

import {Test} from "forge-std/Test.sol";
import {WorkshopCredit} from "../src/WorkshopCredit.sol";

contract WorkshopCreditTest is Test {
    WorkshopCredit internal credit;

    function setUp() public {
        credit = new WorkshopCredit();
    }

    /// Task 1: the full name, passed as the FIRST base constructor argument.
    function test_name_isTheFullTokenName() public view {
        assertEq(credit.name(), "Workshop Credit", "name() must return Workshop Credit");
    }

    /// Task 1: the ticker, passed as the SECOND argument. Order matters.
    function test_symbol_isTheTicker() public view {
        assertEq(credit.symbol(), "WCR", "symbol() must return WCR");
    }

    /// The starter's failure mode, named explicitly so the report is readable.
    function test_metadata_isNotLeftEmpty() public view {
        assertTrue(bytes(credit.name()).length > 0, "name() is still an empty string");
        assertTrue(bytes(credit.symbol()).length > 0, "symbol() is still an empty string");
    }

    /// Name and symbol are distinct fields — swapping the two arguments is wrong.
    function test_nameAndSymbol_areNotSwapped() public view {
        assertTrue(
            keccak256(bytes(credit.name())) != keccak256(bytes(credit.symbol())),
            "name and symbol must not hold the same value"
        );
        assertTrue(
            bytes(credit.name()).length > bytes(credit.symbol()).length,
            "the full name and the ticker look swapped"
        );
    }

    /// Metadata is set once at deployment and never drifts.
    function test_metadata_isStableAcrossCalls() public view {
        assertEq(credit.name(), "Workshop Credit", "name() changed between calls");
        assertEq(credit.symbol(), "WCR", "symbol() changed between calls");
    }

    /// An identity, not yet a supply — minting is Lesson 8.
    function test_identityWithoutSupply() public view {
        assertEq(credit.decimals(), 18, "decimals() must be the inherited 18");
        assertEq(credit.totalSupply(), 0, "no tokens should exist yet");
    }
}
