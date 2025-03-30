---
title: "Palengke Calculator"
description: "A short description of this document."

# This is the date the document was last updated.  Format: YYYY-MM-DD.
date: "2025-03-30"

# For SEO purposes
tags: ["markdown", "metadata", "bitskwela", "solidity"]

# Currently supported types:
# NormalExercise - Just a simple module.  Does not require user input.
# ActivityExercise - Where the user needs to submit a code and verify.  As of now, no backend verification.
# May be supported in the future:
# VideoExercise - For exercises that are just videos.
type: "NormalExercise"

# Note: Permanames are unique and immutable. Once set, they cannot be changed.  You may change the filename but not this.
permaname: "palengke-calculator"

# Can be the same as permaname but can be changed if needed.
slug: "palengke-calculator"
---

# Grocery Price Miscalculations at the Palengke

## Scene: Market Math Mishaps

One weekend, Neri heads to the local palengke (wet market) to buy groceries. She notices an issue at a stall where a vendor struggles to calculate the total bill for a customer buying a mix of vegetables, rice, and fish.

**“Kuya, sabi mo 250 pesos lang, bakit naging 300 na?”**

("_Sir, you said it was 250 pesos, why did it become 300 now?"_)

The vendor's old calculator and mental math led to errors in the total. Observing this, Neri envisions a smart contract that automates such calculations, ensuring accuracy every time.

This problem gives her the perfect opportunity to dive into math operations in Solidity, which are critical for any contract dealing with payments, balances, or numerical data.

## Solidity Topics: Math Operations

Solidity supports a variety of arithmetic operations, which are essential for managing financial transactions and other computations.

### Key Math Operations in Solidity

- Addition (`+`): Adding numbers, e.g., total price of goods.
- Subtraction (`-`): Calculating remaining balances or refunds.
- Multiplication (`*`): Used to compute totals based on quantity and price.
- Division (`/`): Splitting amounts or calculating averages.
- Modulus (`%`): Finding remainders, e.g., splitting funds evenly.

### Important Notes for Solidity Math

- Integer Division: Solidity uses integers (whole numbers), so `5 / 2` results in `2`, _not_ `2.5`.
- Overflow/Underflow (Old Versions): Previously, operations exceeding a number's limit caused errors. This is now mitigated in Solidity 0.8.0 and above.
- SafeMath Library: Was used to prevent overflow/underflow in earlier versions but is no longer required in Solidity 0.8+.

### Sample syntax

**Addition**:

```solidity
uint256 public sum = 5 + 3; // Result: 8
```

**Subtraction**:

```solidity
uint256 public difference = 10 - 3; // Result: 7
```

**Multiplication**:

```solidity
uint256 public product = 7 * 3; // Result: 21
```

**Division**:

```solidity
uint256 public quotient = 10 / 5; // Result: 2
```

**Modulo**:

```solidity
uint256 public remainder = 10 % 3; // Result: 1
```

### Tasks for Learners

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
