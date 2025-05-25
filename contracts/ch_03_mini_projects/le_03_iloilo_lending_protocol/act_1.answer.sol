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

    function requestLoan(uint256 amount, string memory reason) public {
        loanCounter++;
        loans[loanCounter] = LoanRequest({
            borrower: msg.sender,
            amount: amount,
            reason: reason,
            isFunded: false,
            lender: address(0)
        });

        emit LoanRequested(loanCounter, msg.sender, amount, reason);
    }

    function fundLoan(uint256 loanId) public payable {
        LoanRequest storage loan = loans[loanId];

        require(!loan.isFunded, "Loan already funded");
        require(msg.value == loan.amount, "Incorrect amount");

        loan.isFunded = true;
        loan.lender = msg.sender;

        payable(loan.borrower).transfer(msg.value);
        emit LoanFunded(loanId, msg.sender);
    }
}
