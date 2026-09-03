// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Meet the ERC-20 Interface"
// (permaname: erc20-meet-the-interface).
//
// An interface declares a shape and cannot be deployed, so there is no instance
// to poke. Two techniques stand in:
//
//  1. `Implementer` below inherits the student's interface and marks every member
//     `override`. Solidity rejects an `override` that overrides nothing, so a
//     missing declaration fails to compile — the strongest available assertion
//     that a signature is present and spelled exactly right.
//  2. `type(I).interfaceId` is the XOR of every declared function selector, so it
//     fingerprints the whole set. It equals the canonical ERC-20 id only when all
//     six functions are declared and none extra.
//
// Events contribute no selector to interfaceId, so they are checked separately:
// the signature hash proves the name and parameter types, and the topic count
// proves `indexed` was actually applied.

import {Test} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";
import {IWorkshopCredit} from "../src/IWorkshopCredit.sol";

// Canonical ERC-20 interface id: the XOR of the six standard selectors.
bytes4 constant ERC20_INTERFACE_ID = 0x36372b07;

/// Minimal implementation, present only so the compiler checks the shape.
contract Implementer is IWorkshopCredit {
    function totalSupply() external pure override returns (uint256) {
        return 0;
    }

    function balanceOf(address) external pure override returns (uint256) {
        return 0;
    }

    function allowance(address, address) external pure override returns (uint256) {
        return 0;
    }

    function transfer(address to, uint256 amount) external override returns (bool) {
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external override returns (bool) {
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount)
        external
        override
        returns (bool)
    {
        emit Transfer(from, to, amount);
        return true;
    }
}

contract IWorkshopCreditTest is Test {
    Implementer internal impl;

    function setUp() public {
        impl = new Implementer();
    }

    /// Tasks 1-3: all six functions declared, with the standard signatures.
    function test_interfaceId_matchesTheErc20Standard() public pure {
        assertEq(
            type(IWorkshopCredit).interfaceId,
            ERC20_INTERFACE_ID,
            "interface must declare exactly the six ERC-20 functions"
        );
    }

    /// Task 4: the Transfer event, named and typed to the standard.
    function test_transferEvent_hasTheStandardSignature() public pure {
        assertEq(
            IWorkshopCredit.Transfer.selector,
            keccak256("Transfer(address,address,uint256)"),
            "Transfer(address,address,uint256) not declared"
        );
    }

    /// Task 5: the Approval event, named and typed to the standard.
    function test_approvalEvent_hasTheStandardSignature() public pure {
        assertEq(
            IWorkshopCredit.Approval.selector,
            keccak256("Approval(address,address,uint256)"),
            "Approval(address,address,uint256) not declared"
        );
    }

    /// `indexed` is invisible to the signature hash, so count topics instead:
    /// topic0 is the event itself, then one topic per indexed parameter.
    function test_transferEvent_indexesFromAndTo() public {
        vm.recordLogs();
        impl.transfer(address(0xBEEF), 5);
        Vm.Log[] memory entries = vm.getRecordedLogs();

        assertEq(entries.length, 1, "expected exactly one Transfer log");
        assertEq(entries[0].topics.length, 3, "from and to must both be indexed");
        assertEq(entries[0].topics[0], IWorkshopCredit.Transfer.selector, "wrong event fired");
    }

    /// Same check for Approval: owner and spender are the indexed pair.
    function test_approvalEvent_indexesOwnerAndSpender() public {
        vm.recordLogs();
        impl.approve(address(0xCAFE), 7);
        Vm.Log[] memory entries = vm.getRecordedLogs();

        assertEq(entries.length, 1, "expected exactly one Approval log");
        assertEq(entries[0].topics.length, 3, "owner and spender must both be indexed");
        assertEq(entries[0].topics[0], IWorkshopCredit.Approval.selector, "wrong event fired");
    }

    /// The three write functions must return bool, as the standard requires.
    function test_writeFunctions_returnBool() public {
        assertTrue(impl.transfer(address(0x1), 1), "transfer must return bool");
        assertTrue(impl.approve(address(0x2), 2), "approve must return bool");
        assertTrue(
            impl.transferFrom(address(0x3), address(0x4), 3),
            "transferFrom must return bool"
        );
    }
}
