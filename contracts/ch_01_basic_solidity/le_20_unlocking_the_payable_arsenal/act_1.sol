// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherReceiver {
    event PaymentReceived(address indexed from, uint256 amount);

    function receivePayment() public {}

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
