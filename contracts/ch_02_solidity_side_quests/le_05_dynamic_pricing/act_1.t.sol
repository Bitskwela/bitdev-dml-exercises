// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Dynamic Pricing Contract" (permaname: sq-5-dynamic-pricing).
//
// The grader writes the student's submission to `src/DynamicPricing.sol` and drops
// this file in as `test/Exercise.t.sol`. calculatePrice is a pure function:
//
//   demandAdjustment = basePrice * demandFactor / 100
//   tempPrice        = basePrice + demandAdjustment
//   timeAdjustment   = tempPrice * timeFactor / 100
//   finalPrice       = tempPrice + timeAdjustment
//
// Coverage: zero factors (price unchanged), demand-only, time-only, combined
// demand+time, a large/compounding value, and an integer-truncation edge case where
// the division floors. All expected values are computed by hand from the formula
// above.

import {Test} from "forge-std/Test.sol";
import {DynamicPricing} from "../src/DynamicPricing.sol";

contract DynamicPricingTest is Test {
    DynamicPricing internal pricing;

    function setUp() public {
        pricing = new DynamicPricing();
    }

    function test_zeroFactors_returnsBasePrice() public view {
        // demandAdj=0, temp=1000, timeAdj=0, final=1000
        assertEq(pricing.calculatePrice(1000, 0, 0), 1000, "zero factors should not change price");
    }

    function test_demandOnly() public view {
        // demandAdj = 1000*20/100 = 200; temp=1200; timeAdj=0; final=1200
        assertEq(pricing.calculatePrice(1000, 20, 0), 1200, "demand-only adjustment wrong");
    }

    function test_timeOnly() public view {
        // demandAdj=0; temp=1000; timeAdj = 1000*10/100 = 100; final=1100
        assertEq(pricing.calculatePrice(1000, 0, 10), 1100, "time-only adjustment wrong");
    }

    function test_combinedDemandAndTime() public view {
        // demandAdj = 1000*20/100 = 200; temp=1200;
        // timeAdj   = 1200*10/100 = 120; final=1320
        assertEq(pricing.calculatePrice(1000, 20, 10), 1320, "combined adjustment wrong");
    }

    function test_largeCompoundingFactors() public view {
        // demandAdj = 1000*50/100 = 500; temp=1500;
        // timeAdj   = 1500*50/100 = 750; final=2250
        assertEq(pricing.calculatePrice(1000, 50, 50), 2250, "compounding adjustment wrong");
    }

    function test_integerTruncation_edgeCase() public view {
        // basePrice=999, demand=10 -> demandAdj = 999*10/100 = 9990/100 = 99 (floored)
        // temp = 999 + 99 = 1098; time=0 -> final = 1098
        assertEq(pricing.calculatePrice(999, 10, 0), 1098, "integer truncation handled incorrectly");
    }

    function test_zeroBasePrice_returnsZero() public view {
        // Every term is a multiple of basePrice (0), so the final price is 0.
        assertEq(pricing.calculatePrice(0, 50, 50), 0, "zero base price should yield zero");
    }
}
