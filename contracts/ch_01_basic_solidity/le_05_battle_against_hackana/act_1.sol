// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CommunityFund {
    address public fundOwner;
    uint256 public totalDonations;

    constructor() {
        fundOwner = msg.sender;
    }

    function donate(uint256 amount) public payable {
        totalDonations += amount;
    }

    function withdraw(uint256 amount) public {
        totalDonations -= amount;
        payable(fundOwner).transfer(amount);
    }
}
