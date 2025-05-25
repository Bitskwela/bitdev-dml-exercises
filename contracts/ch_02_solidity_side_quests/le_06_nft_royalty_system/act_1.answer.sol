// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NFTWithRoyalties {
    address public creator;
    uint256 public royaltyPercentage;
    address public currentOwner;

    constructor(address _creator, uint256 _percentage) {
        creator = _creator;
        royaltyPercentage = _percentage;
        currentOwner = _creator;
    }

    function transferNFT(address buyer, uint256 salePrice) public payable {
        require(msg.value == salePrice, "Incorrect payment amount");

        uint256 royalty = (salePrice * royaltyPercentage) / 100;
        payable(creator).transfer(royalty);

        uint256 sellerAmount = salePrice - royalty;
        payable(currentOwner).transfer(sellerAmount);

        currentOwner = buyer;
    }
}
