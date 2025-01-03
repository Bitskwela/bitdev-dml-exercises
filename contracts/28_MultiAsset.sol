// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import OpenZeppelin's ERC1155 implementation
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MultiAsset is ERC1155, Ownable {
    // Token IDs
    uint256 public constant GOLD = 1; // Fungible token
    uint256 public constant ARTIFACT = 2; // Non-fungible token

    constructor()
        ERC1155("https://api.example.com/metadata/{id}.json")
        Ownable(msg.sender)
    {
        // 🚩 TODO: Mint initial tokens to the contract owner
        _mint(msg.sender, GOLD, 1000, ""); // Mint 1000 Gold Coins
        _mint(msg.sender, ARTIFACT, 1, ""); // Mint 1 Special Artifact
    }

    // Function to mint new tokens
    function mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public onlyOwner {
        _mint(to, id, amount, data);
    }
}
