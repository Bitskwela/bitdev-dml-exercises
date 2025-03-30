---
title: "NFT Minting Logic"
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
permaname: "sq-1-token-transfer-and-approval"

# Can be the same as permaname but can be changed if needed.
slug: "sq-2-nft-minting-logic"
---

# Side Quest 2: NFT Minting Logic

## Scenario:

Some Hackana minions exploited an NFT contract by bypassing the minting limit. Neri needs to secure the minting function.

- Time Allotment: 20 minutes
- Solidity Topics Covered: ERC721, Minting Rules, Access Control.
- Checklist: Enforce minting limits, restrict access to authorized addresses.

## TODO:

Add a condition to limit the number of NFTs minted.
Restrict minting to the contract owner.

## Code Activity:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SecureNFT {
    uint256 public totalSupply;
    uint256 public maxSupply = 100; // Max NFTs
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // 🚩 TODO: Restrict minting to owner and check max supply
    function mintNFT() public {
        totalSupply++;
    }
}
```

**Hints:**

- Create a modifier to restrict the mintNFT function.
- Add a check to ensure `totalSupply` does not exceed `maxSupply`.
- Attached the modifer to the `mintNFT` function.

## Expected answer (flagged)

```solidity
// 🚩 ANSWER: Ensure caller is the owner
require(msg.sender == owner, "Not the owner");

// 🚩 ANSWER: Enforce max supply limit
require(totalSupply < maxSupply, "Max supply reached");
```
