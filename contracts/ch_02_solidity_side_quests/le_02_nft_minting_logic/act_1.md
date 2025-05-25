# Smart contract activity:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SecureNFT is ERC721URIStorage, Ownable {
    uint256 public totalSupply;
    uint256 public maxSupply = 100;

    constructor() ERC721("SanJuanNFT", "SJN") Ownable(msg.sender) {}

    function mintNFT() public {}
}
```

## Tasks for students

- Import OpenZeppelin's `Ownable` contract to manage ownership and `ERC721URIStorage`.

  ```solidity
  import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
  import "@openzeppelin/contracts/access/Ownable.sol";
  ```

- Implement the `mintNFT` function to:

  - Ensure only the owner can mint NFTs.
  - Check that the total supply does not exceed `maxSupply` and use `require` statements to enforce these conditions.

    ```solidity
    function mintNFT(address recipient, string memory tokenURI) public onlyOwner {
        require(totalSupply < maxSupply, "Max NFT supply reached");
        totalSupply++;
        _mint(recipient, totalSupply);
        _setTokenURI(totalSupply, tokenURI);
    }
    ```
