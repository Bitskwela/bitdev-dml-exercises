## Smart Contract Activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherReceiver {
    event PaymentReceived(address indexed from, uint256 amount);

    function receivePayment() public {}

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
```

# Task for Learners

- Create a function named `receivePayment` that allows vendors to receive Ether through a `payable` function. Emit a `PaymentReceived` event when Ether is received.

  ```solidity
      function receivePayment() public payable {
          emit PaymentReceived(msg.sender, msg.value);
      }
  ```

### Breakdown of Activity

**Event Declared**:

- `PaymentReceived`: Logs the sender (`msg.sender`) and the Ether amount (`msg.value`) received.

**Payable Function**:

- `receivePayment`:
  - `payable`: Allows the function to accept Ether.
  - `msg.sender` and `msg.value`: Capture the sender’s address and the amount sent.
  - **Event Emission:** Notifies when a payment is received.

**Balance Retrieval Function**:

- `getBalance`: Returns the total Ether stored in the contract.

### Closing Story

Neri smiled as Ether began flowing securely into the hands of hardworking vendors. The tide was turning against Hackana, but the battle was far from over.

Every Ether transaction sent was another blow to centralized exploitation—a victory for decentralization.
