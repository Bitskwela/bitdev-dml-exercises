// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Compile and Debug"
// (permaname: erc20-compile-and-debug).
//
// The starter carries four planted defects at once: a `^0.7.0` pragma the token
// cannot build under, a missing OpenZeppelin import, `constructr` misspelt, and
// therefore no base constructor call. The lesson is to read the compiler and fix
// each in turn.
//
// A compile check alone would be a weak gate — a student could delete the body
// and still "compile". So the suite compiles the fixed contract AND re-asserts
// the behaviour every earlier lesson established, proving the fixes restored the
// token rather than merely silencing solc.

import {Test} from "forge-std/Test.sol";
import {WorkshopCredit} from "../src/WorkshopCredit.sol";

contract WorkshopCreditTest is Test {
    WorkshopCredit internal credit;

    uint256 internal constant EXPECTED_SUPPLY = 1000 * 10 ** 18;

    function setUp() public {
        credit = new WorkshopCredit();
    }

    /// Deploying at all proves the pragma, the import and the constructor
    /// spelling were all fixed — a contract with any of them wrong never builds.
    function test_contract_deploys() public view {
        assertTrue(address(credit) != address(0), "WorkshopCredit failed to deploy");
    }

    /// The import must be the real OpenZeppelin ERC20, not a stub: the inherited
    /// surface has to answer.
    function test_inheritsTheRealErc20Surface() public view {
        assertEq(credit.decimals(), 18, "decimals() must come from the inherited ERC20");
        assertEq(credit.balanceOf(address(0xDEAD)), 0, "balanceOf() was not inherited");
        assertEq(credit.allowance(address(this), address(0xDEAD)), 0, "allowance() was not inherited");
    }

    /// The constructor must actually run — a misspelt one becomes a plain
    /// function and silently leaves the token empty and unnamed.
    function test_constructor_ranAtDeployment() public view {
        assertEq(credit.name(), "Workshop Credit", "constructor did not set the name");
        assertEq(credit.symbol(), "WCR", "constructor did not set the symbol");
        assertEq(credit.totalSupply(), EXPECTED_SUPPLY, "constructor did not mint the supply");
    }

    /// Lesson 9's scaling must survive the debugging pass.
    function test_supply_isStillScaledByDecimals() public view {
        assertEq(
            credit.totalSupply() / (10 ** credit.decimals()),
            1000,
            "supply must remain 1000 whole tokens"
        );
        assertEq(credit.balanceOf(address(this)), EXPECTED_SUPPLY, "deployer balance wrong");
    }

    /// A fixed contract is a working contract, not just a building one.
    function test_token_isFunctional() public {
        address student = address(0xA11CE);

        assertTrue(credit.transfer(student, 5 * 10 ** 18), "transfer failed after the fix");
        assertEq(credit.balanceOf(student), 5 * 10 ** 18, "recipient balance wrong");
    }
}
