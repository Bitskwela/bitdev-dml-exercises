// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {HackanaDefense} from "../src/HackanaDefense.sol";

contract HackanaDefenseTest is Test {
    HackanaDefense internal defense;

    address internal outsider = address(0x012);

    function setUp() public {
        // Test contract is the deployer, therefore the owner.
        defense = new HackanaDefense();
    }

    function test_owner_isDeployer() public {
        assertEq(defense.owner(), address(this), "deployer should be owner");
    }

    function test_initialCriticalData_isZero() public {
        assertEq(defense.criticalData(), 0, "initial criticalData should be zero");
    }

    function test_updateCriticalData_storesValue() public {
        defense.updateCriticalData(42);
        assertEq(defense.criticalData(), 42, "criticalData not updated");
    }

    function test_restrictedUpdate_allowsOwner() public {
        defense.restrictedUpdate(100);
        assertEq(defense.criticalData(), 100, "owner update failed");
    }

    function test_restrictedUpdate_revertsForNonOwner() public {
        vm.prank(outsider);
        vm.expectRevert(
            bytes("Access denied: Only the owner can update critical data.")
        );
        defense.restrictedUpdate(200);
    }
}
