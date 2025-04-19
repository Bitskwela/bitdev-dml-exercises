# Task for Learners

Neri needs to create a library to simplify common mathematical operations for validating transactions. Your task is to:

- Define a library named `MathLibrary`.
- Add a function to calculate the percentage of a number.
- Deploy and integrate the library with the main contract.

### Smart contract activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 🚩 TODO: Define the MathLibrary with a percentage calculation function
library MathLibrary {
    function calculatePercentage(
        uint256 base,
        uint256 percent
    ) internal pure returns (uint256) {
        // Answer: Implement percentage calculation logic here
        return (base * percent) / 100;
    }
}

contract HackanaDefense {
    // State variables
    string public city = "San Juan City";

    // Function to calculate transaction fees
    function calculateFee(
        uint256 transactionAmount,
        uint256 feePercent
    ) public pure returns (uint256) {
        // 🚩 TODO: Use the library's function to calculate the fee
        return MathLibrary.calculatePercentage(transactionAmount, feePercent);
    }
}
```

### Breakdown of Activity

**Library Definition:**

- The `MathLibrary` is defined to perform mathematical operations.
- A function `calculatePercentage` is implemented for percentage-based calculations.

**Library Usage:**

- The **HackanaDefense** contract uses MathLibrary to calculate transaction fees in the `calculateFee` function.

### Closing Story

Neri successfully deploys her newly crafted library to San Juan City's blockchain defenses. The library optimizes transaction validation and ensures wallets process payments securely and efficiently.

Hackana, unable to exploit the hardened systems, retreats into digital obscurity.

With the city's digital economy stabilized, Neri celebrates with her community, knowing libraries have become her secret weapon for the future. 🎉
