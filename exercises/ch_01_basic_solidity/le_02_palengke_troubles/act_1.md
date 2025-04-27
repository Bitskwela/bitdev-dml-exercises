### Smart contract activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PalengkeLedger {

    // 🚩 TODO: Task 1 - Declare variables for vendor name, total sales, and transaction status

    // 🚩 TODO: Task 2 - Mapping to store vendor sales by address

    // 🚩 TODO: Task 3 - Update the recordSale function
    // to include vendor's wallet address and update the mapping
    // and total sales
    function recordSale(
        address _vendor,
        string memory _vendorName,
        uint256 _saleAmount
    ) public {

    }

}
```

## Tasks for Learners

- Create variables to represent the following data:

  - Vendor name (`string`).
  - Total sales (`uint`).
  - Transaction status (`bool`).

  ```solidity
    string public vendorName;
    uint256 public totalSales;
    bool public transactionStatus;
  ```

- Create a mapping variable to store vendor sales by their wallet address.

  ```solidity
    mapping(address => uint256) public vendorSales;
  ```

- Update the `recordSale` function to include the following:

  - Accept a vendor's wallet address as an argument.
  - Update the vendor's name in the contract.
  - Increment the total sales by the sale amount.
  - Update the mapping for the vendor's sales using their wallet address.

  ```solidity
      function recordSale(
          address _vendor,
          string memory _vendorName,
          uint256 _saleAmount
      ) public {
          vendorName = _vendorName;
          totalSales += _saleAmount;
          vendorSales[_vendor] += _saleAmount;
          transactionStatus = true;
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
