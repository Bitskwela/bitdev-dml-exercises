// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Decentralized Traffic Management"
// (permaname: sq-7-decentralize-traffic-mgmt).
//
// The grader writes the student's submission to `src/TrafficLightManager.sol` and
// drops this file in as `test/Exercise.t.sol`. The contract seeds two intersections
// ("intersection1", "intersection2") to "red" in the constructor, exposes the state
// through a public `lightState` mapping, and lets changeLight() set a light to one of
// "red" / "yellow" / "green" (anything else reverts with "Invalid state").
//
// Coverage: initial seeded state, valid transitions to each allowed colour, setting a
// brand-new intersection, per-intersection independence, and the invalid-state revert
// using the answer's exact string.

import {Test} from "forge-std/Test.sol";
import {TrafficLightManager} from "../src/TrafficLightManager.sol";

contract TrafficLightManagerTest is Test {
    TrafficLightManager internal traffic;

    function setUp() public {
        traffic = new TrafficLightManager();
    }

    function _eq(string memory a, string memory b) internal pure returns (bool) {
        return keccak256(bytes(a)) == keccak256(bytes(b));
    }

    function test_initialState_intersectionsAreRed() public view {
        assertTrue(_eq(traffic.lightState("intersection1"), "red"), "intersection1 should start red");
        assertTrue(_eq(traffic.lightState("intersection2"), "red"), "intersection2 should start red");
    }

    function test_changeLight_toGreen() public {
        traffic.changeLight("intersection1", "green");
        assertTrue(_eq(traffic.lightState("intersection1"), "green"), "should be green");
    }

    function test_changeLight_acceptsAllValidColors() public {
        traffic.changeLight("intersection1", "yellow");
        assertTrue(_eq(traffic.lightState("intersection1"), "yellow"), "should be yellow");

        traffic.changeLight("intersection1", "green");
        assertTrue(_eq(traffic.lightState("intersection1"), "green"), "should be green");

        traffic.changeLight("intersection1", "red");
        assertTrue(_eq(traffic.lightState("intersection1"), "red"), "should be red");
    }

    function test_changeLight_independentPerIntersection() public {
        traffic.changeLight("intersection1", "green");

        assertTrue(_eq(traffic.lightState("intersection1"), "green"), "intersection1 should be green");
        // intersection2 must be unaffected by changes to intersection1.
        assertTrue(_eq(traffic.lightState("intersection2"), "red"), "intersection2 should remain red");
    }

    function test_changeLight_canCreateNewIntersection() public {
        // A previously unseeded intersection starts empty and can be set.
        assertTrue(_eq(traffic.lightState("intersection3"), ""), "new intersection should start empty");

        traffic.changeLight("intersection3", "yellow");
        assertTrue(_eq(traffic.lightState("intersection3"), "yellow"), "new intersection not set");
    }

    function test_changeLight_revertsOnInvalidState() public {
        vm.expectRevert(bytes("Invalid state"));
        traffic.changeLight("intersection1", "blue");
    }
}
