// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Events and the Barangay Fund"
// (permaname: events-and-the-barangay-fund).
//
// Ported from act_1.test.js (Hardhat/Chai). The grader writes the student's
// submission to `src/BarangayFund.sol`, so the import below resolves against
// that assembled layout, not the content-repo filename.
//
// Coverage: `depositFunds(amount)` must require amount > 0 (reverting with the
// exact reason string), accumulate into the public `totalFunds`, and emit
// `FundUpdated(newAmount, updatedBy)` where newAmount is the running total and
// updatedBy is msg.sender. The local `FundUpdated` declaration below must match
// the contract's event signature for vm.expectEmit to compare topics/data.

import {Test} from "forge-std/Test.sol";
import {BarangayFund} from "../src/BarangayFund.sol";

contract BarangayFundTest is Test {
    BarangayFund internal fund;

    address internal user = address(0xCAFE);

    // Must match the event declared in BarangayFund.
    event FundUpdated(uint256 newAmount, address updatedBy);

    function setUp() public {
        fund = new BarangayFund();
    }

    /// Happy path: deposit accumulates totalFunds and emits FundUpdated.
    function test_depositFunds_updatesTotalAndEmits() public {
        vm.expectEmit(true, true, true, true);
        emit FundUpdated(1000, user);

        vm.prank(user);
        fund.depositFunds(1000);

        assertEq(fund.totalFunds(), 1000, "totalFunds not updated");
    }

    /// Edge case: deposits accumulate; emitted newAmount is the running total.
    function test_depositFunds_accumulates() public {
        vm.prank(user);
        fund.depositFunds(400);

        vm.expectEmit(true, true, true, true);
        emit FundUpdated(1000, user);

        vm.prank(user);
        fund.depositFunds(600);

        assertEq(fund.totalFunds(), 1000, "totalFunds should accumulate across deposits");
    }

    /// Edge case: a zero deposit reverts with the exact reason string.
    function test_depositFunds_revertsOnZero() public {
        vm.expectRevert(bytes("Deposit amount must be greater than zero."));
        fund.depositFunds(0);
    }

    /// Edge case: initial state starts at zero.
    function test_initialState_isZero() public view {
        assertEq(fund.totalFunds(), 0, "totalFunds should start at zero");
    }
}
