
## Expected answer (flagged)

```solidity
// 🚩 ANSWER: Ensure caller is the owner
require(msg.sender == owner, "Not the owner");

// 🚩 ANSWER: Enforce max supply limit
require(totalSupply < maxSupply, "Max supply reached");
```
