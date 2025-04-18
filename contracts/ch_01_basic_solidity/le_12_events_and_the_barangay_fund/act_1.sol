// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayFund {
    uint256 public totalFunds;

    // 🚩 Task 1: Define an event for fund updates
    event FundUpdated(uint256 newAmount, address updatedBy);

    // 🚩 Task 2: Function to update the fund
    function depositFunds(uint256 amount) public {
        require(amount > 0, "Deposit amount must be greater than zero.");
        totalFunds += amount;

        // 🚩 Emit the event
        emit FundUpdated(totalFunds, msg.sender);
    }
}
