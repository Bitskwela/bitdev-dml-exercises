# Smart contract activity:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DynamicPricing {
    /**
     * @dev Calculates dynamic pricing for a ride.
     * @param basePrice The base price of the ride.
     * @param demandFactor A percentage increase based on demand (e.g. 20 means +20%).
     * @param timeFactor A percentage increase based on time of day (e.g. 10 means +10%).
     * @return The dynamically calculated ride price.
     */
    function calculatePrice(
        uint256 basePrice,
        uint256 demandFactor,
        uint256 timeFactor
    ) public pure returns (uint256) {
        // TODO: Calculate price by applying demandFactor and timeFactor to basePrice
        return basePrice; // ← This is incorrect. You must apply dynamic pricing here.
    }
}

```

## Tasks for students:

Implement a function to calculate price based on demand and time. Following the equations below:

```text
basePrice = 100
demandFactor = 20    // +20%
timeFactor = 10      // +10%

Example: finalPrice = 100 * (120) * (110) / 10000 = 132
```

- Solve the dynamic pricing formula in the `calculatePrice` function by updating it and performing the following steps:

  - Apply `demandFactor` as a percentage increase on the basePrice.
  - Apply `timeFactor` as a second percentage increase on top of the already adjusted price.
  - Return the fully adjusted dynamic price.
  - Ensure the function is pure and efficient.

  ```solidity
  function calculatePrice(
      uint256 basePrice,
      uint256 demandFactor,
      uint256 timeFactor
  ) public pure returns (uint256) {
      uint256 demandAdjustment = (basePrice * demandFactor) / 100;
      uint256 tempPrice = basePrice + demandAdjustment;

      uint256 timeAdjustment = (tempPrice * timeFactor) / 100;
      uint256 finalPrice = tempPrice + timeAdjustment;

      return finalPrice;
  }
  ```

### Explanation of the answer

This dynamic pricing formula calculates the ride cost based on two variable factors:

- **Demand Factor**: Simulates surges during peak hours or holidays. E.g., if basePrice = 100 and demandFactor = 20, price becomes 120.

- **Time Factor**: Adds another layer of adjustment (e.g. late night, heavy traffic). E.g., timeFactor = 10 would make 120 → 132.

This simulates real-world surge pricing behavior like in Uber/Grab using only pure math and logic.
