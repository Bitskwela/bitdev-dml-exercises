// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Jeepney Fare Disputes" (permaname: jeepney-fare-disputes).
// Ported and expanded from act_1.test.js. Covers fare math, the payable payFare
// flow, payment status, and the private verifyFare (tested indirectly via the
// require revert), matching the original Hardhat test's intent.

import {Test} from "forge-std/Test.sol";
import {JeepneyFareSystem} from "../src/JeepneyFareSystem.sol";

contract JeepneyFareSystemTest is Test {
    JeepneyFareSystem internal jeep;

    function setUp() public {
        jeep = new JeepneyFareSystem();
        vm.deal(address(this), 10 ether); // fund this contract to pay fares
    }

    function test_calculateFare_baseFarePlusDistanceTimesTwo() public view {
        assertEq(jeep.calculateFare(5), 13 + 5 * 2, "fare = baseFare + distance*2");
        assertEq(jeep.calculateFare(0), 13, "zero distance is just the base fare");
    }

    function test_payFare_correctAmount_marksPaidAndHoldsFunds() public {
        uint256 distance = 3;
        uint256 fare = jeep.calculateFare(distance);

        jeep.payFare{value: fare}(distance);

        assertTrue(jeep.hasPaid(address(this)), "payer should be marked paid");
        assertTrue(jeep.checkPaymentStatus(address(this)), "status should report paid");
        assertEq(address(jeep).balance, fare, "contract should hold the fare");
    }

    function test_checkPaymentStatus_falseBeforePayment() public view {
        assertFalse(jeep.checkPaymentStatus(address(this)), "unpaid before payFare");
    }

    function test_payFare_incorrectAmount_reverts() public {
        // distance 4 => required fare 21; sending 20 must revert via the require.
        vm.expectRevert(bytes("Incorrect fare amount."));
        jeep.payFare{value: 20}(4);
    }
}
