# Smart contract activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract JeepneyFareSystem {
    mapping(address => bool) public hasPaid;

    uint256 public baseFare = 13;

    function calculateFare(uint256 distance) public view returns (uint256) {}

    function payFare(uint256 distance) public payable {}

    function checkPaymentStatus(address passenger) public view returns (bool) {}

    function verifyFare(
        uint256 distance,
        uint256 paidAmount
    ) private view returns (bool) {}
}
```

## Tasks for Learners

- Define a public function named `calculateFare` to calculate jeepney fares based on the distance traveled.
  ```solidity
     function calculateFare(uint256 distance) public view returns (uint256) {
        return baseFare + (distance * 2);
    }
  ```
- Make `payFare` function a payable in order to accept passenger payments.
  ```solidity
    function payFare(uint256 distance) public payable {
        uint256 requiredFare = calculateFare(distance);
        require(msg.value == requiredFare, "Incorrect fare amount.");
        hasPaid[msg.sender] = true;
    }
  ```
- Add a `checkPaymentStatus` as a view function to check if a passenger has already paid.
  ```solidity
    function checkPaymentStatus(address passenger) public view returns (bool) {
        return hasPaid[passenger];
    }
  ```
- Make `verifyFare` function as `private` function in order to verify the correctness of a fare calculation.
  ```solidity
    function verifyFare(
        uint256 distance,
        uint256 paidAmount
    ) private view returns (bool) {
        return paidAmount == calculateFare(distance);
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
