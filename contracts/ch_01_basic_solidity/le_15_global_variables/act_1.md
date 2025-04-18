# Tasks for learners

Help Neri prepare her transaction tracker by:

- Using `msg.sender` to log the caller’s address.

- Using `block.timestamp` to log when a suspicious activity occurs.

## Smart contract activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TransactionTracker {
    // 🚩 Task 1: Declare state variables to store caller address and transaction time
    address public caller;
    uint256 public transactionTime;

    // 🚩 Task 2: Function to log caller address and timestamp
    function logTransaction() public {
        // Store the caller's address and current block timestamp
        caller = msg.sender; // Global variable to get the function caller's address
        transactionTime = block.timestamp; // Global variable for the current block's timestamp
    }
}
```

### Breakdown of Activity

**Global Variables Used:**

`msg.sender`: Tracks the function caller’s address.

`block.timestamp`: Records the block’s timestamp when the function is executed.

**State Variables Defined:**

`caller`: Stores the address of the caller.

`transactionTime`: Holds the timestamp of the transaction.

**Function Logic:**

`logTransaction`:

- **Purpose**: Logs the caller's address and the time when the function is called.

- **Key Steps**:
  - `msg.sender`: Assigns the caller’s address to caller.
  - `block.timestamp`: Assigns the current time to `transactionTime`.

### Closing Story

As Neri develops the TransactionTracker, she sets it up on her laptop and integrates it with the community's blockchain network.

"**Sa tulong ng contract na ito, makikita agad natin ang mga galaw ni Hackana!**"

(_With this contract, we can immediately see Hackana’s moves!_)

The barangay officials cheer as they watch the contract in action, tracking live transactions on the blockchain.

Meanwhile, Hackana, monitoring the situation, smirks and types furiously:
"**Interesting. Let’s see if you can keep up with me, Neri.**"

The battle is getting closer, and Neri knows the next move will require sharp skills and innovative solutions.
