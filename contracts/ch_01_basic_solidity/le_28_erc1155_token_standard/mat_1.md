# ERC1155 Token Standard

## Scene

The final stage of Neri's quest against Hackana has begun. Hackana deploys its most sophisticated malware, targeting multi-purpose digital assets like gaming collectibles and resource tokens.

To counter this, Neri introduces her team to the ERC1155 token standard, known for its versatility in handling multiple types of assets within a single smart contract.

This innovation empowers Neri's team to build highly efficient contracts that defend against Hackana while enabling seamless operations for digital assets in various applications.

## Solidity Topic: ERC1155 Token Standard

ERC1155 is a multi-token standard that allows a single contract to manage multiple types of fungible, non-fungible, or semi-fungible tokens. Unlike ERC20 and ERC721, ERC1155 is more gas-efficient when managing bulk token transfers.

### Key Features of ERC1155

- Batch Transfers: Transfer multiple token types in a single transaction, saving gas.
- Dual Purpose: Support fungible, non-fungible, and semi-fungible tokens.
- Flexible Metadata: Provides standardized metadata for tokens.

### Example Syntax for ERC1155:

```solidity
// Declaring an ERC1155 contract
contract ExampleERC1155 is ERC1155 {
    constructor() ERC1155("https://example.com/metadata/{id}.json") {}

    // Minting tokens
    function mint(address to, uint256 id, uint256 amount) public {
        _mint(to, id, amount, "");
    }
}
```
