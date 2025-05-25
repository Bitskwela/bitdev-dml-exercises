// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library MathLibrary {
    function calculatePercentage(
        uint256 base,
        uint256 percent
    ) internal pure returns (uint256) {
        return (base * percent) / 100;
    }
}

contract HackanaDefense {
    string public city = "San Juan City";

    function calculateFee(
        uint256 transactionAmount,
        uint256 feePercent
    ) public pure returns (uint256) {
        return MathLibrary.calculatePercentage(transactionAmount, feePercent);
    }
}
