// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract JeepneyFareSystem {
    mapping(address => bool) public hasPaid;

    uint256 public baseFare = 13;

    function calculateFare(uint256 distance) public view returns (uint256) {}

    function payFare(uint256 distance) public payable {}

    function checkPaymentStatus(address passenger) public view returns (bool) {}

    function verifyFare(
        uint256 distance,
        uint256 paidAmount
    ) private view returns (bool) {}
}
