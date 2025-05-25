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
