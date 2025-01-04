// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NFTWithRoyalties {
    address public creator;
    uint256 public royaltyPercentage;

    constructor(address _creator, uint256 _percentage) {
        creator = _creator;
        royaltyPercentage = _percentage;
    }

    // 🚩 TODO: Deduct royalties and send to creator
    function transferNFT(address buyer, uint256 salePrice) public {
        // Logic for royalties
    }
}
