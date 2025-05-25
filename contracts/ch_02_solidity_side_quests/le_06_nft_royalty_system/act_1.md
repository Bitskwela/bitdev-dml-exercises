# Smart contract activity:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NFTWithRoyalties {
    address public creator;
    uint256 public royaltyPercentage; // e.g., 10 for 10%
    address public currentOwner;

    constructor(address _creator, uint256 _percentage) {
        creator = _creator;
        royaltyPercentage = _percentage;
        currentOwner = _creator;
    }

    function transferNFT(address buyer, uint256 salePrice) public payable {
        require(msg.value == salePrice, "Incorrect payment amount");

        // Deduct royalty and transfer to creator
        // Transfer royalty to creator
        // Send remaining amount to current owner
        // Transfer ownership to buyer
   }
}
```

## Tasks for students:

- Inside the `transferNFT` function, deduct royalty from the sale price.

  ```solidity
  uint256 royalty = (salePrice * royaltyPercentage) / 100;
  ```

- Transfer royalty to the creator.

  ```solidity
  payable(creator).transfer(royalty);
  ```

- Send the remaining amount to the current owner.

  ```solidity
  uint256 sellerAmount = salePrice - royalty;
  payable(currentOwner).transfer(sellerAmount);
  ```

- Transfer ownership to the buyer.

  ```solidity
  currentOwner = buyer;
  ```

### Explanation

- `royalty = (salePrice * royaltyPercentage) / 100`: calculates the correct cut for the original creator.

- `transfer()`: safely sends ETH to both the creator and seller.

Ownership is updated to the new buyer once payment is settled.

This logic assumes that every sale is paid in ETH (via `msg.value`) and does not use ERC721 interfaces — making it perfect for learners to understand manual royalty management without full ERC721 complexity yet.
