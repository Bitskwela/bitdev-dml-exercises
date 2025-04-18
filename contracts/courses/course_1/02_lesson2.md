---
title: "Palengke troubles and immutable data"
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
permaname: "palengke-troubles"

# Can be the same as permaname but can be changed if needed.
slug: "palengke-troubles"
---

# Palengke troubles and immutable data

## Scene:

After work, Neri heads to the palengke (wet market) to buy her groceries. Chaos reigns as vendors deal with failed QR transactions and confusion over cash payments. One vendor, Ate Linda, gets shortchanged because she couldn’t calculate exact change properly. Another vendor complains about inconsistent records, leading to mistrust among customers.

Neri reflects on how blockchain’s immutability can solve this. If payment records were on-chain and all parties agreed on a shared, transparent ledger, these disputes could vanish. She remembers how data types in Solidity define and structure information, ensuring it’s accurate, consistent, and secure.

### Solidity Topic: Data types

#### Explanation for Learners:

In Solidity, data types help structure information like _numbers_, _text_, or _true_/_false_ values.

Common data types include:

- Boolean (`bool`): Represents true/false values. Useful for conditions like _"Is the transaction valid?"_

  ```solidity
  bool isForSale = true;
  ```

- Integer `uint` and `int`:

  - Think of `uint` as a container for **non-negative whole numbers**. It can store zero and any positive number, but it **cannot** store negative numbers.
  - The `uint` keyword is followed by a number indicating the number of bits used to store the value (e.g., `uint8`, `uint16`, `uint256`). The larger the number of bits, the larger the number the variable can store.
  - `uint256` is the most commonly used unsigned integer type. It's the default if you just write `uint`.
  - **Example:** Imagine you're counting the number of mangoes a vendor sells. You'll never have a negative number of mangoes, so `uint` is perfect for this.

    ```solidity
    uint256 numberOfMangoes = 10; // This is valid
    // uint256 numberOfMangoes = -10; // This will cause an error because uint cannot be negative
    ```

    - `int` can store **both positive and negative whole numbers, including zero.**

    * Like `uint`, `int` also comes in different sizes (e.g., `int8`, `int16`, `int256`), with `int256` being the most common and the default if you just write `int`.

    * **Example:** Think about tracking a vendor's profit/loss. They can have a profit (positive number) or a loss (negative number), so `int` is suitable here.

      ```solidity
      int256 profit = 100;   // Positive profit
      int256 loss = -50;     // Negative loss
      ```

- String (`string`): Holds text, like a vendor’s name or product description.

  ```solidity
  string myMessage = "Is this available?";
  ```

- Address (`address`): Represents Ethereum wallet addresses, crucial for identifying participants in transactions.

  ```solidity
  address myWallet = 0xDF744BA5808cde3e87B3390A8A3DcE5cCB349068;

  ```

- Array (`array`): Stores multiple values of the same type. For example, a list of all transactions in the palengke.

  ```solidity
  // Fixed-size array: A list of the 3 most recent transaction amounts
  uint256[3] public recentTransactions = [1, 2, 3];

  // Dynamic array: A list of product prices
  uint256[] public productPrices = [10, 20, 30, 40, 50];

  // String array: A list of common vendor names
  string[] public vendorNames = ["Aling Nena", "Mang Juan", "Ate Maria"];
  ```

- Mapping (`mapping`): Key-value pairs that link one piece of data to another. Example: Linking a vendor’s address to their payment record.

  ```solidity
  // Mapping: Associate vendor addresses with their balances
  mapping(address => uint256) public vendorBalances;

  // Mapping: Associate student id with their grades
  mapping(uint => string) public studentGrades;

  // Mapping: Associate product name with its price
  mapping(string => uint) public productPrices;

  // Example usage in a function:
  function updateVendorBalance(address _vendor, uint256 _newBalance) public {
      vendorBalances[_vendor] = _newBalance;
  }

  function setStudentGrade(uint _studentId, string memory _grade) public {
      studentGrades[_studentId] = _grade;
  }

  function setProductPrice(string memory _productName, uint _price) public {
      productPrices[_productName] = _price]
  }
  ```

### Tasks for Learners

- Create variables to represent the following data:

  - Vendor name (`string`).
  - Total sales (`uint`).
  - Transaction status (`bool`).

- Observe the function to update the total sales after a purchase.
- Inspect the function to check if a transaction was successful or not (bool).
- Create a mapping variable to store vendor sales by their wallet address.

### Perform the following tasks above on the PalengkeLedger smart contract:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PalengkeLedger {
    // 🚩 TODO: Task 1 - Declare variables for vendor name, total sales, and transaction status
    string public vendorName; // Vendor's name
    uint256 public totalSales; // Total sales made
    bool public transactionStatus; // Whether the last transaction succeeded or not

    // 🚩 TODO: Task 2 - Mapping to store vendor sales by address
    mapping(address => uint256) public vendorSales;

    function recordSale(
        address _vendor,
        string memory _vendorName,
        uint256 _saleAmount
    ) public {
        vendorName = _vendorName; // Update the vendor's name
        totalSales += _saleAmount; // Increment the total sales
        vendorSales[_vendor] += _saleAmount; // Update the mapping for vendor's sales
        transactionStatus = true; // Mark the transaction as successful
    }

    function isTransactionSuccessful() public view returns (bool) {
        return transactionStatus; // Return the status of the last transaction
    }
}
```

### Breakdown for learners

- Variables Defined:

  - `vendorName`: Textual name of the vendor.
  - `totalSales`: Keeps track of the total amount sold.
  - `transactionStatus`: Boolean to confirm if a sale was successful.
  - `vendorSales`: Mapping to store track the sales of each vendors.

- Mapping Used:
  - Links a vendor's wallet address (`address`) to their sales.
- Update Function:
  - recordSale: Adds sales amount to `totalSales` and stores the value in `vendorSales`.
- Boolean Check:
  - `isTransactionSuccessful` : Returns the outcome of the last transaction.
