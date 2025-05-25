### Smart Contract Activity: Palengke Calculator

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract PalengkeCalculator {
    function calculateTotal() public pure returns (uint256) {}

    function calculateChange() public pure returns (uint256) {}

    function applyDiscount() public pure returns (uint256) {}

    function splitBill() public pure returns (uint256) {}
}
```

# Tasks for Learners

- `calculateTotal` function: Use math operations to calculate the total cost of goods based on quantity and price.

  ```solidity
  function calculateTotal(
      uint256 pricePerUnit,
      uint256 quantity
  ) public pure returns (uint256) {
      return pricePerUnit * quantity;
  }
  ```

- `calculateChange` function: Apply subtraction to compute the change owed to the customer after payment.

  ```solidity
  function calculateChange(
          uint256 totalCost,
          uint256 payment
      ) public pure returns (uint256) {
          require(payment >= totalCost, "Insufficient payment.");
          return payment - totalCost;
      }
  ```

- `applyDiscount` function: Create a multiplication function for discounts or bulk purchases.

  ```solidity
  function applyDiscount(
          uint256 totalCost,
          uint256 discountPercent
      ) public pure returns (uint256) {
          require(discountPercent <= 100, "Invalid discount percentage.");
          return totalCost - ((totalCost * discountPercent) / 100);
      }
  ```

- `splitBill` function: Use division to fairly split group payments.
  ```solidity
    function splitBill(
           uint256 totalCost,
           uint256 groupSize
      ) public pure returns (uint256) {
           require(groupSize > 0, "Group size must be greater than zero.");
           return totalCost / groupSize;
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
