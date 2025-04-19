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
