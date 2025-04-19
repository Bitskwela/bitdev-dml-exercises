# Task for Learners

- Implement an ERC1155 token using **OpenZeppelin**.
- Define two token types: one fungible (e.g., "_Gold Coins_") and one non-fungible (e.g., "_Special Artifact_").
- Deploy the contract and test minting and transferring tokens.

## Smart Contract Activity

```solidity
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
```

### Breakdown of the Activity

**Key Features Implemented:**

Tokens Defined:

- GOLD (1): Fungible token representing "Gold Coins".
- ARTIFACT (2): Non-fungible token representing a "Special Artifact".

Initial Minting:

- Mints _1000 Gold Coins_ and _1 Special Artifact_ to the contract owner.

Mint Function:

- Allows the owner to mint additional tokens of any type.

### Closing Story

As Neri and her team deploy the ERC1155-based contract, Hackana's attempts to destabilize multi-purpose digital assets fail spectacularly. The versatility and efficiency of _ERC1155_ prove to be a decisive advantage.

In the aftermath, the blockchain infrastructure is stronger than ever, inspiring a new generation of developers to build creative applications on Ethereum.
