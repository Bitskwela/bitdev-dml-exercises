# Jeepney Fare Disputes and Automated Solutions

## Scene:

Jeepney Frustrations and Functionality
Neri rides a jeepney to Ortigas, where she works. The jeepney driver and konduktor are at odds over fare collection. Some passengers pay cash, while others use QR codes, resulting in delayed calculations and occasional disputes.
**“Bayad na ako kanina! Bakit pa may dagdag?!”**
_("I already paid earlier! Why is there an extra charge?!")_

The lack of an automated system leaves room for human error and inefficiency. Neri envisions a blockchain-based solution where every transaction is automated through functions in a smart contract.

Functions, she recalls from her studies, are the backbone of any Solidity program—they allow developers to define specific behaviors like calculating fares, verifying payments, and updating records.

## Solidity Topics: Functions

In Solidity, functions are reusable pieces of code that perform specific tasks. They are fundamental to making a contract dynamic and interactive.

### Example of a function

```solidity
// Example function to donate funds
    function donate() public payable {
        totalDonations += msg.value;
    }
```

### Types of Functions visibility

- Public Functions: Can be called from within and outside the contract. Useful for exposing features like paying fares or checking balances.

  ```solidity
  function getFare() public view returns (uint256) {
      return farePrice;
  }
  ```

- Private Functions: Only accessible within the contract. Ideal for internal logic, such as verifying calculations.
  ```solidity
      // Private function: Only the owner can use this to change the fare.
  function setFare(uint256 _newFare) private {
      farePrice = _newFare;
  }
  ```
- View and Pure Functions:

  - `view`: Reads data without modifying it. For example, retrieving a passenger's payment status.

    ```solidity
    // View function:  Check the current fare.  Doesn't cost gas.
    function getFare() public view returns (uint256) {
        return farePrice;
    }
    ```

  - `pure`: Performs computations but doesn’t read or write contract data.

    ```solidity
        // Pure function: Calculate discount (e.g., for students/seniors). Doesn't read/write state.
    function calculateDiscountedFare(uint256 _baseFare, uint256 _discountPercent) public pure returns (uint256) {
        // This is a simplified calculation.
        uint256 discountAmount = (_baseFare * _discountPercent) / 100;
        return _baseFare - discountAmount;
    }
    ```

- Payable Functions: Enable the contract to receive Ether. Perfect for processing fare payments.

### Why Functions Are Important:

- They organize the contract into logical, reusable parts.
- They allow interaction between users and the smart contract.
- Functions make the contract more readable and maintainable.

### Tasks for Learners

- Define a `public` function to calculate jeepney fares based on the distance traveled.
- Create a `payable` function to accept passenger payments.
- Add a `view` function to check if a passenger has already paid.
- Use a `private` function to verify the correctness of a fare calculation.

### Smart contract activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract JeepneyFareSystem {
    // Store passenger payment status
    mapping(address => bool) public hasPaid;

    // Define the base fare
    uint256 public baseFare = 13; // Example base fare in PHP

    // 🚩 TODO: Task 1 - Public function to calculate fare based on distance
    function calculateFare(uint256 distance) public view returns (uint256) {
        return baseFare + (distance * 2); // Example: Add 2 PHP per kilometer
    }

    // 🚩 TODO: Task 2 - Payable function to accept fare payments
    function payFare(uint256 distance) public payable {
        uint256 requiredFare = calculateFare(distance);
        require(msg.value == requiredFare, "Incorrect fare amount.");
        hasPaid[msg.sender] = true; // Mark passenger as paid
    }

    // 🚩 TODO: Task 3 - View function to check payment status
    function checkPaymentStatus(address passenger) public view returns (bool) {
        return hasPaid[passenger];
    }

    // 🚩 TODO: Task 4 - Private function to verify fare calculation (used internally)
    function verifyFare(
        uint256 distance,
        uint256 paidAmount
    ) private view returns (bool) {
        return paidAmount == calculateFare(distance);
    }
}
```

### Breakdown for Learners

- Public Function:

  - `calculateFare` calculates the fare dynamically based on the distance traveled.

- Payable Function:

  - `payFare` ensures passengers pay the exact required fare and updates their payment status.

- View Function:

  - `checkPaymentStatus` allows the system or passengers to verify if payment was already made.

- Private Function:
  - `verifyFare` ensures the paid amount matches the calculated fare, though it’s hidden from external access.
