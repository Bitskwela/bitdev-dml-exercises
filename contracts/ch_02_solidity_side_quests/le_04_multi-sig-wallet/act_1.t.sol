// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Multi-Sig Wallet"
// (permaname: sq-4-multi-sig-wallet).
//
// Three functions, three separate rules: only signers may propose, only signers
// may approve and only once each, and execution waits for the threshold. The
// starter leaves all three empty, so nothing is ever pushed and the transactions
// array stays empty — which is itself the first assertion.
//
// The wallet is funded in setUp because `executeTransaction` sends ETH, and an
// execution that reverts for lack of funds would be indistinguishable from one
// that reverts for lack of approvals.

import {Test} from "forge-std/Test.sol";
import {MultiSigWallet} from "../src/MultiSigWallet.sol";

contract MultiSigWalletTest is Test {
    MultiSigWallet internal wallet;

    address internal alice = address(0xA11CE);
    address internal bob = address(0xB0B);
    address internal carol = address(0xCA401);
    address internal outsider = address(0x5748);
    address internal payee = address(0xBEEF);

    function setUp() public {
        address[] memory signers = new address[](3);
        signers[0] = alice;
        signers[1] = bob;
        signers[2] = carol;

        wallet = new MultiSigWallet(signers, 2);
        vm.deal(address(wallet), 10 ether);
    }

    /// Constructor behaviour, carried over unchanged.
    function test_constructor_registersSignersAndThreshold() public view {
        assertTrue(wallet.isSigner(alice), "alice should be a signer");
        assertTrue(wallet.isSigner(bob), "bob should be a signer");
        assertFalse(wallet.isSigner(outsider), "an outsider must not be a signer");
        assertEq(wallet.approvalThreshold(), 2, "threshold not stored");
    }

    /// Task 1: a signer's proposal is stored.
    function test_proposeTransaction_storesTheTransaction() public {
        vm.prank(alice);
        wallet.proposeTransaction(payee, 1 ether);

        (address to, uint256 value, uint256 approvals, bool executed) = wallet.transactions(0);
        assertEq(to, payee, "recipient not stored");
        assertEq(value, 1 ether, "value not stored");
        assertEq(approvals, 0, "a new proposal starts with no approvals");
        assertFalse(executed, "a new proposal must not be executed");
    }

    /// Task 1's guard: outsiders cannot propose.
    function test_proposeTransaction_revertsForNonSigners() public {
        vm.prank(outsider);
        vm.expectRevert(bytes("Not authorized"));
        wallet.proposeTransaction(payee, 1 ether);
    }

    /// Task 2: approvals are counted.
    function test_approveTransaction_countsApprovals() public {
        vm.prank(alice);
        wallet.proposeTransaction(payee, 1 ether);

        vm.prank(alice);
        wallet.approveTransaction(0);

        (,, uint256 approvals,) = wallet.transactions(0);
        assertEq(approvals, 1, "approval was not counted");
        assertTrue(wallet.approved(0, alice), "the approver was not recorded");
    }

    /// One signer, one vote — double approval must not reach the threshold alone.
    function test_approveTransaction_rejectsDoubleApproval() public {
        vm.startPrank(alice);
        wallet.proposeTransaction(payee, 1 ether);
        wallet.approveTransaction(0);

        vm.expectRevert(bytes("Already approved"));
        wallet.approveTransaction(0);
        vm.stopPrank();

        (,, uint256 approvals,) = wallet.transactions(0);
        assertEq(approvals, 1, "double approval must not raise the count");
    }

    /// Task 2's guard: outsiders cannot approve.
    function test_approveTransaction_revertsForNonSigners() public {
        vm.prank(alice);
        wallet.proposeTransaction(payee, 1 ether);

        vm.prank(outsider);
        vm.expectRevert(bytes("Not authorized"));
        wallet.approveTransaction(0);
    }

    /// Task 3: the threshold gates execution.
    function test_executeTransaction_revertsBelowTheThreshold() public {
        vm.startPrank(alice);
        wallet.proposeTransaction(payee, 1 ether);
        wallet.approveTransaction(0);
        vm.stopPrank();

        vm.expectRevert(bytes("Not enough approvals"));
        wallet.executeTransaction(0);

        assertEq(payee.balance, 0, "a blocked transaction must not pay out");
    }

    /// Task 3: with the threshold met, the ETH moves.
    function test_executeTransaction_paysOutOnceApproved() public {
        vm.prank(alice);
        wallet.proposeTransaction(payee, 1 ether);

        vm.prank(alice);
        wallet.approveTransaction(0);
        vm.prank(bob);
        wallet.approveTransaction(0);

        wallet.executeTransaction(0);

        assertEq(payee.balance, 1 ether, "the recipient was not paid");
        assertEq(address(wallet).balance, 9 ether, "the wallet was not debited");

        (,,, bool executed) = wallet.transactions(0);
        assertTrue(executed, "the transaction must be marked executed");
    }

    /// A transaction may only be executed once.
    function test_executeTransaction_cannotReplay() public {
        vm.prank(alice);
        wallet.proposeTransaction(payee, 1 ether);
        vm.prank(alice);
        wallet.approveTransaction(0);
        vm.prank(bob);
        wallet.approveTransaction(0);

        wallet.executeTransaction(0);

        vm.expectRevert(bytes("Already executed"));
        wallet.executeTransaction(0);

        assertEq(payee.balance, 1 ether, "a replayed execution paid twice");
    }

    /// Proposals are independent: approving one must not advance another.
    function test_approvalsAreTrackedPerTransaction() public {
        vm.startPrank(alice);
        wallet.proposeTransaction(payee, 1 ether);
        wallet.proposeTransaction(payee, 2 ether);
        wallet.approveTransaction(0);
        vm.stopPrank();

        (,, uint256 secondApprovals,) = wallet.transactions(1);
        assertEq(secondApprovals, 0, "approvals leaked between transactions");
    }
}
