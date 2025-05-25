// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataOptimization {
    string public storedMessage = "Stored permanently";

    function updateMessage(string memory tempMessage) public {
        storedMessage = tempMessage;
    }

    function compareStorageAndMemory() public view returns (string memory) {
        string memory tempMessage = storedMessage;
        return tempMessage;
    }
}
