# Side Quest 6: NFT Royalty System

# Scenario:

Hackana’s NFT marketplace exploit left artists without royalties. Neri must fix the royalty payout mechanism for NFT creators.

- Time Allotment: 20 minutes
- Solidity Topics Covered: ERC721, Royalties, Transfers.
- Checklist: Ensure royalties are transferred correctly to creators.

## TODO:

- Implement a royalty payout function for every NFT transfer.

## Code Activity:

```solidity
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
```

**Hints:**

- Calculate royalty as a percentage of the sale price.
- Royalty computation: `(price * percentage) / 100`

## Expected Answer (Flagged):

```solidity
// 🚩 ANSWER: Calculate and transfer royalties
uint256 royalty = (salePrice * royaltyPercentage) / 100;
payable(creator).transfer(royalty);
```
