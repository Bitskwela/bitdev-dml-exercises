// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {SecureFund} from "../src/SecureFund.sol";

contract SecureFundTest is Test {
    SecureFund internal fund;

    address internal donor = address(0xD0);

    function setUp() public {
        // Test contract is the deployer, therefore the owner.
        fund = new SecureFund();
        vm.deal(donor, 10 ether);
    }

    function test_owner_isDeployer() public {
        assertEq(fund.owner(), address(this), "deployer should be owner");
    }

    function test_donate_updatesTotalDonations() public {
        uint256 donation = 1 ether;
        vm.prank(donor);
        fund.donate{value: donation}();
        assertEq(fund.totalDonations(), donation, "totalDonations not updated");
    }

    function test_donate_accumulatesAcrossCalls() public {
        vm.prank(donor);
        fund.donate{value: 1 ether}();
        vm.prank(donor);
        fund.donate{value: 2 ether}();
        assertEq(fund.totalDonations(), 3 ether, "donations should accumulate");
    }

    function test_donate_revertsOnZero() public {
        vm.prank(donor);
        vm.expectRevert(bytes("Donation must be greater than zero"));
        fund.donate{value: 0}();
    }

    function test_withdraw_allowsOwner() public {
        vm.prank(donor);
        fund.donate{value: 1 ether}();

        uint256 balanceBefore = address(this).balance;
        // Owner is this test contract.
        fund.withdraw();
        assertEq(
            address(this).balance,
            balanceBefore + 1 ether,
            "owner did not receive funds"
        );
        assertEq(address(fund).balance, 0, "contract balance not emptied");
    }

    function test_withdraw_revertsForNonOwner() public {
        vm.prank(donor);
        fund.donate{value: 1 ether}();

        vm.prank(donor);
        vm.expectRevert(bytes("Not the owner"));
        fund.withdraw();
    }

    // Required to receive Ether on withdraw().
    receive() external payable {}
}
