// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Set Up Remix" (permaname: erc20-set-up-remix).
//
// The grader writes the student's submission to `src/HelloToken.sol`
// (spec.json -> source_file).
//
// This lesson is deliberately the smallest possible: prove the toolchain works
// by compiling one contract whose `greet()` returns a fixed string. The starter
// declares the return type but never returns, so it compiles and yields the
// empty string — which is exactly what the first test catches.

import {Test} from "forge-std/Test.sol";
import {HelloToken} from "../src/HelloToken.sol";

contract HelloTokenTest is Test {
    HelloToken internal hello;

    function setUp() public {
        hello = new HelloToken();
    }

    /// Task 2: the greeting, character for character.
    function test_greet_returnsTheExactGreeting() public view {
        assertEq(hello.greet(), "Kumusta, blockchain!", "greet() must return \"Kumusta, blockchain!\"");
    }

    /// A function that returns nothing yields the empty string rather than
    /// reverting, so this states the failure the starter actually produces.
    function test_greet_isNotEmpty() public view {
        assertTrue(bytes(hello.greet()).length > 0, "greet() returned nothing: add the return statement");
    }

    /// `pure` promises the answer never changes; two calls must agree.
    function test_greet_isDeterministic() public view {
        assertEq(hello.greet(), hello.greet(), "greet() must return the same value every call");
    }
}
