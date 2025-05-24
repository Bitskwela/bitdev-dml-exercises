# Smart Contract Activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultiAsset {
    uint256 public constant GOLD = 1; // Fungible token
    uint256 public constant ARTIFACT = 2; // Non-fungible token
}
```

## Task for Learners

- Import the necessary OpenZeppelin libraries for ERC1155 and Ownable.

  ```solidity
  import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
  import "@openzeppelin/contracts/access/Ownable.sol";
  ```

- Create a contract named `MultiAsset` that inherits from `ERC1155` and `Ownable`.

- Build the constructor to initialize the contract with a base URI for metadata and mint an initial supply of tokens:

  - Mint _1000 Gold Coins_ (fungible token).
  - Mint _1 Special Artifact_ (non-fungible token).
  - Point the base URI to a metadata API endpoint: https://api.example.com/metadata/{id}.json

  ```solidity
      constructor()
          ERC1155("https://api.bitskwela.com/metadata/{id}.json")
          Ownable(msg.sender)
      {
          _mint(msg.sender, GOLD, 1000, ""); // Mint 1000 Gold Coins
          _mint(msg.sender, ARTIFACT, 1, ""); // Mint 1 Special Artifact
      }
  ```

- Implement a `mint` function that allows the owner to mint additional tokens of any type.

  ```solidity
      function mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public onlyOwner {
        _mint(to, id, amount, data);
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
