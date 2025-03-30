# Sidequest #13: Minting NFTs (Create Unique Digital Assets)

## Backstory:

After her victory against Hackana and securing the economy, Neri realizes that the Philippines' rich cultural heritage and art community can benefit from the rise of NFTs. NFTs have revolutionized the digital art world by allowing artists to sell their works as unique digital assets on the blockchain.

However, the problem is that most artists in the Philippines are not yet familiar with NFTs, and there is no easy way for them to tokenize their artworks. Neri decides to build a platform where artists can mint their own NFTs.

This new platform allows creators to mint their own NFTs (which represent their unique digital art, music, or creations) and sell them to collectors. The NFTs are based on the ERC721 standard, which ensures that each NFT is unique and can be bought or sold independently.

## Problem Overview:

In this task, you will create a minting contract that allows users to create unique NFTs. Each minted NFT will have:

- A unique ID to differentiate it from other NFTs.
- A metadata URI (Uniform Resource Identifier) linking to the metadata for the NFT (which can include things like images, descriptions, etc.).
- The contract will use the ERC721 standard, which is the most widely-used token standard for NFTs. You'll also need to allow users to mint their NFTs, ensuring that each NFT they mint has a unique ID and metadata associated with it.

## Time Allotment: 20 minutes

## Solidity Topics Covered:

- ERC721 Token Standard – Introduction to minting and managing NFTs.
- Mappings – Keeping track of the token ownership.
- URI Metadata – Assigning metadata to NFTs.
- Modifiers – Ensuring only the owner can mint new NFTs.
- Events – Emitting events when NFTs are minted.

## Code Activity:

Initial Contract Template (Incomplete):

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ArtNFT is ERC721URIStorage, Ownable {

    uint256 public tokenIdCounter;

    constructor() ERC721("ArtNFT", "ART") Ownable(msg.sender) ERC721URIStorage() {}

    // 🚩 TODO: Implement minting function to allow users to mint NFTs with metadata URI
    function mint(address to, string memory metadataURI) public onlyOwner {
        uint256 tokenId = tokenIdCounter++;

        // 🚩 TODO: Mint the token and set its URI metadata
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, metadataURI);

        emit Minted(to, tokenId, metadataURI);
    }

    // 🚩 TODO: Implement a function to get the current token ID counter
    function getCurrentTokenId() public view returns (uint256) {
        return tokenIdCounter;
    }

    event Minted(address indexed to, uint256 indexed tokenId, string metadataURI);
}
```

## Checklist for Learners:

- Implemented the mint function to allow minting of unique NFTs with a metadata URI.
- Correctly used the ERC721 standard to mint NFTs.
- Ensured the token ID is unique and incremented correctly.
- Set the metadata URI for each NFT so that it points to the appropriate metadata.
- Emitted the `Minted` event with the correct parameters for transparency.

## Hints:

- ERC721 Contract: Make sure to import the correct ERC721 implementation from OpenZeppelin.
- Token ID: Every NFT must have a unique ID. You can use a counter to increment the token ID for each new mint.
- Metadata URI: Consider how you can link to the metadata using a URI, which can point to a JSON file that contains information about the NFT (such as the image, title, and description).
- Emitting Events: When minting, it's essential to emit events to notify listeners that a new NFT has been minted.

## Expected answer (flagged)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ArtNFT is ERC721URIStorage, Ownable {

    uint256 public tokenIdCounter;

    constructor() ERC721("ArtNFT", "ART") Ownable(msg.sender) ERC721URIStorage() {}

    function mint(address to, string memory metadataURI) public onlyOwner {
        uint256 tokenId = tokenIdCounter++;

        // Mint the token and set its URI metadata
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, metadataURI);

        emit Minted(to, tokenId, metadataURI);
    }

    function getCurrentTokenId() public view returns (uint256) {
        return tokenIdCounter;
    }

    event Minted(address indexed to, uint256 indexed tokenId, string metadataURI);
}
```

## Final thoughts

The creation of **ArtNFTs** is a simple yet powerful way to allow artists to tokenize their artwork. This minting contract ensures that each NFT is unique and can be sold or transferred to other collectors. By using the ERC721 standard, the NFTs can be independently traded and tracked. This is a step towards helping Filipino artists gain exposure in the global NFT space.
