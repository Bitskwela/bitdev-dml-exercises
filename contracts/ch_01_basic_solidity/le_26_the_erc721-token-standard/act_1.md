# Smart Contract Activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DigitalArtToken {
    uint256 private _tokenIds;
}
```

## Task for Learners

- Import the necessary OpenZeppelin libraries for ERC721, ERC721URIStorage and Ownable.
  ```solidity
  import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
  import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
  import "@openzeppelin/contracts/access/Ownable.sol";
  ```
- Create a contract named `DigitalArtToken` that inherits from `ERC721URIStorage` and `Ownable`. And initialize the contract with a name (_DigitalArtToken_) and symbol (_DAT_).

  ```solidity
   contract DigitalArtToken is ERC721URIStorage, Ownable {
    constructor() ERC721("DigitalArtToken", "DAT") Ownable(msg.sender) {}
   }
  ```

- Implement a function `mintArt` that allows the owner to mint a new token. This function should:

  - Accept the recipient's address and a metadata URI.
  - Generate a unique token ID.
  - Mint the token and link it to the provided metadata URI.

  ```solidity
  function mintArt(
      address recipient,
      string memory tokenURI
  ) public onlyOwner returns (uint256) {
      _tokenIds++;
      uint256 newItemId = _tokenIds;

      _mint(recipient, newItemId);
      _setTokenURI(newItemId, tokenURI);

      return newItemId;
  }
  ```

### Breakdown of Activity

**Imported Libraries:**

- **ERC721**: Implements the ERC721 standard.
- **ERC721URIStorage**: Adds functionality to store metadata for tokens.
- **Ownable**: Restricts specific actions to the contract owner.

**Variables Defined:**

`_tokenIds`: Tracks the current token ID.

**Constructor:**

Sets the name (**DigitalArtToken**) and symbol (**DAT**) of the NFT.

**Minting Function:**

`mintArt`:

- Accepts the recipient's address and metadata URI.
- Generates a unique `tokenId`.
- Mints the token and links it to the provided metadata.

**Access Control:**

Uses `onlyOwner` to ensure only the contract owner can mint tokens.

### Closing Story

With her ERC721 contract, Neri demonstrates how digital artists can mint NFTs to represent their work. She sets up workshops to teach the art community about tokenization.

Artists begin minting their creations, selling them globally, and earning royalties securely. The buzz spreads, and Hackana realizes that disrupting this decentralized system will not be easy.

Neri prepares for the next phase of her mission: empowering citizens to adopt blockchain technology in daily life while fortifying defenses against Hackana’s schemes.
