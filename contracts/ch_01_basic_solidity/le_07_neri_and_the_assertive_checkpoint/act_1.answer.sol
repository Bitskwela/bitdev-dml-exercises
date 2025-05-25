// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract HackanaDefense {
    uint256 public criticalData;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function updateCriticalData(uint256 _newData) public {
        criticalData = _newData;
        assert(criticalData >= 0);
    }

    function restrictedUpdate(uint256 _newData) public {
        if (msg.sender != owner) {
            revert("Access denied: Only the owner can update critical data.");
        }
        criticalData = _newData;
    }
}
