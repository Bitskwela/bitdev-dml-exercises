---
title: "Side Quest 7: Decentralized Traffic Management"

description: "A short description of this document."

# This is the date the document was last updated.  Format: YYYY-MM-DD.
date: "2025-03-30"

# For SEO purposes
tags: ["markdown", "metadata", "bitskwela", "solidity"]

# Currently supported types:
# NormalExercise - Just a simple module.  Does not require user input.
# ActivityExercise - Where the user needs to submit a code and verify.  As of now, no backend verification.
# May be supported in the future:
# VideoExercise - For exercises that are just videos.
type: "ActivityExercise"

# Note: Permanames are unique and immutable. Once set, they cannot be changed.  You may change the filename but not this.
permaname: "sq-7-decentralize-traffic-mgmt"

# Can be the same as permaname but can be changed if needed.
slug: "sq-7-decentralize-traffic-mgmt"
---

# Side Quest 7: Decentralized Traffic Management

## Scenario:

While most of Hackana’s chaos has been contained, a new issue arises: traffic mismanagement in Metro Manila. Hackana minions tampered with the traffic management system, leaving intersections unable to coordinate properly. Traffic lights remain stuck on red, causing massive gridlocks. Neri receives an urgent message from MMDA (Metro Manila Development Authority), requesting her expertise to fix the traffic light logic.

## Time Allotment: 20 minutes

## Problem Overview:

The MMDA traffic light system must allow dynamic updates to traffic light states for each intersection (red, yellow, green). However, the system must ensure only valid states can be set to avoid further chaos.

The goal is to:

- Use mappings to store the state of each traffic light.
- Ensure that only valid states ("red," "yellow," or "green") can be set.

## Solidity Topics Covered

- Mappings – To store the state of traffic lights by intersection.
- Require Statement – To validate the newState.
- Constructor – To initialize default values.

## TODO:

- Implement a function to switch traffic light states dynamically.

## Code Activity:

Here’s the incomplete smart contract. Update the logic in the changeLight function to ensure:

- The newState must be one of the allowed values (`"red"`, `"yellow"` or `"green"`).
- If invalid, the transaction should revert with an appropriate error message.

```solidity
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
    function changeLight(string memory intersection, string memory newState) public {
        // TODO: Implement validation logic for newState and update lightState.
    }
}
```

## Checklist for Learners:

To verify your implementation, ensure the following:

- The require statement correctly validates the newState.
- The changeLight function updates the state only when valid.
- Transactions with invalid newState are reverted with an error message: "Invalid state! State must be 'red', 'green', or 'yellow'."
- You can dynamically update any intersection state by calling changeLight.

## Hints

- Use keccak256(abi.encodePacked()) to compare strings in Solidity, as direct string comparisons are not allowed.
- The constructor initializes the default traffic light states, so only update the changeLight function.
- Think about edge cases: What happens if someone sends an invalid state like "blue"?

### Expected answer (flagged)

```solidity
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
    function changeLight(string memory intersection, string memory newState) public {
        // 🏁 ANSWER: Validation logic
        require(
            keccak256(abi.encodePacked(newState)) == keccak256(abi.encodePacked("red")) ||
            keccak256(abi.encodePacked(newState)) == keccak256(abi.encodePacked("green")) ||
            keccak256(abi.encodePacked(newState)) == keccak256(abi.encodePacked("yellow")),
            "Invalid state! State must be 'red', 'green', or 'yellow'."
        );

        // 🏁 ANSWER: Update light state
        lightState[intersection] = newState;
    }
}
```
