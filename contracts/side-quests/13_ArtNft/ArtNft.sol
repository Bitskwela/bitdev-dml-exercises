// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ArtNFT is ERC721URIStorage, Ownable {
    uint256 public tokenIdCounter;

    constructor()
        ERC721("ArtNFT", "ART")
        Ownable(msg.sender)
        ERC721URIStorage()
    {}

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

    event Minted(
        address indexed to,
        uint256 indexed tokenId,
        string metadataURI
    );
}
