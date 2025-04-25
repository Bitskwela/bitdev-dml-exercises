# Task for Learners

- Create an array to store payment amounts for a day.
- Write functions to:
  - Add a payment to the array.
  - Retrieve the total number of payments.
  - Access a specific payment by its index.

## Smart contract activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PalengkeTransactions {
    // 🚩 Task 1: Create a dynamic array to store payment amounts
    uint256[] public payments;

    // 🚩 Task 2: Add a function to record a payment
    function recordPayment(uint256 _amount) public {
        payments.push(_amount); // Add the payment to the array
    }

    // 🚩 Task 3: Add a function to get the total number of payments
    function getTotalPayments() public view returns (uint256) {
        return payments.length; // Return the number of elements in the array
    }

    // 🚩 Task 4: Add a function to retrieve a payment by index
    function getPayment(uint256 _index) public view returns (uint256) {
        require(_index < payments.length, "Invalid index.");
        return payments[_index]; // Return the payment at the given index
    }
}
```

### Breakdown of the Activity

**Array Defined:**

- `payments`: A dynamic array of `uint256` to store payment amounts.

**Key Functions:**

- `recordPayment`: Accepts a payment amount as input.
  Adds it to the payments array using the push() function.
- `getTotalPayments`: Returns the total number of payments stored in the array by accessing its length property.
- `getPayment`: Retrieves a specific payment by its index.
  Uses a require statement to ensure the index is valid.
