// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Palengke Troubles" (permaname: palengke-troubles).
// Ported and expanded from act_1.test.js. The student must declare the public
// state (vendorName, totalSales, transactionStatus, vendorSales mapping) and
// implement recordSale + isTransactionSuccessful.

import {Test} from "forge-std/Test.sol";
import {PalengkeLedger} from "../src/PalengkeLedger.sol";

contract PalengkeLedgerTest is Test {
    PalengkeLedger internal ledger;
    address internal vendorA = address(0xA11CE);
    address internal vendorB = address(0xB0B);

    function setUp() public {
        ledger = new PalengkeLedger();
    }

    function test_initialState_isEmpty() public view {
        assertEq(ledger.totalSales(), 0, "totalSales should start at 0");
        assertEq(ledger.transactionStatus(), false, "transactionStatus should start false");
        assertEq(ledger.isTransactionSuccessful(), false, "no transaction yet");
        assertEq(ledger.vendorSales(vendorA), 0, "vendorSales should start at 0");
    }

    function test_recordSale_setsAllState() public {
        ledger.recordSale(vendorA, "Aling Nena", 100);

        assertEq(ledger.vendorName(), "Aling Nena", "vendorName not stored");
        assertEq(ledger.totalSales(), 100, "totalSales not updated");
        assertEq(ledger.transactionStatus(), true, "transactionStatus not set");
        assertEq(ledger.isTransactionSuccessful(), true, "getter should reflect status");
        assertEq(ledger.vendorSales(vendorA), 100, "per-vendor sales not tracked");
    }

    function test_recordSale_accumulatesTotalsAndPerVendor() public {
        ledger.recordSale(vendorA, "Aling Nena", 100);
        ledger.recordSale(vendorB, "Mang Pedro", 50);
        ledger.recordSale(vendorA, "Aling Nena", 25);

        assertEq(ledger.totalSales(), 175, "totalSales must accumulate across sales");
        assertEq(ledger.vendorSales(vendorA), 125, "vendorA sales must accumulate");
        assertEq(ledger.vendorSales(vendorB), 50, "vendorB sales tracked independently");
    }
}
