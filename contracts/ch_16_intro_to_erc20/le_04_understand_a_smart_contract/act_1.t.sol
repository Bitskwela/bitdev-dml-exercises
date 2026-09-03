// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Understand a Smart Contract"
// (permaname: erc20-understand-a-smart-contract).
//
// The lesson's point is STATE + CODE at one address. The starter ships greet()
// already working and asks for the two state variables, so the tests assert the
// new state, then assert the carried-over code still behaves — a student must
// add without breaking.
//
// The grader writes the submission to src/HelloToken.sol (spec.json -> source_file),
// so the import resolves against the assembled project, not the content repo.

import {Test} from "forge-std/Test.sol";
import {HelloToken} from "../src/HelloToken.sol";

contract HelloTokenTest is Test {
    HelloToken internal token;

    function setUp() public {
        token = new HelloToken();
    }

    /// Task 1: `name` must exist, be public, and hold the lesson's exact string.
    function test_name_isPublicAndSeeded() public view {
        assertEq(token.name(), "Hello Token", "name() must return Hello Token");
    }

    /// Task 2: `totalSupply` must exist, be public, and start at 100.
    function test_totalSupply_isPublicAndSeeded() public view {
        assertEq(token.totalSupply(), 100, "totalSupply() must return 100");
    }

    /// State is what persists: reading twice must not change it.
    function test_state_isStableAcrossReads() public view {
        assertEq(token.name(), token.name(), "name() is not stable");
        assertEq(token.totalSupply(), token.totalSupply(), "totalSupply() is not stable");
    }

    /// Carried over from Lesson 3 — adding state must not break the code half.
    function test_greet_stillReturnsTheLesson3String() public view {
        assertEq(token.greet(), "Kumusta, blockchain!", "greet() regressed");
    }

    /// Two deployments are two addresses, each with its own copy of the state.
    function test_eachDeploymentHasItsOwnState() public {
        HelloToken second = new HelloToken();
        assertTrue(address(second) != address(token), "expected a distinct address");
        assertEq(second.totalSupply(), 100, "a fresh deployment must seed its own state");
    }
}
