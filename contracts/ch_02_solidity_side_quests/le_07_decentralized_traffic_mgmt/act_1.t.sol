// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Decentralized Traffic Management"
// (permaname: sq-7-decentralize-traffic-mgmt).
//
// Two things are graded: the constructor that starts both intersections on red,
// and a `changeLight` that accepts exactly "red", "yellow" and "green". The
// starter has neither, so it fails on the very first assertion.
//
// Solidity cannot compare strings with `==`, so the validation has to hash them.
// The rejection tests below include case variants ("Green", "GREEN") precisely
// because a hash comparison is exact — a student who reaches for some looser
// check would let those through.

import {Test} from "forge-std/Test.sol";
import {TrafficLightManager} from "../src/TrafficLightManager.sol";

contract TrafficLightManagerTest is Test {
    TrafficLightManager internal traffic;

    function setUp() public {
        traffic = new TrafficLightManager();
    }

    /// The constructor must seed both intersections on red.
    function test_constructor_startsBothIntersectionsOnRed() public view {
        assertEq(traffic.lightState("intersection1"), "red", "intersection1 must start red");
        assertEq(traffic.lightState("intersection2"), "red", "intersection2 must start red");
    }

    /// The task: a valid state is written through.
    function test_changeLight_acceptsGreen() public {
        traffic.changeLight("intersection1", "green");

        assertEq(traffic.lightState("intersection1"), "green", "the light did not change");
    }

    /// All three valid states, so no one is accepted by accident.
    function test_changeLight_acceptsEveryValidState() public {
        traffic.changeLight("intersection1", "yellow");
        assertEq(traffic.lightState("intersection1"), "yellow", "yellow was not accepted");

        traffic.changeLight("intersection1", "red");
        assertEq(traffic.lightState("intersection1"), "red", "red was not accepted");

        traffic.changeLight("intersection1", "green");
        assertEq(traffic.lightState("intersection1"), "green", "green was not accepted");
    }

    /// The validation: anything else is rejected.
    function test_changeLight_rejectsAnInvalidState() public {
        vm.expectRevert(bytes("Invalid state"));
        traffic.changeLight("intersection1", "blue");

        assertEq(traffic.lightState("intersection1"), "red", "a rejected change was applied");
    }

    /// An empty string is not a colour either.
    function test_changeLight_rejectsAnEmptyState() public {
        vm.expectRevert(bytes("Invalid state"));
        traffic.changeLight("intersection1", "");
    }

    /// Hashing is exact, so casing must not slip through.
    function test_changeLight_rejectsWrongCasing() public {
        vm.expectRevert(bytes("Invalid state"));
        traffic.changeLight("intersection1", "GREEN");

        vm.expectRevert(bytes("Invalid state"));
        traffic.changeLight("intersection1", "Green");
    }

    /// Each intersection keeps its own light.
    function test_intersectionsAreIndependent() public {
        traffic.changeLight("intersection1", "green");

        assertEq(traffic.lightState("intersection1"), "green", "intersection1 did not change");
        assertEq(traffic.lightState("intersection2"), "red", "intersection2 changed by accident");
    }

    /// The mapping accepts new intersections, not only the two seeded ones.
    function test_changeLight_worksForANewIntersection() public {
        traffic.changeLight("edsa-crossing", "yellow");

        assertEq(traffic.lightState("edsa-crossing"), "yellow", "a new intersection was not stored");
    }

    /// Lights cycle: the latest valid change wins.
    function test_changeLight_overwritesTheEarlierState() public {
        traffic.changeLight("intersection2", "green");
        traffic.changeLight("intersection2", "yellow");

        assertEq(traffic.lightState("intersection2"), "yellow", "the latest change must win");
    }
}
