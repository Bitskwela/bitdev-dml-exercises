## Expected answer (flagged)

```solidity
// 🚩 ANSWER: Deduct balances before external call
balances[msg.sender] -= amount;

// 🚩 ANSWER: Use Checks-Effects-Interactions pattern
(bool success, ) = msg.sender.call{value: amount}("");
require(success, "Transfer failed");

```