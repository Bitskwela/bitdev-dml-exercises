# Side Quest 5: Dynamic Pricing Contract

## Scenario:

Hackana’s exploit caused the San Juan ride-hailing app to have static, unfair pricing. Neri needs to implement dynamic pricing based on demand and time.

- Time Allotment: 20 minutes
- Solidity Topics Covered: Dynamic Pricing, Functions, Logic.
- Checklist: Update pricing dynamically, use input parameters effectively.

## TODO:

- Implement a function to calculate price based on demand and time.

## Code Activity:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DynamicPricing {
    // 🚩 TODO: Add logic for dynamic pricing
    function calculatePrice(uint256 basePrice, uint256 demandFactor)
        public
        pure
        returns (uint256)
    {
        return basePrice;
    }
}
```

**Hints:**

- Use multipliers for demand and conditions for time.
- Formula to get the dynamic pricing: `base + (base * demand) / 100`

## Expected answer (flagged)

```solidity
// 🚩 ANSWER: Add demand factor to base price
return basePrice + (basePrice * demandFactor) / 100;
```
