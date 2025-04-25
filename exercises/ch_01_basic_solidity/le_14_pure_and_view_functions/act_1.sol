// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayServiceFees {
    // 🚩 Task 1: State variable for service fee
    uint256 public certificationFee = 100; // Fee for one certification

    // 🚩 Task 2: View function to get the fee
    function getCertificationFee() public view returns (uint256) {
        return certificationFee;
    }

    // 🚩 Task 3: Pure function to calculate total fees for multiple requests
    function calculateTotalCost(
        uint256 numberOfCertifications
    ) public pure returns (uint256) {
        return numberOfCertifications * 100; // Assuming fixed fee of 100
    }
}
