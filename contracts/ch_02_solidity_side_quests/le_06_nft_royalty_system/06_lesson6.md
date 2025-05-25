---
title: "Side Quest 6: NFT Royalty System"

description: "A short description of this document."

# This is the date the document was last updated.  Format: YYYY-MM-DD.
date: "2025-03-30"

# For SEO purposes
tags: ["markdown", "metadata", "bitskwela", "solidity"]

# Currently supported types:
# NormalExercise - Just a simple module.  Does not require user input.
# ActivityExercise - Where the user needs to submit a code and verify.  As of now, no backend verification.
# May be supported in the future:
# VideoExercise - For exercises that are just videos.
type: "ActivityExercise"

# Note: Permanames are unique and immutable. Once set, they cannot be changed.  You may change the filename but not this.
permaname: "sq-6-nft-royalty-system"

# Can be the same as permaname but can be changed if needed.
slug: "sq-6-nft-royalty-system"
---

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
