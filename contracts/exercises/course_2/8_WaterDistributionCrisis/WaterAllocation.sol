// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WaterAllocation {
    uint256 public totalSupply;
    mapping(string => uint256) public waterQuota;

    constructor(uint256 initialSupply) {
        totalSupply = initialSupply;
    }

    // 🚩 Allocate water to a specific zone
    function allocateWater(string memory zone, uint256 amount) public {
        // 🏁 ANSWER: Ensure total allocation does not exceed total supply
        uint256 currentAllocation = 0;

        for (uint256 i = 0; i < totalSupply; i++) {
            currentAllocation += waterQuota[zone];
        }

        require(
            currentAllocation + amount <= totalSupply,
            "Allocation exceeds total supply!"
        );

        // 🏁 ANSWER: Update the water quota for the zone
        waterQuota[zone] += amount;
    }
}
