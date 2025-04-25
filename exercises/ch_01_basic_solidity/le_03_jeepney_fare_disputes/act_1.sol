// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract JeepneyFareSystem {
    mapping(address => bool) public hasPaid;

    uint256 public baseFare = 13;

    // 🚩 TODO: Task 1 - Public function to calculate fare based on distance
    function calculateFare(uint256 distance) public view returns (uint256) {
        return baseFare + (distance * 2);
    }

    // 🚩 TODO: Task 2 - Payable function to accept fare payments
    function payFare(uint256 distance) public payable {
        uint256 requiredFare = calculateFare(distance);
        require(msg.value == requiredFare, "Incorrect fare amount.");
        hasPaid[msg.sender] = true;
    }

    // 🚩 TODO: Task 3 - View function to check payment status
    function checkPaymentStatus(address passenger) public view returns (bool) {
        return hasPaid[passenger];
    }

    // 🚩 TODO: Task 4 - Private function to verify fare calculation (used internally)
    function verifyFare(
        uint256 distance,
        uint256 paidAmount
    ) private view returns (bool) {
        return paidAmount == calculateFare(distance);
    }
}
