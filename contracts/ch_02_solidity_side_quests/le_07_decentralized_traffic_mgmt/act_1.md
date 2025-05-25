## Smart contract activity:

Here’s the incomplete smart contract. Update the logic in the changeLight function to ensure:

- The newState must be one of the allowed values (`"red"`, `"yellow"` or `"green"`).
- If invalid, the transaction should revert with an appropriate error message.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TrafficLightManager {
    mapping(string => string) public lightState;

    // Change the traffic light state dynamically
    function changeLight(string memory intersection, string memory newState) public {
        // Validate that the new state is one of the allowed values
    }
}
```

### Hints

- Use a mapping to track traffic light states by intersection.
- Set default state of all traffic lights to "**red**" in the constructor.
- Validate that the new traffic light state is "**red**", "**yellow**", or "**green**" only.
- Dynamically update the intersection state if valid.

## Tasks for students:

- Set the default state of all traffic lights to "**red**" in the constructor.

  ```solidity
  constructor() {
      lightState["intersection1"] = "red";
      lightState["intersection2"] = "red";
  }
  ```

- Inside the `changeLight` function, validate the `newState` parameter.
  Ensure it is one of the allowed values and revert with an error message if not. Update the `lightState` mapping accordingly with the new state.

  ```solidity
  require(
      keccak256(abi.encodePacked(newState)) == keccak256(abi.encodePacked("red")) ||
      keccak256(abi.encodePacked(newState)) == keccak256(abi.encodePacked("yellow")) ||
      keccak256(abi.encodePacked(newState)) == keccak256(abi.encodePacked("green")),
      "Invalid state! State must be 'red', 'green', or 'yellow'."
  );

    lightState[intersection] = newState;
  ```

## Explanation

- `mapping(string => string) public lightState`: Stores traffic light state for every intersection.

- `constructor()`: Initializes all lights to "red" — the safest fallback during a system reset.

- `changeLight(...)`: Ensures the system won’t accept invalid colors like "blue" or "purple", stopping potential chaos from Hackana’s botnets.
