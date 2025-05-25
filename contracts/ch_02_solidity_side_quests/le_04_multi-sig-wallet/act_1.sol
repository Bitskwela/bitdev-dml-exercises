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

    // TODO: Add a transaction proposal method
    function proposeTransaction(address _to, uint256 _value) public {
        // Only signers should be able to propose
        // Push to the transactions array
    }

    // TODO: Allow signers to approve transactions
    function approveTransaction(uint256 txId) public {
        // Only signers should approve
        // Track approval and increment counter
    }

    // TODO: Execute when enough approvals are met
    function executeTransaction(uint256 txId) public {
        // Check if approvalThreshold is met and execute
    }

    receive() external payable {}
}
