// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Dynamic Pricing"
// (permaname: sq-5-dynamic-pricing).
//
// The starter returns `basePrice` unchanged, which is the CORRECT answer whenever
// both factors are zero — so the zero case cannot gate anything and is asserted
// only as a boundary, never as proof.
//
// The order of operations is the substance of this lesson: the time factor is
// applied to the demand-adjusted price, not to the base. 100 with +20% demand and
// +10% time is 132, not 130, and the compounding test below is what separates a
// correct answer from an additive approximation that happens to be close.

import {Test} from "forge-std/Test.sol";
import {DynamicPricing} from "../src/DynamicPricing.sol";

contract DynamicPricingTest is Test {
    DynamicPricing internal pricing;

    function setUp() public {
        pricing = new DynamicPricing();
    }

    /// The lesson's worked example: 100 -> +20% -> 120 -> +10% -> 132.
    function test_calculatePrice_appliesBothFactors() public view {
        assertEq(pricing.calculatePrice(100, 20, 10), 132, "expected 100 -> 120 -> 132");
    }

    /// Names the starter's failure mode: a surge price must exceed the base.
    function test_calculatePrice_doesNotReturnTheBaseUnchanged() public view {
        assertTrue(
            pricing.calculatePrice(100, 20, 10) > 100,
            "the price must rise when demand and time add a surcharge"
        );
    }

    /// The factors compound; they do not merely add. 20 + 10 would give 130.
    function test_calculatePrice_compoundsRatherThanAdds() public view {
        assertTrue(
            pricing.calculatePrice(100, 20, 10) != 130,
            "the time factor applies to the demand-adjusted price, not to the base"
        );
    }

    /// Each factor alone, so a student who wires only one is caught.
    function test_calculatePrice_appliesDemandAlone() public view {
        assertEq(pricing.calculatePrice(200, 50, 0), 300, "demand factor alone is wrong");
    }

    function test_calculatePrice_appliesTimeAlone() public view {
        assertEq(pricing.calculatePrice(200, 0, 25), 250, "time factor alone is wrong");
    }

    /// Boundary: no surge means no change. True of the starter too, so this is
    /// a guard against over-correction, not a gate.
    function test_calculatePrice_returnsBaseWhenThereIsNoSurge() public view {
        assertEq(pricing.calculatePrice(150, 0, 0), 150, "a flat fare must not change");
    }

    /// Integer division truncates, and the expected value must account for it.
    function test_calculatePrice_truncatesIntegerDivision() public view {
        // 99 * 5 / 100 = 4 (not 4.95); 103 * 5 / 100 = 5 (not 5.15).
        assertEq(pricing.calculatePrice(99, 5, 5), 108, "integer truncation not handled");
    }

    /// A free ride stays free however hot the demand.
    function test_calculatePrice_handlesAZeroBase() public view {
        assertEq(pricing.calculatePrice(0, 80, 40), 0, "a zero base must stay zero");
    }

    /// The function must stay pure: repeated calls give identical answers.
    function test_calculatePrice_isDeterministic() public view {
        assertEq(
            pricing.calculatePrice(500, 15, 30),
            pricing.calculatePrice(500, 15, 30),
            "pricing must be deterministic"
        );
    }
}
