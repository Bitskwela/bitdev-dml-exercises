// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SecureNFT is ERC721URIStorage, Ownable {
    uint256 public totalSupply;
    uint256 public maxSupply = 100;

    constructor() ERC721("SanJuanNFT", "SJN") Ownable(msg.sender) {}

    function mintNFT(
        address recipient,
        string memory tokenURI
    ) public onlyOwner {
        require(totalSupply < maxSupply, "Max NFT supply reached");

        totalSupply++;
        _mint(recipient, totalSupply);
        _setTokenURI(totalSupply, tokenURI);
    }
}
