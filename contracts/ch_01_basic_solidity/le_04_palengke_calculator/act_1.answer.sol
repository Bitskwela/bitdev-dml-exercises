// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract PalengkeCalculator {
    function calculateTotal(
        uint256 pricePerUnit,
        uint256 quantity
    ) public pure returns (uint256) {
        return pricePerUnit * quantity;
    }

    function calculateChange(
        uint256 totalCost,
        uint256 payment
    ) public pure returns (uint256) {
        require(payment >= totalCost, "Insufficient payment.");
        return payment - totalCost;
    }

    function applyDiscount(
        uint256 totalCost,
        uint256 discountPercent
    ) public pure returns (uint256) {
        require(discountPercent <= 100, "Invalid discount percentage.");
        return totalCost - ((totalCost * discountPercent) / 100);
    }

    function splitBill(
        uint256 totalCost,
        uint256 groupSize
    ) public pure returns (uint256) {
        require(groupSize > 0, "Group size must be greater than zero.");
        return totalCost / groupSize;
    }
}
