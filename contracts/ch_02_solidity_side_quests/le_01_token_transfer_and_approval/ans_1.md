## Expected answers (flagged)

```solidity
// 🚩 ANSWER: Deduct from allowances
allowances[sender][msg.sender] -= amount;

// 🚩 ANSWER: Update sender and recipient balances
balances[sender] -= amount;
balances[recipient] += amount;
```
