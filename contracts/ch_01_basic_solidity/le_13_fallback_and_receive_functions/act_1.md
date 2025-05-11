### Smart Contract Activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayWallet {
    // 🚩 Task 1: State variable to track total Ether received
    uint256 public totalReceived;

    // 🚩 Task 2: Receive function to handle direct Ether transfers
    receive() external payable {
        totalReceived += msg.value;
    }

    // 🚩 Task 3: Fallback function to handle invalid calls
    fallback() external payable {
        // Log invalid calls
        emit InvalidCall(msg.sender, msg.value, msg.data);
    }

    // Event for logging fallback activity
    event InvalidCall(address sender, uint256 value, bytes data);
}
```

# Task for Learners

- Add a state variable to track the total Ether received by the contract named `totalReceived`.

```solidity
    uint256 public totalReceived;
```

- Create and event named `InvalidCall` to log invalid calls to the smart contract. It should include the following parameters:
  - `address sender`: The address of the sender.
  - `uint256 value`: The amount of Ether sent.
  - `bytes data`: The raw calldata of the function call.

```solidity
    event InvalidCall(address sender, uint256 value, bytes data);
```

- Add a receive function to handle Ether transfers

```solidity
    receive() external payable {
        totalReceived += msg.value;
    }
```

- Add a fallback function to log invalid calls to the smart contract and emit the `InvalidCall` event.

```solidity
    fallback() external payable {
        emit InvalidCall(msg.sender, msg.value, msg.data);
    }
```

### Breakdown of Activity

**State Variable Defined:**

`totalReceived`: Tracks the total Ether received by the contract.

**Receive Function:**

- Purpose: Accepts Ether sent directly to the contract without any data.
- Logic: Adds the amount sent (`msg.value`) to the `totalReceived` state variable.

**Fallback Function:**

Purpose: Handles invalid function calls or Ether transfers with data.
Logic: Emits an event to log the sender, value, and calldata of the invalid call.

**Event Declared:**

```solidity
InvalidCall(address sender, uint256 value, bytes data);
```

Logs the sender address, amount of Ether sent, and the raw calldata.

### Closing Story

During the Tech Fair, Neri demonstrates a Barangay Wallet smart contract. When attendees send Ether directly to the contract, the receive function tracks the funds. If they try calling non-existent functions, the fallback function logs the action.

The crowd cheers as Neri explains:
**“Ang blockchain ay parang guardya—lagi kang may planong pang-backup sa kahit anong posibleng mangyari.”**

(_Blockchain is like a guard—always prepared with a backup plan for anything that might happen._)

Neri’s next mission? Helping the barangay distribute ayuda funds through transparent mechanisms!
