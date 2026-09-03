// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Barangay Aid Vault" — the security hardening pass
// (permaname: proj-4-barangay-aid-vault).
//
// The starter carries two exploitable defects, and each gets its own test:
//
//  1. `owner` is never assigned, so it is address(0) and the vault is unowned.
//  2. `emergencyWithdraw` authorises on `tx.origin`, so any contract the owner
//     is tricked into calling can drain the vault. `Middleman` below is that
//     phishing contract, and the test is the attack.
//
// The starter also zeroes `claimable` AFTER the payout rather than before. That
// ordering is left ungraded on purpose: the vault pays with `.transfer`, whose
// 2300-gas stipend cannot fund a re-entrant call, so the violation is not
// reachable here and any probe of it would have to be a contrivance that
// measures nothing a student could exploit. The double-claim test below covers
// what is actually observable.
//
// The vault is deployed from an EOA, not from the test contract, because
// `tx.origin` and `msg.sender` are only distinguishable when the owner is an
// account that calls THROUGH something.

import {Test} from "forge-std/Test.sol";
import {BarangayAidVault} from "../src/BarangayAidVault.sol";

/// The phishing vector: an innocent-looking contract the owner is induced to
/// call. Under a `tx.origin` check its call to emergencyWithdraw is authorised.
contract Middleman {
    function forward(BarangayAidVault vault) external {
        vault.emergencyWithdraw();
    }
}

contract BarangayAidVaultTest is Test {
    BarangayAidVault internal vault;

    address internal owner = address(0x0E4E4);
    address internal donor = address(0xD040E);
    address internal resident = address(0x4E51DE47);

    event AidDeposited(address indexed donor, address indexed recipient, uint256 amount);
    event AidClaimed(address indexed recipient, uint256 amount);

    function setUp() public {
        vm.prank(owner);
        vault = new BarangayAidVault();

        vm.deal(donor, 10 ether);
        vm.deal(owner, 1 ether);
    }

    /// Defect 1: the constructor must actually claim ownership.
    function test_constructor_setsTheOwner() public view {
        assertEq(vault.owner(), owner, "the deployer must be recorded as the owner");
    }

    /// Aid is credited to the named recipient, not to the donor.
    function test_depositAid_creditsTheRecipient() public {
        vm.prank(donor);
        vault.depositAid{value: 1 ether}(resident);

        assertEq(vault.claimable(resident), 1 ether, "the recipient was not credited");
        assertEq(vault.claimable(donor), 0, "the donor must not be credited");
        assertEq(address(vault).balance, 1 ether, "the vault did not hold the ETH");
    }

    /// An empty donation is refused rather than emitting a meaningless receipt.
    function test_depositAid_revertsOnZero() public {
        vm.prank(donor);
        vm.expectRevert(bytes("Cannot send 0 ETH"));
        vault.depositAid{value: 0}(resident);
    }

    /// Donations are auditable.
    function test_depositAid_emitsAidDeposited() public {
        vm.expectEmit(true, true, false, true);
        emit AidDeposited(donor, resident, 1 ether);

        vm.prank(donor);
        vault.depositAid{value: 1 ether}(resident);
    }

    /// Claiming pays the resident and clears the entitlement.
    function test_claimAid_paysAndClears() public {
        vm.prank(donor);
        vault.depositAid{value: 1 ether}(resident);

        uint256 before = resident.balance;
        vm.prank(resident);
        vault.claimAid();

        assertEq(resident.balance, before + 1 ether, "the resident was not paid");
        assertEq(vault.claimable(resident), 0, "the entitlement was not cleared");
    }

    /// Claims are auditable too.
    function test_claimAid_emitsAidClaimed() public {
        vm.prank(donor);
        vault.depositAid{value: 1 ether}(resident);

        vm.expectEmit(true, false, false, true);
        emit AidClaimed(resident, 1 ether);

        vm.prank(resident);
        vault.claimAid();
    }

    /// Nothing to claim is refused.
    function test_claimAid_revertsWithNothingToClaim() public {
        vm.prank(resident);
        vm.expectRevert(bytes("Nothing to claim"));
        vault.claimAid();
    }

    /// One entitlement, one payout: claiming again must find nothing left.
    function test_claimAid_cannotBeClaimedTwice() public {
        vm.prank(donor);
        vault.depositAid{value: 1 ether}(resident);

        vm.startPrank(resident);
        vault.claimAid();

        vm.expectRevert(bytes("Nothing to claim"));
        vault.claimAid();
        vm.stopPrank();

        assertEq(address(vault).balance, 0, "the vault paid out more than it held");
    }

    /// Entitlements are per resident: one claim must not touch another's aid.
    function test_claimAid_paysOnlyTheCaller() public {
        address neighbour = address(0x4E1687);

        vm.startPrank(donor);
        vault.depositAid{value: 1 ether}(resident);
        vault.depositAid{value: 3 ether}(neighbour);
        vm.stopPrank();

        vm.prank(resident);
        vault.claimAid();

        assertEq(vault.claimable(neighbour), 3 ether, "another resident's aid was taken");
        assertEq(address(vault).balance, 3 ether, "the vault paid out the wrong amount");
    }

    /// The emergency exit works for the real owner.
    function test_emergencyWithdraw_paysTheOwner() public {
        vm.prank(donor);
        vault.depositAid{value: 2 ether}(resident);

        uint256 before = owner.balance;
        vm.prank(owner);
        vault.emergencyWithdraw();

        assertEq(owner.balance, before + 2 ether, "the owner was not paid");
        assertEq(address(vault).balance, 0, "the vault was not emptied");
    }

    /// And refuses everyone else.
    function test_emergencyWithdraw_revertsForNonOwners() public {
        vm.prank(donor);
        vault.depositAid{value: 2 ether}(resident);

        vm.prank(donor);
        vm.expectRevert(bytes("Not authorized"));
        vault.emergencyWithdraw();
    }

    /// Defect 2, the phishing attack: the owner calls an innocent-looking
    /// contract, which calls the vault. Under `tx.origin` that is authorised and
    /// the vault is drained; under `msg.sender` it is correctly refused.
    function test_emergencyWithdraw_resistsATxOriginPhish() public {
        vm.prank(donor);
        vault.depositAid{value: 2 ether}(resident);

        Middleman middleman = new Middleman();

        // msg.sender AND tx.origin are both the owner for this call.
        vm.prank(owner, owner);
        vm.expectRevert(bytes("Not authorized"));
        middleman.forward(vault);

        assertEq(address(vault).balance, 2 ether, "a tx.origin phish drained the vault");
        assertEq(vault.claimable(resident), 2 ether, "the resident's aid was taken");
    }
}
