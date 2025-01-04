// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PalengkeCalculator {
    // 🚩 TODO: Task 1 - Function to calculate the total price of goods
    function calculateTotal(
        uint256 pricePerUnit,
        uint256 quantity
    ) public pure returns (uint256) {
        // @note Create a math formula to calculate the total
        return pricePerUnit * quantity;
    }

    // 🚩 TODO: Task 2 - Function to calculate change owed to the customer
    function calculateChange(
        uint256 totalCost,
        uint256 payment
    ) public pure returns (uint256) {
        require(payment >= totalCost, "Insufficient payment.");

        // @note Create a math formula to calculate the change
        return payment - totalCost;
    }

    // 🚩 TODO: Task 3 - Function to calculate discounted price for bulk purchases
    function applyDiscount(
        uint256 totalCost,
        uint256 discountPercent
    ) public pure returns (uint256) {
        require(discountPercent <= 100, "Invalid discount percentage.");

        // @note Create a math formula to apply the discount
        return totalCost - ((totalCost * discountPercent) / 100);
    }

    // 🚩 TODO: Task 4 - Function to split total cost evenly among a group
    function splitBill(
        uint256 totalCost,
        uint256 groupSize
    ) public pure returns (uint256) {
        require(groupSize > 0, "Group size must be greater than zero.");

        // @note Create a math formula to calculate the bill split
        return totalCost / groupSize;
    }
}
