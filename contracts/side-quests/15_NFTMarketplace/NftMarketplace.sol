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
        require(
            nft.ownerOf(tokenId) == msg.sender,
            "You must be the owner of the NFT."
        );
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
    event NFTListed(
        address indexed seller,
        uint256 indexed tokenId,
        uint256 price
    );

    // Event for purchasing an NFT
    event NFTPurchased(
        address indexed buyer,
        uint256 indexed tokenId,
        uint256 price
    );
}
