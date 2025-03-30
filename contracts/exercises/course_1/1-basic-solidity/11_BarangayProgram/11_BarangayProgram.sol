// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayProgram {
    // 🚩 Task 1: State variables to store program details
    string public programName;
    uint256 public startingBalance;

    // 🚩 Task 2: Constructor to initialize the program
    constructor(string memory _programName, uint256 _startingBalance) {
        programName = _programName;
        startingBalance = _startingBalance;
    }

    // 🚩 Task 3: Function to retrieve program details
    function getProgramDetails() public view returns (string memory, uint256) {
        return (programName, startingBalance);
    }
}
