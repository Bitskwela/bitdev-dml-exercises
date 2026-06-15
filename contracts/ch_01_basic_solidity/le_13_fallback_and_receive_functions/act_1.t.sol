// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Fallback and Receive Functions"
// (permaname: fallback-and-receive-functions).
//
// Ported from act_1.test.js (Hardhat/Chai). The grader writes the student's
// submission to `src/BarangayWallet.sol`, so the import below resolves against
// that assembled layout, not the content-repo filename.
//
// Coverage:
//   - receive(): plain ETH transfer (empty calldata) must add msg.value to the
//     public `totalReceived`, and accumulate across multiple sends.
//   - fallback(): an ETH send WITH non-empty calldata (no matching function)
//     must hit fallback and emit InvalidCall(sender, value, data). The starter
//     has neither function, so a value transfer to it would revert -> fail.
//
// The local InvalidCall declaration below must match the contract's event so
// vm.expectEmit can compare the emitted topics/data.

import {Test} from "forge-std/Test.sol";
import {BarangayWallet} from "../src/BarangayWallet.sol";

contract BarangayWalletTest is Test {
    BarangayWallet internal wallet;

    // Must match the event declared in BarangayWallet.
    event InvalidCall(address sender, uint256 value, bytes data);

    function setUp() public {
        wallet = new BarangayWallet();
        vm.deal(address(this), 100 ether);
    }

    /// Happy path: a plain ETH transfer (empty calldata) hits receive().
    function test_receive_acceptsEtherAndTracksTotal() public {
        (bool ok,) = address(wallet).call{value: 1 ether}("");
        assertTrue(ok, "plain ETH transfer should succeed via receive()");

        assertEq(wallet.totalReceived(), 1 ether, "totalReceived not updated by receive()");
    }

    /// Edge case: receive() accumulates across multiple deposits.
    function test_receive_accumulatesAcrossDeposits() public {
        (bool ok1,) = address(wallet).call{value: 0.3 ether}("");
        assertTrue(ok1, "first deposit failed");
        (bool ok2,) = address(wallet).call{value: 0.7 ether}("");
        assertTrue(ok2, "second deposit failed");

        assertEq(wallet.totalReceived(), 1 ether, "totalReceived should accumulate");
    }

    /// fallback(): an ETH send with non-empty calldata emits InvalidCall and does
    /// NOT increment totalReceived (only receive does).
    function test_fallback_emitsInvalidCall() public {
        bytes memory data = hex"deadbeef";

        vm.expectEmit(true, true, true, true);
        emit InvalidCall(address(this), 0.1 ether, data);

        (bool ok,) = address(wallet).call{value: 0.1 ether}(data);
        assertTrue(ok, "call with data should succeed via fallback()");

        assertEq(wallet.totalReceived(), 0, "fallback must not change totalReceived");
    }

    /// Edge case: initial state starts at zero.
    function test_initialState_isZero() public view {
        assertEq(wallet.totalReceived(), 0, "totalReceived should start at zero");
    }
}
