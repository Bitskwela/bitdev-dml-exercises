// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultiSigWallet {
    address[] public signers;
    uint256 public approvalThreshold;

    mapping(address => bool) public isSigner;

    struct Transaction {
        address to;
        uint256 value;
        uint256 approvals;
        bool executed;
    }

    Transaction[] public transactions;
    mapping(uint256 => mapping(address => bool)) public approved;

    constructor(address[] memory _signers, uint256 _threshold) {
        require(_threshold <= _signers.length, "Threshold too high");

        for (uint256 i = 0; i < _signers.length; i++) {
            isSigner[_signers[i]] = true;
        }

        signers = _signers;
        approvalThreshold = _threshold;
    }

    function proposeTransaction(address _to, uint256 _value) public {
        require(isSigner[msg.sender], "Not authorized");
        transactions.push(
            Transaction({to: _to, value: _value, approvals: 0, executed: false})
        );
    }

    function approveTransaction(uint256 txId) public {
        require(isSigner[msg.sender], "Not authorized");
        require(!approved[txId][msg.sender], "Already approved");
        require(!transactions[txId].executed, "Already executed");

        approved[txId][msg.sender] = true;
        transactions[txId].approvals++;
    }

    function executeTransaction(uint256 txId) public {
        Transaction storage txn = transactions[txId];
        require(!txn.executed, "Already executed");
        require(txn.approvals >= approvalThreshold, "Not enough approvals");

        txn.executed = true;
        (bool success, ) = txn.to.call{value: txn.value}("");
        require(success, "Transaction failed");
    }

    receive() external payable {}
}
