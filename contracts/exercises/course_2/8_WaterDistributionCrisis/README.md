# Sidequest #8: Water Distribution Crisis

## Backstory:

Hackana’s minions have left Manila’s water distribution system in disarray. Reports indicate that water flow allocations between zones have been tampered with, leading to excessive water supply in some areas and severe shortages in others. This crisis has brought barangay officials together, but they need a decentralized and transparent solution to reallocate water supplies fairly and efficiently.

Neri steps up to create a blockchain-based water allocation system to distribute water equitably while maintaining transparency in zone allocations.

## Problem Overview:

The water system must:

- Allow barangay officials to allocate water quotas to specific zones using mappings.
- Ensure that the allocation does not exceed the maximum available supply to prevent wastage or shortages.
- Include functionality to adjust quotas transparently and securely.

## Time allotment: 20 minutes

## Solidity Topics Covered:

- Mappings – To track water allocation for each zone.
- Require Statements – To validate allocation limits.
- Functions – For adjusting and viewing water quotas.

## Code Activity:

Update the `allocateWater` function to ensure:

- The total allocation cannot exceed totalSupply.
- The waterQuota for each zone is correctly updated.

```solidity
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
        // TODO: Validate and update water allocation
    }
}
```

## Hints:

- Use a mapping to track water allocation for each zone.
- Validate that the total allocated water does not exceed the total available supply.
- Consider adding a public function to view the current allocation for transparency.

## Checklist for Learners:

To verify your implementation, ensure the following:

- The require statement validates that the total allocation does not exceed the available supply.
- The `allocateWater` function updates the waterQuota mapping correctly.
- You can dynamically allocate water to different zones and view the updated quotas.

## Expected answer (flagged)

```solidity
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
```
