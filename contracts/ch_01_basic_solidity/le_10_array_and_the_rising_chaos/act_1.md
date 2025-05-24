# Smart contract activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PalengkeTransactions {
    function recordPayment() public {}

    function getTotalPayments() public view returns (uint256) {}

    function getPayment(uint256 _index) public view returns (uint256) {}
}
```

## Task for Learners

- Create an array to store payment amounts for a day.

  ```solidity
  uint256[] public payments;
  ```

- Write a function to record a payment to the array.

  ```solidity
    function recordPayment(uint256 _amount) public {
        payments.push(_amount);
    }
  ```

- Write a function to retrieve the total number of payments.

  ```solidity
    function getTotalPayments() public view returns (uint256) {
        return payments.length;
    }
  ```

- Write a function to access a specific payment by its index.

  ```solidity
    function getPayment(uint256 _index) public view returns (uint256) {
        require(_index < payments.length, "Invalid index.");
        return payments[_index];
    }
  ```

### Breakdown of the Activity

**Array Defined:**

- `payments`: A dynamic array of `uint256` to store payment amounts.
  This allows the contract to keep track of multiple payments made throughout the day. The array is public, enabling other contracts or users to access the payment data directly.
  This means that anyone can read the payment amounts stored in the array, but they cannot modify it directly. The array can grow or shrink dynamically as payments are added or removed.

**Key Functions:**

- `recordPayment`: Accepts a payment amount as input. This function adds it to the payments array using the `push()` function.
- `getTotalPayments`: Returns the total number of payments stored in the array by accessing its length property.
- `getPayment`: Retrieves a specific payment by its index. This function uses a require statement to ensure the index is valid. It returns the payment amount at the specified index.
  This is important to prevent out-of-bounds access, which could lead to errors or unexpected behavior. The require statement checks if the index is less than the length of the payments array. If the condition is not met, it reverts the transaction with an error message. The function is marked as `view`, indicating that it does not modify the state of the contract and can be called without sending a transaction. This allows users to retrieve payment information without incurring gas costs.
