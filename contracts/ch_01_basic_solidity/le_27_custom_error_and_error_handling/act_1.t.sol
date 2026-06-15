// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {CustomErrorExample, UnauthorizedAccess, InsufficientFunds} from "../src/CustomErrorExample.sol";

contract CustomErrorExampleTest is Test {
    CustomErrorExample internal c;
    address internal nonOwner = address(0xBEEF);

    function setUp() public {
        // Deployed by this test contract, so owner == address(this).
        c = new CustomErrorExample();
    }

    function test_initialState() public view {
        assertEq(c.owner(), address(this), "owner should be deployer");
        assertEq(c.checkBalance(), 1000, "initial balance should be 1000");
    }

    function test_ownerCanWithdraw() public {
        c.withdraw(500);
        assertEq(c.checkBalance(), 500, "balance should decrease after withdraw");
    }

    function test_revertsUnauthorizedAccess() public {
        vm.prank(nonOwner);
        vm.expectRevert(abi.encodeWithSelector(UnauthorizedAccess.selector, nonOwner));
        c.withdraw(100);
    }

    function test_revertsInsufficientFunds() public {
        vm.expectRevert(abi.encodeWithSelector(InsufficientFunds.selector, uint256(2000), uint256(1000)));
        c.withdraw(2000);
    }

    // Edge cases
    function test_withdrawFullBalance() public {
        c.withdraw(1000);
        assertEq(c.checkBalance(), 0, "full withdrawal empties balance");
    }

    function test_unauthorizedCheckedBeforeFunds() public {
        // Non-owner withdrawing an over-balance amount should hit the auth check first.
        vm.prank(nonOwner);
        vm.expectRevert(abi.encodeWithSelector(UnauthorizedAccess.selector, nonOwner));
        c.withdraw(5000);
    }
}
