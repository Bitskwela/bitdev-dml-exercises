---
title: "Side Quest 5: Dynamic Pricing Contract"
description: "A short description of this document."

# This is the date the document was last updated.  Format: YYYY-MM-DD.
date: "2025-03-30"

# For SEO purposes
tags: ["markdown", "metadata", "bitskwela", "solidity"]

# Currently supported types:
# NormalExercise - Just a simple module.  Does not require user input.
# ActivityExercise - Where the user needs to submit a code and verify.  As of now, no backend verification.
# May be supported in the future:
# VideoExercise - For exercises that are just videos.
type: "ActivityExercise"

# Note: Permanames are unique and immutable. Once set, they cannot be changed.  You may change the filename but not this.
permaname: "sq-5-dynamic-pricing"

# Can be the same as permaname but can be changed if needed.
slug: "sq-5-dynamic-pricing"
---

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
