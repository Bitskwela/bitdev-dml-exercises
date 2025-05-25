// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayLending {
    struct LoanRequest {
        address borrower;
        uint256 amount;
        string reason;
        bool isFunded;
        address lender;
    }

    uint256 public loanCounter;
    mapping(uint256 => LoanRequest) public loans;

    event LoanRequested(
        uint256 loanId,
        address borrower,
        uint256 amount,
        string reason
    );
    event LoanFunded(uint256 loanId, address lender);

    // Request a new loan
    function requestLoan(uint256 amount, string memory reason) public {
        // TODO: Create a new loan request and store it in the mapping
    }

    // Fund a loan
    function fundLoan(uint256 loanId) public payable {
        // TODO: Check if loan exists and isn't already funded
        // TODO: Transfer the loan amount to borrower
        // TODO: Mark as funded and record lender
    }
}
