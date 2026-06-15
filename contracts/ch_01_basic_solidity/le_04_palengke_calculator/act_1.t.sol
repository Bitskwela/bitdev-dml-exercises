// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {PalengkeCalculator} from "../src/PalengkeCalculator.sol";

contract PalengkeCalculatorTest is Test {
    PalengkeCalculator internal calculator;

    function setUp() public {
        calculator = new PalengkeCalculator();
    }

    function test_calculateTotal_usesMultiplication() public {
        assertEq(calculator.calculateTotal(50, 4), 200, "total cost wrong");
    }

    function test_calculateTotal_zeroQuantity() public {
        assertEq(calculator.calculateTotal(50, 0), 0, "zero quantity should be 0");
    }

    function test_calculateChange_usesSubtraction() public {
        assertEq(calculator.calculateChange(150, 200), 50, "change wrong");
    }

    function test_calculateChange_revertsWhenPaymentTooLow() public {
        vm.expectRevert(bytes("Insufficient payment."));
        calculator.calculateChange(300, 250);
    }

    function test_applyDiscount_usesPercentage() public {
        assertEq(calculator.applyDiscount(500, 20), 400, "discounted total wrong");
    }

    function test_applyDiscount_revertsWhenOver100() public {
        vm.expectRevert(bytes("Invalid discount percentage."));
        calculator.applyDiscount(100, 150);
    }

    function test_splitBill_usesDivision() public {
        assertEq(calculator.splitBill(900, 3), 300, "per person wrong");
    }

    function test_splitBill_revertsWhenGroupSizeZero() public {
        vm.expectRevert(bytes("Group size must be greater than zero."));
        calculator.splitBill(100, 0);
    }
}
