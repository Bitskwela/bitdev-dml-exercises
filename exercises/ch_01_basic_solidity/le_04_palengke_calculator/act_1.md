# Tasks for Learners

- Use math operations to calculate the total cost of goods based on quantity and price.
- Apply subtraction to compute the change owed to the customer after payment.
- Create a multiplication function for discounts or bulk purchases.
- Use division to fairly split group payments.

### Smart Contract Activity: Palengke Calculator

```solidity
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
```

### Breakdown for Learners

- `calculateTotal`

  - Purpose: Calculates the total price for multiple items.
  - Inputs: Price per item and quantity.
  - Output: Total price (price per item × quantity).

- `calculateChange`

  - Purpose: Calculates the change to give back to a customer.
  - Inputs: Total cost and amount paid by the customer.
  - Output: The difference (payment − total cost).
  - Error Check: Ensures the payment is enough (cannot be less than the total cost).

- `applyDiscount`

  - Purpose: Applies a discount to the total cost.
  - Inputs: Total cost and discount percentage.
  - Output: The discounted price.
  - Error Check: Ensures the discount percentage is valid (cannot be more than 100%).

- `splitBill`
  - Purpose: Splits the total cost equally among a group of people.
  - Inputs: Total cost and group size.
  - Output: Each person's share of the cost.
  - Error Check: Ensures group size is greater than 0.

### Key Points:

- Math Operations: Used for calculations like total cost, change, and discounts (multiplication, subtraction, division).
- Error Handling with require(): Ensures valid inputs and prevents mistakes (e.g., not enough payment or invalid discount).
- Modular Functions: Each function handles one specific task, making the contract easy to read and reuse.

### Why It Matters:

- This contract simulates everyday transactions, like buying goods, paying for them, and splitting the cost in a group. It helps make transactions more transparent and automated, which could be useful for managing sales in markets (like palengkes).
