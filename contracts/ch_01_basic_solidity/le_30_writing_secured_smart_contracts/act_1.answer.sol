// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import OpenZeppelin utilities for security
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract SecureDonation is Ownable, ReentrancyGuard {
    constructor() Ownable(msg.sender) ReentrancyGuard() {}

    // State variable to track total donations
    uint256 public totalDonations;

    // Mapping to store donations per user
    mapping(address => uint256) public donations;

    // Function to accept donations
    function donate() external payable nonReentrant {
        require(msg.value > 0, "Donation must be greater than zero.");

        donations[msg.sender] += msg.value;
        totalDonations += msg.value;
    }

    function withdraw() external onlyOwner nonReentrant {
        require(totalDonations > 0, "No funds to withdraw.");

        // Transfer all funds to the owner
        (bool success, ) = owner().call{value: address(this).balance}("");
        require(success, "Withdrawal failed.");
    }
}
