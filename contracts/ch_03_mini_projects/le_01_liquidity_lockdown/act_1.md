# Smart contract activity:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LiquidityLocker {
    address public owner;
    uint256 public lockEnd;
    mapping(address => uint256) public deposits;

    constructor() {
        owner = msg.sender;
    }

    function deposit() external payable {
    }

    function withdraw() external {
    }
}
```

**Time Allotment: 45 minutes**

## Tasks for students

Topics Covered: Time-locking, mappings, Ether transfers, security checks

- Update the `deposit` function to:

  - Accept Ether deposits and store the amount in the `deposits` mapping to track user deposits.
  - Allow setting a lock period. (on this case, its 60 seconds). A deposit must be locked for a certain amount of time. User can’t withdraw until that time has passed. This prevents early exits and simulates a liquidity lock in a DeFi pool.

  ```solidity
  function deposit() external payable {
      require(msg.value > 0, "Must send Ether");
      deposits[msg.sender] += msg.value;
      lockEnd = block.timestamp + 60; // Lock for 60 seconds
  }
  ```

- Update the `withdraw` function to:

  - Allow withdrawals only after the lock period has expired. Use `require` statements to enforce these conditions. A user shouldn't be able to withdraw before the lockEnd. Your smart contract must enforce this through `require` checks.
  - After lock time, send the user’s funds back securely and reset their state. Avoid double withdrawals or reentrancy bugs.

  ```solidity
  function withdraw() external {
    require(block.timestamp >= lockEnd, "Still locked");
    uint256 amount = deposits[msg.sender];
    require(amount > 0, "No funds");
    deposits[msg.sender] = 0;
    payable(msg.sender).transfer(amount);
  }
  ```
