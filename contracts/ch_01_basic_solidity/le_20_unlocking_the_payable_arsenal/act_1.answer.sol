// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherReceiver {
    event PaymentReceived(address indexed from, uint256 amount);

    function receivePayment() public payable {
        emit PaymentReceived(msg.sender, msg.value);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
