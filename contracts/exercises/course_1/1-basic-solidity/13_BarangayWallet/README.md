# Fallback and Receive Functions – Handling Unexpected Situations

## Scene

Neri is making great strides in implementing blockchain for public projects. One day, while visiting the Barangay Tech Fair, she encounters an unusual situation. A local programmer approaches her and says:

**“Neri, paano kapag ang smart contract ko nakatanggap ng funds nang walang tinawag na function? Paano ‘yun hahandle?”** (_Neri, what if my smart contract receives funds without a function being explicitly called? How do I handle that?_)

Neri realizes this is a perfect opportunity to explain the fallback and receive functions in Solidity. These functions act as a safety net, ensuring contracts can handle unexpected transactions or interactions.

## Solidity Topics: Fallback and Receive functions

### Overview

Fallback and receive functions are special functions in Solidity designed for handling unexpected situations:

**Receive Function**

- Triggered when a contract receives Ether directly (e.g., via `send` or `transfer`) without any data.
- Declared using `receive()` external payable.
- Can only handle Ether transactions, no additional logic.

**Fallback Function**

- Triggered when a contract receives a call to a function that doesn’t exist.
- Declared using `fallback()` `external`.
- Handles both Ether transfers (if payable) and invalid function calls.

### Example

```solidity
contract Example {
    // Handles direct Ether transfer
    receive() external payable {}

    // Handles unexpected or invalid calls
    fallback() external payable {}
}
```

### How to use Fallback and Receive functions

**Receive Ether**

If someone sends Ether to a contract without calling a function, the `receive()` function is triggered automatically.

**Example:**

    ```solidity
    receive() external payable { // Add Ether received to a variable }
    ```

**Handle Invalid Calls**

When a function that doesn’t exist is called, the `fallback()` function is triggered.

**Example:**

```solidity
    fallback() external {
        // Log invalid call inside this function
    }
```

### Task for Learners

- Add a receive function to handle Ether transfers
- Add a fallback function to log invalid calls to the smart contract

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
