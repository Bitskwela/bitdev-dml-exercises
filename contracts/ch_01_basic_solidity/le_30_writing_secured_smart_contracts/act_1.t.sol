// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Writing Secured Smart Contracts" (writing-secure-smart-contracts).
// SecureDonation is Ownable + ReentrancyGuard. The test contract is the owner
// (deployer) and implements receive() so withdraw() can pay it back.

import {Test} from "forge-std/Test.sol";
import {SecureDonation} from "../src/SecureDonation.sol";

contract SecureDonationTest is Test {
    SecureDonation internal donation;
    address internal addr1 = address(0xA11CE);
    address internal addr2 = address(0xB0B);

    function setUp() public {
        donation = new SecureDonation();
        vm.deal(addr1, 10 ether);
        vm.deal(addr2, 10 ether);
    }

    // Allow withdraw() (which pays the owner) to send ETH back to this contract.
    receive() external payable {}

    function test_acceptsAndTracksDonations() public {
        vm.prank(addr1);
        donation.donate{value: 1 ether}();
        vm.prank(addr2);
        donation.donate{value: 0.5 ether}();

        assertEq(donation.donations(addr1), 1 ether, "addr1 donation");
        assertEq(donation.donations(addr2), 0.5 ether, "addr2 donation");
        assertEq(donation.totalDonations(), 1.5 ether, "total donations");
    }

    function test_rejectsZeroDonation() public {
        vm.prank(addr1);
        vm.expectRevert(bytes("Donation must be greater than zero."));
        donation.donate{value: 0}();
    }

    function test_withdrawRevertsWhenNoFunds() public {
        // This contract is the owner; withdraw with an empty balance must revert.
        vm.expectRevert(bytes("No funds to withdraw."));
        donation.withdraw();
    }

    function test_ownerCanWithdrawAllFunds() public {
        vm.prank(addr1);
        donation.donate{value: 2 ether}();

        uint256 balanceBefore = address(this).balance;
        donation.withdraw();

        assertEq(address(this).balance, balanceBefore + 2 ether, "owner received funds");
        assertEq(address(donation).balance, 0, "contract drained");
    }

    function test_nonOwnerCannotWithdraw() public {
        vm.prank(addr1);
        donation.donate{value: 1 ether}();

        vm.prank(addr2);
        vm.expectRevert(); // OZ Ownable: OwnableUnauthorizedAccount
        donation.withdraw();
    }
}
