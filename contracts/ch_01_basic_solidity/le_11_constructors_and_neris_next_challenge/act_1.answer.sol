// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayProgram {
    string public programName;
    uint256 public startingBalance;

    constructor(string memory _programName, uint256 _startingBalance) {
        programName = _programName;
        startingBalance = _startingBalance;
    }

    function getProgramDetails() public view returns (string memory, uint256) {
        return (programName, startingBalance);
    }
}
