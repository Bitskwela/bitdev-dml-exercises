# Smart Contract Activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/utils/Initializable.sol";

contract UserRegistryV1 {
    // Mapping to store user addresses and their names
    mapping(address => string) public userNames;

    function initialize() public /*initializer*/ {

    }

    function registerUser(string memory name) public {
        userNames[msg.sender] = name;
    }

    function getUser(address user) public view returns (string memory) {
        return userNames[user];
    }
}

contract UserRegistryV2 {}

```

## Task for Learners

- Import the `Initializable` contract from OpenZeppelin.
  ```solidity
  import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
  ```
- Complete the `UserRegistryV2` contract by extending `UserRegistryV1`. Add a function `updateUser` that allows users to update their names.
  Create an upgradable contract that stores a list of registered users. In the first version, users can only register. In the second version, add functionality to update user details.
  ```solidity
  contract UserRegistryV2 is UserRegistryV1 {
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
