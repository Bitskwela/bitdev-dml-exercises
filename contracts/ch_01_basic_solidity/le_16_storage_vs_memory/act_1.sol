// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataOptimization {
    // 🚩 Task 1: Define a storage variable
    string public storedMessage = "Stored permanently";

    // 🚩 Task 2: Use a memory variable for temporary updates
    function updateMessage(string memory tempMessage) public {
        // Memory variable used only during this function call
        storedMessage = tempMessage;
    }

    // 🚩 Task 3: Compare storage and memory
    function compareStorageAndMemory() public view returns (string memory) {
        string memory tempMessage = storedMessage; // Copy storedMessage into memory
        return tempMessage; // Returns the temporary memory variable
    }
}
