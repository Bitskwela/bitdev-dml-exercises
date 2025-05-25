// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PalengkePay {
    string public vendorName;

    uint256 public totalPayments;

    string public payerName;

    function recordPayment(
        string memory _vendorName,
        uint256 _amount,
        string memory _payee
    ) public {
        vendorName = _vendorName;
        totalPayments = _amount;
        payerName = _payee;
    }
}
