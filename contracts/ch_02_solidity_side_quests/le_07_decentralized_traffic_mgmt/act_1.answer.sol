// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TrafficLightManager {
    mapping(string => string) public lightState;

    constructor() {
        lightState["intersection1"] = "red";
        lightState["intersection2"] = "red";
    }

    function changeLight(
        string memory intersection,
        string memory newState
    ) public {
        require(
            keccak256(bytes(newState)) == keccak256(bytes("red")) ||
                keccak256(bytes(newState)) == keccak256(bytes("yellow")) ||
                keccak256(bytes(newState)) == keccak256(bytes("green")),
            "Invalid state"
        );

        lightState[intersection] = newState;
    }
}
