---
title: "Array and the Rising Chaos"
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
type: "ActivityExercise"

# Note: Permanames are unique and immutable. Once set, they cannot be changed.  You may change the filename but not this.
permaname: "arrays-and-the-rising-chaos"

# Can be the same as permaname but can be changed if needed.
slug: "arrays-and-the-rising-chaos"
---

# Arrays and the Rising Chaos Continues

## Scene

Neri’s day begins in the lively streets of San Juan. It’s the weekend, and she heads to the palengke (_wet market_) to buy groceries. The vendors are bustling, calling out prices for freshly caught fish, ripe mangoes, and crunchy vegetables. However, something is off.

The digital payment terminals at the stalls are glitching again. As Neri attempts to buy her favorite bangus (_milkfish_) and some calamansi, she notices that the payments are either being overcharged or duplicated. Vendors are writing down transactions on scratch paper, struggling to keep track of who owes what.

One vendor, Mang Ramon, sighs, “**Kung meron lang tayong paraan para ma-track nang maayos ang mga transaksyon, hindi tayo magulo nang ganito.**”

(_If only we had a proper way to track transactions, we wouldn’t be in such chaos._)

Neri thinks for a moment and remembers something from her Solidity training: arrays. Arrays could simplify this chaos by organizing data, like keeping a running list of all transactions or payments.

## Solidity Topics: Arrays

An array in Solidity is a data structure that allows you to store multiple values of the same type. Arrays are useful for keeping track of sequential data like transactions, IDs, or even names.

### Types of Arrays:

- Fixed-Size Arrays: The size is defined at the time of declaration.

  **Example:** `uint256[5] public fixedArray;`

- Dynamic Arrays: The size is not predefined and can grow or shrink.

  **Example:** `uint256[] public dynamicArray;`

### Common Operations

- Adding Elements: Use the `push()` function for dynamic arrays.

- Accessing Elements: Use the index, starting from 0.

  **Example:** `array[0]` retrieves the first element.

- Modifying Elements: Assign a new value to a specific index.

  **Example:** `array[0] = 100;`

#### Why Arrays Are Useful:

- Store repetitive or sequential data (e.g., all sales made in a day).
- Retrieve, modify, or delete items quickly using their index.

### How to use Arrays in Solidity

- Declare an Array

  - **Example:**

    ```solidity
    uint256[] public payments;
    ```

- Add item to an array

  - **Example:**

    ```solidity
    payments.push(100); // Add a payment of 100
    ```

- Retrieve an element from the array

  - **Example:**

    ```solidity
    uint256 firstPayment = payments[0];
    ```

- Loop through an array

  - **Example:**

    ```solidity
    for (uint256 i = 0; i < payments.length; i++) {
    // Process payments[i]
    }
    ```

### Task for Learners

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
