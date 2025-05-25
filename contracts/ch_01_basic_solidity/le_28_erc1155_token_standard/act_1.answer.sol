// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MultiAsset is ERC1155, Ownable {
    uint256 public constant GOLD = 1; // Fungible token
    uint256 public constant ARTIFACT = 2; // Non-fungible token

    constructor()
        ERC1155("https://api.example.com/metadata/{id}.json")
        Ownable(msg.sender)
    {
        _mint(msg.sender, GOLD, 1000, ""); // Mint 1000 Gold Coins
        _mint(msg.sender, ARTIFACT, 1, ""); // Mint 1 Special Artifact
    }

    function mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public onlyOwner {
        _mint(to, id, amount, data);
    }
}
