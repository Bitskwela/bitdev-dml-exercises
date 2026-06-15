// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Array and the Rising Chaos"
// (permaname: arrays-and-the-rising-chaos).
//
// Ported from act_1.test.js (Hardhat/Chai). The grader writes the student's
// submission to `src/PalengkeTransactions.sol`, so the import below resolves
// against that assembled layout, not the content-repo filename.
//
// Coverage: `recordPayment(uint256)` must push to the `payments` array,
// `getTotalPayments()` returns the array length, and `getPayment(index)`
// returns the element while reverting with "Invalid index." when out of bounds.

import {Test} from "forge-std/Test.sol";
import {PalengkeTransactions} from "../src/PalengkeTransactions.sol";

contract PalengkeTransactionsTest is Test {
    PalengkeTransactions internal palengke;

    function setUp() public {
        palengke = new PalengkeTransactions();
    }

    /// Happy path: a recorded payment is stored and retrievable at index 0.
    function test_recordPayment_storesValue() public {
        palengke.recordPayment(100);
        assertEq(palengke.getPayment(0), 100, "payment at index 0 mismatch");
    }

    /// getTotalPayments returns the number of recorded payments.
    function test_getTotalPayments_countsEntries() public {
        palengke.recordPayment(200);
        palengke.recordPayment(300);
        assertEq(palengke.getTotalPayments(), 2, "total payments count mismatch");
    }

    /// getPayment returns the correct element by index.
    function test_getPayment_byIndex() public {
        palengke.recordPayment(500);
        palengke.recordPayment(1000);
        assertEq(palengke.getPayment(1), 1000, "payment at index 1 mismatch");
    }

    /// The public array getter must expose stored payments too.
    function test_payments_publicGetter() public {
        palengke.recordPayment(42);
        assertEq(palengke.payments(0), 42, "public array getter mismatch");
    }

    /// Edge case: requesting an out-of-bounds index reverts with the exact reason.
    function test_getPayment_revertsOutOfBounds() public {
        vm.expectRevert(bytes("Invalid index."));
        palengke.getPayment(0);
    }

    /// Edge case: initial state has zero payments.
    function test_initialState_isEmpty() public view {
        assertEq(palengke.getTotalPayments(), 0, "should start with zero payments");
    }
}
