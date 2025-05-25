# Smart contract activity:

```solidity
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

    event LoanRequested(uint256 loanId, address borrower, uint256 amount, string reason);
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
```

**Time Allotment: 1 hour**

## Tasks for students

- Finish the `requestLoan` function to:

  - Create a new `LoanRequest` struct.
  - Store it in the `loans` mapping using `loanCounter` as the key.
  - Emit the `LoanRequested` event.

  ```solidity
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
  ```

- Complete the `fundLoan` function to:

  - Check if the loan exists and is not already funded.
  - Transfer the specified amount to the borrower.
  - Mark the loan as funded and record the lender's address.
  - Emit the `LoanFunded` event.

  ```solidity
  function fundLoan(uint256 loanId) public payable {
      LoanRequest storage loan = loans[loanId];

      require(!loan.isFunded, "Loan already funded");
      require(msg.value == loan.amount, "Incorrect amount");

      loan.isFunded = true;
      loan.lender = msg.sender;

      payable(loan.borrower).transfer(msg.value);
      emit LoanFunded(loanId, msg.sender);
  }
  ```
