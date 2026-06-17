// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Calldata: The Art of Efficient Communication"
// (permaname: calldata-the-art-of-efficient-comms).
//
// The grader assembles an ephemeral Foundry project where the student's
// submission is written to `src/EfficientDataTransfer.sol` (see spec.json ->
// source_file), so the import below resolves against that assembled layout,
// NOT the content-repo filename.
//
// Coverage: the lesson asks the student to (1) implement `echoData`, taking a
// `calldata` string and returning it unchanged, and (2) implement `memoryData`,
// taking a `memory` string and returning it unchanged. These tests prove both
// round-trip the input across empty, short, and long values, and that the two
// entrypoints agree on the same input.

import {Test} from "forge-std/Test.sol";
import {EfficientDataTransfer} from "../src/EfficientDataTransfer.sol";

contract EfficientDataTransferTest is Test {
    EfficientDataTransfer internal dataTransfer;

    function setUp() public {
        dataTransfer = new EfficientDataTransfer();
    }

    /// The core of this lesson: `echoData` takes a calldata string and returns it unchanged.
    function test_echoData_returnsInput() public view {
        assertEq(dataTransfer.echoData("Neri"), "Neri", "echoData must return its input unchanged");
    }

    /// The memory variant must also return its argument unchanged.
    function test_memoryData_returnsInput() public view {
        assertEq(dataTransfer.memoryData("Hackana"), "Hackana", "memoryData must return its input unchanged");
    }

    /// Edge case: both variants must handle the empty string.
    function test_emptyString() public view {
        assertEq(dataTransfer.echoData(""), "", "echoData should handle the empty string");
        assertEq(dataTransfer.memoryData(""), "", "memoryData should handle the empty string");
    }

    /// Edge case: a longer, multi-word payload must round-trip unchanged through both.
    function test_longString() public view {
        string memory long = "Palengke vendors switch to BitsKwela in San Juan City";
        assertEq(dataTransfer.echoData(long), long, "echoData must preserve a long input");
        assertEq(dataTransfer.memoryData(long), long, "memoryData must preserve a long input");
    }

    /// The calldata and memory entrypoints must agree on the same input.
    function test_bothVariantsAgree() public view {
        assertEq(
            dataTransfer.echoData("same value"),
            dataTransfer.memoryData("same value"),
            "calldata and memory variants must return identical results"
        );
    }
}
