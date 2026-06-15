// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "File Imports" (permaname: file-imports). The
// student's Calculator imports MathLibrary.sol (a fixed helper provided as an
// extra_source, written next to Calculator.sol under src/).

import {Test} from "forge-std/Test.sol";
import {Calculator} from "../src/Calculator.sol";

contract CalculatorTest is Test {
    Calculator internal calc;

    function setUp() public {
        calc = new Calculator();
    }

    function test_calculateSum_usesLibraryAdd() public view {
        assertEq(calc.calculateSum(7, 5), 12, "sum via MathLibrary.add");
        assertEq(calc.calculateSum(0, 0), 0, "zero sum");
        assertEq(calc.calculateSum(1000, 1), 1001, "larger sum");
    }

    function test_calculateProduct_usesLibraryMultiply() public view {
        assertEq(calc.calculateProduct(6, 4), 24, "product via MathLibrary.multiply");
        assertEq(calc.calculateProduct(9, 0), 0, "times zero");
        assertEq(calc.calculateProduct(12, 12), 144, "square");
    }
}
