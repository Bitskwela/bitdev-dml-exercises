# Sidequest #15: NFT Marketplace - Fight Against Hackana's Remnants

## Backstory:

After the defeat of Hackana, Neri believed that the blockchain world was finally safe from its corrupting influence. However, remnants of Hackana's minions still linger in the system, hiding within decentralized applications (dApps), trying to disrupt the integrity of the growing Web3 economy. As the demand for NFTs grows, more and more creators are struggling to find safe and reliable platforms to sell their artwork.

In response, Neri decides to build a decentralized NFT marketplace where users can securely list, buy, and sell NFTs without fear of malicious activities. However, Hackana's remnants are still lurking and continue to exploit weak contract structures to steal funds and disrupt transactions.

To defend against these threats, Neri must ensure the marketplace is secure, transparent, and resistant to any manipulation from Hackana's minions. With this in mind, Neri starts developing an NFT marketplace with smart contracts to handle listing, buying, and selling securely, while still remaining decentralized and accessible to everyone.

## Problem Overview:

Your task is to build a decentralized NFT marketplace that can:

- List NFTs.
- Allow users to purchase listed NFTs.
- Ensure the integrity of transactions, including payment and token transfer.
- Protect against attacks from Hackana's remnants by building secure smart contracts.
- You will implement the core functionality of a marketplace with an ERC721 token standard for NFTs and a payment system for buyers.

## Time Allotment: 20 minutes

## Solidity Topics Covered:

- ERC721 Tokens – Create and interact with NFTs using the ERC721 standard.
- Marketplace Logic – Implement a basic marketplace to buy and sell NFTs.
- Secure Payment Handling – Use Solidity features to safely handle token transactions.
- Event Handling – Emit events for listing and purchasing NFTs.
- Modifiers and Security – Implement modifiers to handle ownership and prevent unauthorized actions.

## Code Activity:

Initial Contract Template

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract NFTMarketplace {

    using SafeMath for uint256;

    // 🚩 Define struct to hold NFT listings
    struct Listing {
        uint256 tokenId;
        address seller;
        uint256 price;
    }

    // 🚩 Define mapping to hold the active listings
    mapping(uint256 => Listing) public listings;

    // ERC721 token interface
    IERC721 public nft;

    constructor(address nftAddress) {
        nft = IERC721(nftAddress);
    }

    // 🚩 TODO: Create a function to list an NFT for sale
    function listNFT(uint256 tokenId, uint256 price) public {
        // 🚩 Ensure the sender is the owner of the NFT
        // 🚩 Ensure the price is greater than 0
        // 🚩 Transfer the NFT to the marketplace contract
        // 🚩 Store the listing in the listings mapping
        // 🚩 Emit an event for listing the NFT
    }

    // 🚩 TODO: Create a function to buy an NFT from the marketplace
    function buyNFT(uint256 tokenId) public payable {
        // 🚩 Ensure the listing exists and is active
        // 🚩 Ensure the buyer is sending enough funds
        // 🚩 Transfer the payment to the seller
        // 🚩 Transfer the NFT to the buyer
        // 🚩 Emit an event for the purchase of the NFT
    }

    // 🚩 TODO: Create an event for listing and purchasing NFTs
    event NFTListed(address indexed seller, uint256 indexed tokenId, uint256 price);
    event NFTPurchased(address indexed buyer, uint256 indexed tokenId, uint256 price);
}
```

## Checklist for Learners:

- [ ] Implemented a Listing struct to store information about listed NFTs.
- [ ] Used the IERC721 interface to handle NFT transfers.
- [ ] Added a modifier to ensure that only the NFT owner can list an NFT.
- [ ] Created a listNFT function to list NFTs for sale, transferring the token to the marketplace contract.
- [ ] Created a buyNFT function to allow buyers to purchase NFTs using Ether, transferring the token and funds correctly.
- [ ] Emitted NFTListed and NFTPurchased events for transparency and tracking.
- [ ] Ensured that the marketplace contract is secure against potential attacks by validating inputs and performing necessary checks.

## Hints :P

- Listing an NFT: Use the transferFrom function of the IERC721 interface to move the NFT from the seller to the marketplace contract.
- Buying an NFT: Ensure that the buyer sends enough Ether to cover the price of the NFT, and transfer the payment to the seller securely.
- Security: Implement necessary checks like ensuring the price is greater than zero and that only the token owner can list it.
- Events: Emitting events like NFTListed and NFTPurchased is important for tracking actions in a transparent manner.

## Expected answer (flagged)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract NFTMarketplace {

    using SafeMath for uint256;

    // Struct to hold the NFT listing details
    struct Listing {
        uint256 tokenId;
        address seller;
        uint256 price;
    }

    // Mapping to store the active listings by tokenId
    mapping(uint256 => Listing) public listings;

    IERC721 public nft;

    constructor(address nftAddress) {
        nft = IERC721(nftAddress);
    }

    modifier onlyOwner(uint256 tokenId) {
        require(nft.ownerOf(tokenId) == msg.sender, "You must be the owner of the NFT.");
        _;
    }

    // Function to list an NFT for sale
    function listNFT(uint256 tokenId, uint256 price) public onlyOwner(tokenId) {
        require(price > 0, "Price must be greater than zero.");

        // Transfer NFT to the marketplace contract
        nft.transferFrom(msg.sender, address(this), tokenId);

        // Store the listing
        listings[tokenId] = Listing(tokenId, msg.sender, price);

        emit NFTListed(msg.sender, tokenId, price);
    }

    // Function to buy an NFT from the marketplace
    function buyNFT(uint256 tokenId) public payable {
        Listing memory listing = listings[tokenId];
        require(listing.price > 0, "NFT is not listed for sale.");
        require(msg.value >= listing.price, "Insufficient funds.");

        // Transfer payment to the seller
        payable(listing.seller).transfer(listing.price);

        // Transfer NFT to the buyer
        nft.transferFrom(address(this), msg.sender, tokenId);

        // Remove listing after sale
        delete listings[tokenId];

        emit NFTPurchased(msg.sender, tokenId, listing.price);
    }

    // Event for listing an NFT
    event NFTListed(address indexed seller, uint256 indexed tokenId, uint256 price);

    // Event for purchasing an NFT
    event NFTPurchased(address indexed buyer, uint256 indexed tokenId, uint256 price);
}
```

## Final thoughts

In this activity, you’ll implement a decentralized NFT marketplace where users can list, buy, and sell NFTs securely. The contract ensures that the integrity of transactions is maintained, and only the owner of the NFT can list it for sale. Buyers can securely purchase the NFT by sending Ether, which is transferred to the seller, and the NFT is transferred to the buyer. The contract uses Solidity’s `IERC721` interface to interact with NFTs, ensuring that the marketplace is fully functional and secure.
