// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayFund {
    uint256 public totalFunds;
    event FundUpdated(uint256 newAmount, address updatedBy);

    function depositFunds(uint256 amount) public {
        require(amount > 0, "Deposit amount must be greater than zero.");
        totalFunds += amount;

        emit FundUpdated(totalFunds, msg.sender);
    }
}
