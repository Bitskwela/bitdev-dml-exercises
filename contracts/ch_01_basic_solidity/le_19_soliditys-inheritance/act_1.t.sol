// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {DerivedContract} from "../src/DerivedContract.sol";

contract DerivedContractTest is Test {
    DerivedContract internal c;

    function setUp() public {
        c = new DerivedContract();
    }

    // Inherited behavior from BaseContract
    function test_setOrganizationName() public {
        c.setOrganizationName("Barangay Dev");
        assertEq(c.organizationName(), "Barangay Dev", "organization name should be set");
    }

    function test_setOrganizationName_revertsOnEmpty() public {
        vm.expectRevert(bytes("Name cannot be empty"));
        c.setOrganizationName("");
    }

    // Overridden / child behavior
    function test_depositFunds() public {
        c.depositFunds(500);
        assertEq(c.fundBalance(), 500, "fund balance should equal deposit");
    }

    function test_depositFunds_revertsOnZero() public {
        vm.expectRevert(bytes("Amount must be greater than zero"));
        c.depositFunds(0);
    }

    // Edge cases
    function test_depositFunds_accumulates() public {
        c.depositFunds(100);
        c.depositFunds(250);
        assertEq(c.fundBalance(), 350, "fund balance should accumulate");
    }

    function test_organizationName_emptyInitially() public view {
        assertEq(c.organizationName(), "", "organization name empty before set");
    }
}
