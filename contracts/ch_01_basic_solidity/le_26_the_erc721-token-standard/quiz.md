# ERC-721 Token Standard Quiz

Welcome to Neri's NFT adventure! Test your understanding of ERC-721 tokens and their role in the battle against Hackana.

---

### 1. What makes ERC-721 tokens different from ERC-20 tokens?

A) They are always fungible and identical

B) Each token is unique and has its own `tokenId`

C) They cannot be transferred

D) They are only used for voting

**Answer:** B

_Explanation: ERC-721 tokens are non-fungible, meaning each token is unique and identified by a `tokenId`._

---

### 2. What does the following function do?

```solidity
function awardItem(address player, string memory tokenURI) public returns (uint256) {
    _tokenIds.increment();
    uint256 newItemId = _tokenIds.current();
    _mint(player, newItemId);
    _setTokenURI(newItemId, tokenURI);
    return newItemId;
}
```

A) Transfers ETH to the player

B) Mints a new NFT and assigns it to the player

C) Deletes an NFT

D) Changes the contract owner

**Answer:** B

_Explanation: This function mints a new ERC-721 token and assigns it to the specified address._

---

### 3. Which event is emitted when an ERC-721 token is transferred?

A) Approval

B) Transfer

C) Mint

D) OwnershipChanged

**Answer:** B

_Explanation: The `Transfer` event is emitted whenever an ERC-721 token is transferred._

---

### 4. Why is it important to check for ownership before allowing a transfer in ERC-721?

A) To prevent duplicate tokens

B) To ensure only the owner or approved address can transfer the token

C) To save gas

D) To allow anyone to transfer any token

**Answer:** B

_Explanation: Only the owner or an approved address should be able to transfer a token to prevent unauthorized transfers._

---

Great job! Neri is one step closer to mastering NFTs and defending against Hackana's tricks!
