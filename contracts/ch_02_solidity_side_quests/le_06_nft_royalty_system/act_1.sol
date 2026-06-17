// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NFTWithRoyalties {
    address public creator;
    uint256 public royaltyPercentage; // e.g., 10 for 10%
    address public currentOwner;

    constructor(address _creator, uint256 _percentage) {
        creator = _creator;
        royaltyPercentage = _percentage;
        currentOwner = _creator;
    }

    function transferNFT(address buyer, uint256 salePrice) public payable {
        require(msg.value == salePrice, "Incorrect payment amount");

        // TODO: Deduct royalty from the sale price and transfer it to the creator
        // TODO: Send the remaining amount to the current owner
        // TODO: Transfer ownership to the buyer
    }
}
