// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PalengkeTransactions {
    function recordPayment() public {}

    function getTotalPayments() public view returns (uint256) {}

    function getPayment(uint256 _index) public view returns (uint256) {}
}
