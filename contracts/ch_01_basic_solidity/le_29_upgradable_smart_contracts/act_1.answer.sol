// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserRegistryV1 {
    mapping(address => string) public userNames;

    function initialize() public /*initializer*/ {
        // Initialization logic (for now, nothing needed)
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
