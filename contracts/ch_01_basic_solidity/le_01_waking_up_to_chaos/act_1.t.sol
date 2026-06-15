// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Waking Up to Chaos" (permaname: waking-up-to-chaos).
//
// Ported and expanded from the original act_1.test.js (Hardhat/Chai). The grader
// assembles an ephemeral Foundry project where the student's submission is
// written to `src/PalengkePay.sol` (see spec.json -> source_file), so the import
// below resolves against that assembled layout, NOT the content-repo filename.
//
// Coverage: the lesson asks the student to (1) add a `payerName` state variable
// and (2) assign `_payee` to it inside `recordPayment`. These tests prove both,
// plus that the pre-existing `vendorName`/`totalPayments` behaviour is intact and
// that the latest call wins (overwrite semantics).

import {Test} from "forge-std/Test.sol";
import {PalengkePay} from "../src/PalengkePay.sol";

contract PalengkePayTest is Test {
    PalengkePay internal palengke;

    function setUp() public {
        palengke = new PalengkePay();
    }

    /// Happy path mirroring the original JS test's first case.
    function test_recordPayment_storesAllThreeFields() public {
        palengke.recordPayment("Tindera Maria", 500, "Juan Dela Cruz");

        assertEq(palengke.vendorName(), "Tindera Maria", "vendorName not stored");
        assertEq(palengke.totalPayments(), 500, "totalPayments not stored");
        assertEq(palengke.payerName(), "Juan Dela Cruz", "payerName not stored");
    }

    /// The core of this lesson: `payerName` must be added AND assigned `_payee`.
    function test_recordPayment_assignsPayerName() public {
        palengke.recordPayment("Mabangus", 777, "Neri");

        assertEq(palengke.payerName(), "Neri", "payerName must equal the _payee argument");
    }

    /// Existing behaviour must be preserved while adding the new field.
    function test_recordPayment_preservesVendorAndTotal() public {
        palengke.recordPayment("Aling Nena", 1200, "Mang Pedro");

        assertEq(palengke.vendorName(), "Aling Nena", "vendorName regressed");
        assertEq(palengke.totalPayments(), 1200, "totalPayments regressed");
    }

    /// Edge case beyond the original JS test: a second call overwrites the first.
    function test_recordPayment_latestCallOverwrites() public {
        palengke.recordPayment("First Vendor", 10, "First Payer");
        palengke.recordPayment("Second Vendor", 99, "Second Payer");

        assertEq(palengke.vendorName(), "Second Vendor", "overwrite failed for vendorName");
        assertEq(palengke.totalPayments(), 99, "overwrite failed for totalPayments");
        assertEq(palengke.payerName(), "Second Payer", "overwrite failed for payerName");
    }

    /// Edge case: initial state is empty/zero before any payment is recorded.
    function test_initialState_isEmpty() public view {
        assertEq(palengke.vendorName(), "", "vendorName should start empty");
        assertEq(palengke.totalPayments(), 0, "totalPayments should start at zero");
        assertEq(palengke.payerName(), "", "payerName should start empty");
    }
}
