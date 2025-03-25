// SPDX-License-Identifier: MIT

// 🚩 TODO: Add another state variable to store the payer's name
pragma solidity ^0.8.0;

// Define a contract named PalengkePay
contract PalengkePay {
    // State variable to store vendor name
    string public vendorName;

    // State variable to store the total payment amount
    uint256 public totalPayments;

    // 🚩 TODO: Add another state variable to store the payer's name
    string public payerName;

    // Function to set vendor details and payment
    function recordPayment(string memory _vendorName, uint256 _amount) public {
        vendorName = _vendorName; // Set the vendor's name
        totalPayments = _amount; // Update the total payments

        // 🚩 TODO: Update this function to also record the payer's name
        payerName = "Replace this with your name :)"; // Replace this line with your name
    }
}
