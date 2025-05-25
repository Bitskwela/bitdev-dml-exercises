# Side Quest 7: Decentralized Traffic Management

## Scenario:

Hackana’s digital warfare has spilled into the streets. The Metro Manila traffic system is in shambles. Traffic lights across the city are stuck on red, turning intersections into warzones of honking cars and gridlock madness.

The MMDA has no idea how to fix this. They turn to Neri — the only person in the Philippines with enough technical mastery to reprogram the entire decentralized traffic system.

Her mission: deploy smart contract logic that manages traffic lights per intersection, but only allows valid states to prevent chaos. Time is critical.

## Mission Brief

- **Time Allotment**: 20 minutes
- **Solidity Topics Covered**: Mappings, Require Statement, Constructor.

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
