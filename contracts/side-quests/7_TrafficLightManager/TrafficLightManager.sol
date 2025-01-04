// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TrafficLightManager {
    mapping(string => string) public lightState;

    constructor() {
        // 🚩 Initialize all intersections to "red"
        lightState["intersection1"] = "red";
        lightState["intersection2"] = "red";
    }

    // 🚩 Change the traffic light state dynamically
    function changeLight(
        string memory intersection,
        string memory newState
    ) public {
        // 🏁 ANSWER: Validation logic
        require(
            keccak256(abi.encodePacked(newState)) ==
                keccak256(abi.encodePacked("red")) ||
                keccak256(abi.encodePacked(newState)) ==
                keccak256(abi.encodePacked("green")) ||
                keccak256(abi.encodePacked(newState)) ==
                keccak256(abi.encodePacked("yellow")),
            "Invalid state! State must be 'red', 'green', or 'yellow'."
        );

        // 🏁 ANSWER: Update light state
        lightState[intersection] = newState;
    }
}
