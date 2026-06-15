// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Constructors" (permaname: constructors-and-neris-next-challenge).
//
// Ported from act_1.test.js (Hardhat/Chai). The grader writes the student's
// submission to `src/BarangayProgram.sol`, so the import below resolves against
// that assembled layout, not the content-repo filename.
//
// Coverage: the constructor must accept (string programName, uint256
// startingBalance) and store them into the public state variables; the starter
// has the state vars but no constructor, so `new BarangayProgram(...)` with args
// will not compile/run there. `getProgramDetails()` must return both fields.

import {Test} from "forge-std/Test.sol";
import {BarangayProgram} from "../src/BarangayProgram.sol";

contract BarangayProgramTest is Test {
    BarangayProgram internal program;

    function setUp() public {
        program = new BarangayProgram("Clean & Green", 1000);
    }

    /// Happy path: constructor args are stored in the public state variables.
    function test_constructor_setsState() public view {
        assertEq(program.programName(), "Clean & Green", "programName not set by constructor");
        assertEq(program.startingBalance(), 1000, "startingBalance not set by constructor");
    }

    /// getProgramDetails returns the stored program name and balance.
    function test_getProgramDetails_returnsBoth() public view {
        (string memory name, uint256 balance) = program.getProgramDetails();
        assertEq(name, "Clean & Green", "getProgramDetails name mismatch");
        assertEq(balance, 1000, "getProgramDetails balance mismatch");
    }

    /// Edge case: a freshly constructed instance with different args stores them.
    function test_constructor_withDifferentArgs() public {
        BarangayProgram other = new BarangayProgram("Ayuda Distribution", 50000);
        assertEq(other.programName(), "Ayuda Distribution", "second instance name mismatch");
        assertEq(other.startingBalance(), 50000, "second instance balance mismatch");

        (string memory name, uint256 balance) = other.getProgramDetails();
        assertEq(name, "Ayuda Distribution", "second instance getter name mismatch");
        assertEq(balance, 50000, "second instance getter balance mismatch");
    }

    /// Edge case: zero balance is a valid stored value.
    function test_constructor_acceptsZeroBalance() public {
        BarangayProgram zero = new BarangayProgram("Empty Fund", 0);
        assertEq(zero.startingBalance(), 0, "zero balance should be stored as-is");
    }
}
