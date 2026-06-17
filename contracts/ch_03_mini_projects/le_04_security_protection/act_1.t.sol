// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Barangay Aid Vault" (proj-4-barangay-aid-vault).
// The student hardens a donation vault: donors earmark ETH per recipient,
// recipients pull their own funds, and only the owner (deployer) may sweep
// the vault in an emergency — using msg.sender, never tx.origin.

import {Test} from "forge-std/Test.sol";
import {BarangayAidVault} from "../src/BarangayAidVault.sol";

contract BarangayAidVaultTest is Test {
    BarangayAidVault internal vault;

    address internal donor = address(0xD0);
    address internal recipient = address(0x4EC1);
    address internal outsider = address(0x0107);

    event AidDeposited(address indexed donor, address indexed recipient, uint256 amount);
    event AidClaimed(address indexed recipient, uint256 amount);

    function setUp() public {
        // Test contract is the deployer, therefore the owner.
        vault = new BarangayAidVault();
        vm.deal(donor, 100 ether);
    }

    function test_owner_isDeployer() public view {
        assertEq(vault.owner(), address(this), "deployer should be owner");
    }

    function test_depositAid_creditsRecipientAndEmits() public {
        vm.expectEmit(true, true, false, true);
        emit AidDeposited(donor, recipient, 3 ether);

        vm.prank(donor);
        vault.depositAid{value: 3 ether}(recipient);

        assertEq(vault.claimable(recipient), 3 ether, "recipient not credited");
    }

    function test_depositAid_revertsOnZeroValue() public {
        vm.prank(donor);
        vm.expectRevert(bytes("Cannot send 0 ETH"));
        vault.depositAid{value: 0}(recipient);
    }

    function test_claimAid_paysRecipientAndZeroesBalance() public {
        vm.prank(donor);
        vault.depositAid{value: 5 ether}(recipient);

        uint256 before = recipient.balance;

        vm.expectEmit(true, false, false, true);
        emit AidClaimed(recipient, 5 ether);

        vm.prank(recipient);
        vault.claimAid();

        assertEq(recipient.balance, before + 5 ether, "recipient did not receive ETH");
        assertEq(vault.claimable(recipient), 0, "claimable not zeroed");
    }

    function test_claimAid_revertsWhenNothingToClaim() public {
        vm.prank(outsider);
        vm.expectRevert(bytes("Nothing to claim"));
        vault.claimAid();
    }

    function test_emergencyWithdraw_revertsForNonOwner() public {
        vm.prank(donor);
        vault.depositAid{value: 5 ether}(recipient);

        vm.prank(outsider);
        vm.expectRevert(bytes("Not authorized"));
        vault.emergencyWithdraw();
    }

    function test_emergencyWithdraw_revertsWhenNoFunds() public {
        // Owner (this contract) sweeps an empty vault.
        vm.expectRevert(bytes("No funds"));
        vault.emergencyWithdraw();
    }

    function test_emergencyWithdraw_sweepsToOwner() public {
        vm.prank(donor);
        vault.depositAid{value: 5 ether}(recipient);

        uint256 before = address(this).balance;

        // Owner is this test contract.
        vault.emergencyWithdraw();

        assertEq(address(this).balance, before + 5 ether, "owner did not receive funds");
    }

    // Required so the owner (this contract) can receive the emergency sweep.
    receive() external payable {}
}
