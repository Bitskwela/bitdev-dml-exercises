// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Multi-Signature Wallet" (permaname: sq-4-multi-sig-wallet).
//
// The grader writes the student's submission to `src/MultiSigWallet.sol` and drops
// this file in as `test/Exercise.t.sol`. The wallet is deployed with 3 signers and a
// threshold of 2, funded via vm.deal, and exercised end-to-end: propose -> approve x2
// -> execute moves ETH to a recipient.
//
// Coverage: signer registration, the full propose/approve/execute happy path, and the
// guard rails — non-signer propose ("Not authorized"), non-signer approve
// ("Not authorized"), double-approve ("Already approved"), execute below threshold
// ("Not enough approvals"), and double-execute ("Already executed"). Revert strings
// are copied verbatim from the answer.

import {Test} from "forge-std/Test.sol";
import {MultiSigWallet} from "../src/MultiSigWallet.sol";

contract MultiSigWalletTest is Test {
    MultiSigWallet internal wallet;

    address internal signer1 = makeAddr("signer1");
    address internal signer2 = makeAddr("signer2");
    address internal signer3 = makeAddr("signer3");
    address internal outsider = makeAddr("outsider");
    address payable internal recipient = payable(makeAddr("recipient"));

    function setUp() public {
        address[] memory signers = new address[](3);
        signers[0] = signer1;
        signers[1] = signer2;
        signers[2] = signer3;

        wallet = new MultiSigWallet(signers, 2);
        vm.deal(address(wallet), 10 ether);
    }

    function test_constructor_registersSignersAndThreshold() public view {
        assertTrue(wallet.isSigner(signer1), "signer1 not registered");
        assertTrue(wallet.isSigner(signer2), "signer2 not registered");
        assertTrue(wallet.isSigner(signer3), "signer3 not registered");
        assertFalse(wallet.isSigner(outsider), "outsider should not be a signer");
        assertEq(wallet.approvalThreshold(), 2, "threshold mismatch");
    }

    function test_happyPath_proposeApproveExecuteMovesEther() public {
        vm.prank(signer1);
        wallet.proposeTransaction(recipient, 3 ether);

        vm.prank(signer1);
        wallet.approveTransaction(0);
        vm.prank(signer2);
        wallet.approveTransaction(0);

        uint256 recipientBefore = recipient.balance;

        // Any address can execute once the threshold is met.
        wallet.executeTransaction(0);

        assertEq(recipient.balance, recipientBefore + 3 ether, "recipient did not receive ETH");
        assertEq(address(wallet).balance, 7 ether, "wallet balance not reduced");

        // Inspect the public transactions array tuple: (to, value, approvals, executed).
        (address to, uint256 value, uint256 approvals, bool executed) = wallet.transactions(0);
        assertEq(to, recipient, "stored recipient wrong");
        assertEq(value, 3 ether, "stored value wrong");
        assertEq(approvals, 2, "approval count wrong");
        assertTrue(executed, "transaction should be marked executed");
    }

    function test_propose_revertsForNonSigner() public {
        vm.prank(outsider);
        vm.expectRevert(bytes("Not authorized"));
        wallet.proposeTransaction(recipient, 1 ether);
    }

    function test_approve_revertsForNonSigner() public {
        vm.prank(signer1);
        wallet.proposeTransaction(recipient, 1 ether);

        vm.prank(outsider);
        vm.expectRevert(bytes("Not authorized"));
        wallet.approveTransaction(0);
    }

    function test_approve_revertsOnDoubleApproval() public {
        vm.prank(signer1);
        wallet.proposeTransaction(recipient, 1 ether);

        vm.prank(signer1);
        wallet.approveTransaction(0);

        vm.prank(signer1);
        vm.expectRevert(bytes("Already approved"));
        wallet.approveTransaction(0);
    }

    function test_execute_revertsBelowThreshold() public {
        vm.prank(signer1);
        wallet.proposeTransaction(recipient, 1 ether);

        // Only one approval; threshold is 2.
        vm.prank(signer1);
        wallet.approveTransaction(0);

        vm.expectRevert(bytes("Not enough approvals"));
        wallet.executeTransaction(0);
    }

    function test_execute_revertsOnDoubleExecution() public {
        vm.prank(signer1);
        wallet.proposeTransaction(recipient, 1 ether);
        vm.prank(signer1);
        wallet.approveTransaction(0);
        vm.prank(signer2);
        wallet.approveTransaction(0);

        wallet.executeTransaction(0);

        vm.expectRevert(bytes("Already executed"));
        wallet.executeTransaction(0);
    }
}
