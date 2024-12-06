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
