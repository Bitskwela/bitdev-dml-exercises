// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CommunityFund {
    address public fundOwner;
    uint256 public totalDonations;

    constructor() {
        fundOwner = msg.sender; // The contract creator is the fund owner
    }

    // Function to donate to the fund
    function donate(uint256 amount) public payable {
        // 🚩 Task 1: Use require to ensure the donation amount is greater than zero
        require(amount > 0, "Donation must be greater than zero");

        // 🚩 Task 2: Ensure the sender has enough Ether to make the donation
        require(msg.value == amount, "Insufficient Ether provided");

        totalDonations += amount; // Update the total donations
    }

    // Function to withdraw funds (only the owner can withdraw)
    function withdraw(uint256 amount) public {
        // 🚩 Task 3: Ensure only the owner can withdraw funds
        require(msg.sender == fundOwner, "Only the owner can withdraw funds");

        // 🚩 Task 4: Ensure enough funds are available to withdraw
        require(amount <= totalDonations, "Not enough funds");

        totalDonations -= amount;
        payable(fundOwner).transfer(amount);
    }
}
