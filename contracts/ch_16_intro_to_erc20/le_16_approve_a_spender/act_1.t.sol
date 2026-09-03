// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Approve a Spender"
// (permaname: erc20-approve-a-spender).
//
// The starter returns a bare `false` placeholder, so it compiles and grants
// nothing. The distinction the lesson is teaching — approval moves PERMISSION,
// not credits — is asserted directly: the allowance changes and the balances
// do not.
//
// `approveStore` calls the inherited `approve` internally, so the approver is
// whoever called it. The prank test pins that down.

import {Test} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";
import {WorkshopCredit} from "../src/WorkshopCredit.sol";

contract WorkshopCreditTest is Test {
    WorkshopCredit internal credit;

    uint256 internal constant SUPPLY = 1000 * 10 ** 18;
    uint256 internal constant LIMIT = 200 * 10 ** 18;

    bytes32 internal constant APPROVAL_SIG = keccak256("Approval(address,address,uint256)");

    address internal store = address(0x570E);
    address internal alice = address(0xA11CE);

    function setUp() public {
        credit = new WorkshopCredit();
    }

    /// The task: the allowance is actually recorded.
    function test_approveStore_recordsTheAllowance() public {
        credit.approveStore(store, LIMIT);

        assertEq(credit.allowance(address(this), store), LIMIT, "allowance was not granted");
    }

    /// The inherited approve returns true — the starter's `false` is the tell.
    function test_approveStore_returnsTrue() public {
        assertTrue(credit.approveStore(store, LIMIT), "approveStore must return approve()'s result");
    }

    /// Approval is permission, not payment: no credits may move.
    function test_approveStore_movesNoCredits() public {
        credit.approveStore(store, LIMIT);

        assertEq(credit.balanceOf(address(this)), SUPPLY, "the approver's balance changed");
        assertEq(credit.balanceOf(store), 0, "the spender received credits");
        assertEq(credit.totalSupply(), SUPPLY, "supply changed on an approval");
    }

    /// The approval is granted BY the caller, not by the contract.
    function test_approveStore_approvesOnBehalfOfTheCaller() public {
        vm.prank(alice);
        credit.approveStore(store, LIMIT);

        assertEq(credit.allowance(alice, store), LIMIT, "alice's allowance was not set");
        assertEq(credit.allowance(address(credit), store), 0, "the contract must not be the approver");
    }

    /// ERC-20 approval overwrites; it does not accumulate.
    function test_approveStore_overwritesAnEarlierAllowance() public {
        credit.approveStore(store, LIMIT);
        credit.approveStore(store, 5 * 10 ** 18);

        assertEq(credit.allowance(address(this), store), 5 * 10 ** 18, "approval must overwrite");
    }

    /// Approving zero is how a permission is revoked.
    function test_approveStore_canRevokeWithZero() public {
        credit.approveStore(store, LIMIT);
        credit.approveStore(store, 0);

        assertEq(credit.allowance(address(this), store), 0, "approving 0 must revoke");
    }

    /// The public receipt for a permission is the Approval event.
    function test_approveStore_emitsApproval() public {
        vm.recordLogs();
        credit.approveStore(store, LIMIT);
        Vm.Log[] memory logs = vm.getRecordedLogs();

        assertEq(logs.length, 1, "expected exactly one Approval event");
        assertEq(logs[0].topics[0], APPROVAL_SIG, "wrong event emitted");
        assertEq(address(uint160(uint256(logs[0].topics[1]))), address(this), "wrong owner");
        assertEq(address(uint160(uint256(logs[0].topics[2]))), store, "wrong spender");
        assertEq(abi.decode(logs[0].data, (uint256)), LIMIT, "wrong amount");
    }
}
