# Tasks for Learners

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
