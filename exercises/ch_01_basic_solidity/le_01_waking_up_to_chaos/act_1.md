# Activity

Build your first Solidity Smart Contract
Let’s build a contract for Neri's imaginary "**PalengkePay**" system to keep track of vendors’ names and payment amounts.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Define a contract named PalengkePay
contract PalengkePay {
    // State variable to store vendor name
    string public vendorName;

    // State variable to store the total payment amount
    uint256 public totalPayments;

    1. Create a public string variable here named "payerName"

    // Function to set vendor details and payment
    function recordPayment(string memory _vendorName, uint256 _amount) public {
        vendorName =e _vendorName; // Set the vendor's name
        totalPayments = _amount; // Update the total payments

    2. Assign _vendorName to payerName variable

    }
}
```

### Task for Students

- Add a new state variable (`payerName`) to store the payer's name.

  ```solidity
  string public payerName;
  ```

- Update the `recordPayment` function to assign `_vendorName` as new value of `payerName` public variable.

  ```solidity
  function recordPayment(
        string memory _vendorName,
        uint256 _amount,
        string memory _payee
    ) public {
        vendorName = _vendorName;
        totalPayments = _amount;
        payerName = _payee;
    }
  ```

- Compile and Deploy: Test the updated contract in IDE.
- Interact with the Contract: Use the `recordPayment` function to enter a vendor name, amount, and payer name (e.g., `"Mang Pedro"`, `500`, `"Juan Dela Cruz"`).

### What the Code Does

**Pragma Directive**: `pragma` ensures compatibility with Solidity version `0.8.0` or higher.

**State Variables**:

- `vendorName`: Stores the name of the vendor (e.g., "Aling Nena's Sari-Sari Store").
- `totalPayments`: Keeps track of payments made.

**Function**: The `recordPayment` function allows users to set a vendor name and record a payment amount.
