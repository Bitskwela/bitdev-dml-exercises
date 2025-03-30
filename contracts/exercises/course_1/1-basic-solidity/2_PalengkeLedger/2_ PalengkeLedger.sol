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
