# ERC1155 Token Standard Quiz

Neri needs to manage many items to fight Hackana! Test your knowledge of the ERC1155 multi-token standard.

---

### 1. What is the main feature of ERC1155 compared to ERC-20 and ERC-721?

A) It only supports fungible tokens

B) It allows managing multiple token types in one contract

C) It cannot batch transfer tokens

D) It is less secure

**Answer:** B

_Explanation: ERC1155 can manage both fungible and non-fungible tokens in a single contract._

---

### 2. What does the following function do in an ERC1155 contract?

```solidity
function safeBatchTransferFrom(
    address from,
    address to,
    uint256[] memory ids,
    uint256[] memory amounts,
    bytes memory data
) public {
    // ...transfer logic...
}
```

A) Transfers one token at a time

B) Transfers multiple tokens in a single transaction

C) Deletes tokens

D) Mints new tokens

**Answer:** B

_Explanation: The function allows batch transfer of multiple token types and amounts._

---

### 3. Why is batch transfer useful in games or collectibles?

A) It increases gas costs

B) It allows sending many items at once, saving gas

C) It prevents transfers

D) It is only for admins

**Answer:** B

_Explanation: Batch transfers save gas and make it easier to send multiple items in one transaction._

---

### 4. In Neri's quest, how does ERC1155 help her defend against Hackana's chaos?

A) By making contracts more complex

B) By allowing efficient management of many items and powers

C) By disabling transfers

D) By hiding items

**Answer:** B

_Explanation: ERC1155 lets Neri manage many items and powers efficiently, strengthening her defenses._

---

Awesome! Neri can now use ERC1155 to organize her arsenal against Hackana.
