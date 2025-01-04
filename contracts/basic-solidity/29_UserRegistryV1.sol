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
