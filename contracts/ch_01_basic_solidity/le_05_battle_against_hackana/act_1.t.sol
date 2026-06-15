// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {CommunityFund} from "../src/CommunityFund.sol";

contract CommunityFundTest is Test {
    CommunityFund internal fund;

    address internal donor = address(0xD0);
    address internal outsider = address(0x012);

    function setUp() public {
        // Test contract is the deployer, therefore the fund owner.
        fund = new CommunityFund();
        vm.deal(donor, 10 ether);
        vm.deal(outsider, 10 ether);
    }

    function test_fundOwner_isDeployer() public {
        assertEq(fund.fundOwner(), address(this), "deployer should be fund owner");
    }

    function test_initialTotalDonations_isZero() public {
        assertEq(fund.totalDonations(), 0, "initial donations should be zero");
    }

    function test_donate_updatesTotalDonations() public {
        uint256 amount = 1 ether;
        vm.prank(donor);
        fund.donate{value: amount}(amount);
        assertEq(fund.totalDonations(), amount, "totalDonations not updated");
    }

    function test_donate_accumulatesAcrossCalls() public {
        vm.prank(donor);
        fund.donate{value: 1 ether}(1 ether);
        vm.prank(donor);
        fund.donate{value: 2 ether}(2 ether);
        assertEq(fund.totalDonations(), 3 ether, "donations should accumulate");
    }

    function test_donate_revertsOnZero() public {
        vm.prank(donor);
        vm.expectRevert(bytes("Donation must be greater than zero"));
        fund.donate{value: 0}(0);
    }

    function test_donate_revertsOnMismatchedValue() public {
        vm.prank(donor);
        vm.expectRevert(bytes("Insufficient Ether provided"));
        fund.donate{value: 0.5 ether}(1 ether);
    }

    function test_withdraw_allowsOwner() public {
        vm.prank(donor);
        fund.donate{value: 1 ether}(1 ether);

        // Owner is this test contract.
        fund.withdraw(0.5 ether);
        assertEq(fund.totalDonations(), 0.5 ether, "totalDonations not reduced");
    }

    function test_withdraw_revertsForNonOwner() public {
        vm.prank(donor);
        fund.donate{value: 1 ether}(1 ether);

        vm.prank(outsider);
        vm.expectRevert(bytes("Only the owner can withdraw funds"));
        fund.withdraw(1);
    }

    // Required to receive Ether on withdraw().
    receive() external payable {}
}
