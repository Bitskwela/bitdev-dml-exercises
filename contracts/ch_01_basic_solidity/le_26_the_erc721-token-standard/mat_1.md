# The ERC-721 Token Standard

## Scene

Neri's mission against Hackana leads her to an art fair in Metro Manila showcasing digital artworks. Many artists are distraught because their creations have been stolen or duplicated without consent.

Neri realizes the importance of protecting digital assets. Inspired by her previous blockchain knowledge, she decides to explore ERC721, a standard for creating Non-Fungible Tokens (NFTs), to safeguard ownership and authenticity.

She recalls that NFTs are unique tokens representing distinct items like art, music, collectibles, and real estate. Neri believes ERC721 can empower artists by providing immutable proof of ownership and enabling secure transactions.

### Solidity Topic: ERC-721 Standard

**ERC721** is a standard for creating non-fungible tokens (NFTs) on the Ethereum blockchain. Unlike ERC20 tokens, which are fungible and identical, ERC721 tokens are unique, with each having a specific tokenId. It is perfect for applications requiring distinct ownership, such as digital art, real estate, or identity.

### Key Features of ERC721:

- **Uniqueness**: Each token has a unique ID (tokenId) and cannot be interchanged with another.
- **Ownership**: Includes functions to transfer, approve, and query ownership of tokens.
- **Metadata**: Tokens can hold additional data, such as artwork descriptions or links to images.

### Common Functions:

- `balanceOf(address owner)`: Returns the number of tokens owned by a specific address.
- `ownerOf(uint256 tokenId)`: Returns the owner of a specific token.
- `transferFrom(address from, address to, uint256 tokenId)`: Transfers token ownership.
- `approve(address to, uint256 tokenId)`: Approves another address to transfer a specific token.
- `safeTransferFrom(address from, address to, uint256 tokenId)`: Safely transfers token ownership, ensuring compatibility with smart contracts.

### Example Syntax for ERC721 Usage

**Declaring ERC721 Contract:**

```solidity
contract MyNFT is ERC721 {
    constructor() ERC721("MyNFT", "MNFT") {}
}
```

**Minting a token:**

```solidity
function mint(address recipient, uint256 tokenId) public {
    _mint(recipient, tokenId);
}
```

**Checking Token Ownership:**

```solidity
function getOwner(uint256 tokenId) public view returns (address) {
    return ownerOf(tokenId);
}
```
