# Task for Learners

Create an upgradable contract that stores a list of registered users. In the first version, users can only register. In the second version, add functionality to update user details.

## Smart Contract Activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 🚩 TODO: Import the OpenZeppelin Contracts for upgrades
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";

contract UserRegistryV1 is Initializable {
    // State variable to store registered users
    mapping(address => string) private userNames;

    // 🚩 TODO: Initialize the contract
    function initialize() public initializer {
        // Initialization logic
    }

    // Function to register a user
    function registerUser(string memory name) public {
        userNames[msg.sender] = name;
    }

    // Function to get the name of a registered user
    function getUser(address user) public view returns (string memory) {
        return userNames[user];
    }
}

// Version 2 - Upgrade to allow updating user names
contract UserRegistryV2 is UserRegistryV1 {
    // Function to update user name
    function updateUser(string memory newName) public {
        userNames[msg.sender] = newName;
    }
}
```

### Breakdown of the Activity

**Imports:** Imported Initializable from OpenZeppelin to support initialization.

**UserRegistryV1:**

- `initialize()`: Sets up the contract, required for upgradeable contracts.
- `registerUser()`: Allows users to register by storing their names.
- `getUser()`: Retrieves the name of a registered user.

**UserRegistryV2:**

- Extends `UserRegistryV1`.
- Adds the `updateUser()` function, enabling users to modify their names.

**Upgrading Process:**

- Deploy `UserRegistryV1` with a proxy.
- Upgrade the proxy to point to `UserRegistryV2`.

### Closing Story

As Hackana morphs into its final form, launching its most destructive attack yet, Neri's adaptive contracts come to life.

With every assault, her team deploys real-time updates, nullifying Hackana's every move. The dynamic system evolves faster than the malware can adapt, leading to Hackana's ultimate defeat.

The battle isn't just won—Neri's strategy transforms how systems defend against threats, heralding a new era of resilient, evolving digital infrastructure.
