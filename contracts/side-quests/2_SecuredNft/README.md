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

```
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

```
// 🚩 ANSWER: Ensure caller is the owner
require(msg.sender == owner, "Not the owner");

// 🚩 ANSWER: Enforce max supply limit
require(totalSupply < maxSupply, "Max supply reached");
```
