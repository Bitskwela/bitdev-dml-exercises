// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SecureNFT {
    uint256 public totalSupply;
    uint256 public maxSupply = 100; // Max NFTs
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // 🚩 TODO: Create a modifier to check msg.sender
    // 🚩 TODO: Restrict minting to owner and check max supply
    function mintNFT() public {
        totalSupply++;
    }
}
