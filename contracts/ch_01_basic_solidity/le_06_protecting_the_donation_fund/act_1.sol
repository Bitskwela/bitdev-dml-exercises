// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SecureFund {
    address public owner;
    uint256 public totalDonations;

    constructor() {
        owner = msg.sender; // Set the deployer as the owner
    }

    // 🚩 Task 1: Add a modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // Function to donate funds
    function donate() public payable {
        require(msg.value > 0, "Donation must be greater than zero");
        totalDonations += msg.value;
    }

    // 🚩 Task 2: Add function modifier to withdraw funds and only the owner can call this
    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
