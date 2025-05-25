// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TrafficLightManager {
    mapping(string => string) public lightState;

    // TODO: Change the traffic light state dynamically
    function changeLight(
        string memory intersection,
        string memory newState
    ) public {
        // Validate that the new state is one of the allowed values
    }
}
