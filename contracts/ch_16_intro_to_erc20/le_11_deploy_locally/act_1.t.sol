// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Deploy Locally"
// (permaname: erc20-deploy-locally).
//
// The starter deploys perfectly well — and mints nothing (`_mint(msg.sender, 0)`),
// which is exactly the trap: a green "Deployment successful" toast next to a
// wallet showing 0 WCR. So the gate is not "does it deploy" but "did the
// deployment actually put the supply in the deployer's hands".
//
// The deployer here is the test contract, because it is the account that runs
// `new WorkshopCredit()` — the same relationship as your Remix account and the
// deployed token.

import {Test} from "forge-std/Test.sol";
import {WorkshopCredit} from "../src/WorkshopCredit.sol";

contract WorkshopCreditTest is Test {
    WorkshopCredit internal credit;

    uint256 internal constant EXPECTED_SUPPLY = 1000 * 10 ** 18;

    function setUp() public {
        credit = new WorkshopCredit();
    }

    /// Deployment gives the contract a live address of its own.
    function test_deploysToItsOwnAddress() public view {
        assertTrue(address(credit) != address(0), "deployment failed");
        assertTrue(address(credit).code.length > 0, "no code at the deployed address");
    }

    /// The whole point: constructor state exists the moment it is deployed.
    function test_supplyExistsImmediatelyAfterDeployment() public view {
        assertEq(credit.totalSupply(), EXPECTED_SUPPLY, "deployment must mint 1000 whole WCR");
    }

    /// Names the starter's failure mode, so the report diagnoses rather than scolds.
    function test_supply_isNotZero() public view {
        assertTrue(credit.totalSupply() > 0, "the token deployed but minted nothing");
    }

    /// _mint(msg.sender, ...) means the DEPLOYER holds it — check the wallet.
    function test_deployerReceivesTheSupply() public view {
        assertEq(
            credit.balanceOf(address(this)),
            EXPECTED_SUPPLY,
            "the deploying account must hold the whole supply"
        );
    }

    /// Identity survives deployment intact.
    function test_deployedTokenKeepsItsIdentity() public view {
        assertEq(credit.name(), "Workshop Credit", "name() regressed");
        assertEq(credit.symbol(), "WCR", "symbol() regressed");
        assertEq(credit.decimals(), 18, "decimals() regressed");
    }

    /// Each deployment is a separate token with its own fresh supply.
    function test_eachDeploymentMintsItsOwnSupply() public {
        WorkshopCredit second = new WorkshopCredit();

        assertTrue(address(second) != address(credit), "expected a distinct address");
        assertEq(second.totalSupply(), EXPECTED_SUPPLY, "the second deployment minted nothing");
        assertEq(second.balanceOf(address(this)), EXPECTED_SUPPLY, "second deployer balance wrong");
    }
}
