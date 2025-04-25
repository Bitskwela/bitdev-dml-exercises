// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherReceiver {
    // Event to log Ether receipt
    event PaymentReceived(address indexed from, uint256 amount);

    // 🚩 TODO: Task 1 - Create a payable function to accept Ether
    function receivePayment() public payable {
        // 🚩 ✅ Answer: Emit the PaymentReceived event
        emit PaymentReceived(msg.sender, msg.value);
    }

    // Function to check contract balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
