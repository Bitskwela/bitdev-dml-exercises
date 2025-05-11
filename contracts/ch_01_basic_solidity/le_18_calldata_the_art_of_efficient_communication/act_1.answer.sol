// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayServiceFees {
    uint256 public certificationFee = 100; // Fee for one certification

    function getCertificationFee() public view returns (uint256) {
        return certificationFee;
    }

    function calculateTotalCost(
        uint256 numberOfCertifications
    ) public pure returns (uint256) {
        return numberOfCertifications * 100;
    }
}
