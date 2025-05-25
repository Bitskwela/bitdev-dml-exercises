// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DynamicPricing {
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
}
