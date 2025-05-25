// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// contract NFTWithRoyalties {
//     address public creator;
//     uint256 public royaltyPercentage; // e.g., 10 for 10%
//     address public currentOwner;

//     constructor(address _creator, uint256 _percentage) {
//         creator = _creator;
//         royaltyPercentage = _percentage;
//         currentOwner = _creator;
//     }

//     // TODO: Deduct royalties from salePrice and send to creator
//     // TODO: Send remaining amount to currentOwner
//     // TODO: Transfer ownership to buyer
//     function transferNFT(address buyer, uint256 salePrice) public payable {
//         require(msg.value == salePrice, "Incorrect payment amount");

//         // Implement royalty logic here
//     }
// }
