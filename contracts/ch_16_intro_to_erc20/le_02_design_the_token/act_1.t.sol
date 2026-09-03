// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Design the Token"
// (permaname: erc20-design-the-token).
//
// The grader writes the student's submission to `src/WorkshopCreditDesign.sol`
// (spec.json -> source_file).
//
// The lesson captures six design decisions as code: NAME, SYMBOL, DECIMALS and
// INITIAL_SUPPLY as public constants, and `admin` as a public immutable set to
// the deployer. Nothing here is a working token yet — the tests assert the
// stated design, exactly as the lesson asks.

import {Test} from "forge-std/Test.sol";
import {WorkshopCreditDesign} from "../src/WorkshopCreditDesign.sol";

contract WorkshopCreditDesignTest is Test {
    WorkshopCreditDesign internal design;

    address internal constant DEPLOYER = address(0xDA11);

    function setUp() public {
        design = new WorkshopCreditDesign();
    }

    /// Task 1: the token's identity, spelled exactly as the napkin says.
    function test_identity_isNameAndSymbol() public view {
        assertEq(design.NAME(), "Workshop Credit", "NAME must be \"Workshop Credit\"");
        assertEq(design.SYMBOL(), "WCR", "SYMBOL must be the uppercase ticker \"WCR\"");
    }

    /// Task 2: 18 decimals, the ERC-20 default.
    function test_precision_is18Decimals() public view {
        assertEq(design.DECIMALS(), 18, "DECIMALS must be the ERC-20 default of 18");
    }

    /// Task 3: the launch supply, in whole credits.
    function test_supply_is1000WholeCredits() public view {
        assertEq(design.INITIAL_SUPPLY(), 1000, "INITIAL_SUPPLY must be 1000");
    }

    /// Task 4: `admin` is the account that deployed the contract.
    function test_admin_isTheDeployer() public view {
        assertEq(design.admin(), address(this), "admin must be set to the deployer");
    }

    /// Task 4, the part a hardcoded address would pass without: deploying from
    /// a different account must produce a different admin, proving `admin` is
    /// assigned from `msg.sender` rather than written in as a literal.
    function test_admin_followsWhoeverDeploys() public {
        vm.prank(DEPLOYER);
        WorkshopCreditDesign other = new WorkshopCreditDesign();

        assertEq(other.admin(), DEPLOYER, "admin must come from msg.sender, not a literal");
    }
}
