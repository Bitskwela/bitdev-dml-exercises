```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayFund {
    uint256 public totalFunds;

    function depositFunds(uint256 amount) public {}
}
```

# Task for Learners

- Create an event that logs whenever the barangay fund is updated.

  ```solidity
      event FundUpdated(uint256 newAmount, address updatedBy);
  ```

- Update the `depositFunds` function to emit the event whenever a new deposit is made.

  ```solidity
      function depositFunds(uint256 amount) public {
          require(amount > 0, "Deposit amount must be greater than zero.");
          totalFunds += amount;

          emit FundUpdated(totalFunds, msg.sender);
      }
  ```

### Breakdown of Activity

**State Variable Defined:**

- `totalFunds`: Tracks the total amount of funds available.

**Event Declared:**

```solidity
FundUpdated(uint256 newAmount, address updatedBy)
```

The code above performs the following:

- Logs the new total funds (`newAmount`).
- Records the address of the person who updated the fund (`updatedBy`).

**Key Function:**

```solidity
depositFunds(uint256 amount);
```

_The code above performs the following:_

- Accepts a fund deposit amount as input.
- Adds the amount to `totalFunds`.
- Emits the `FundUpdated` event with the new total and sender’s address.

### Summary after implementing the Events:

Neri demonstrates the new system during the barangay meeting. Whenever someone deposits funds, the contract emits an event that is immediately visible on a public dashboard. The residents are amazed at the transparency, and the barangay captain jokingly says:

**“Mukhang wala nang matatago sa ayuda fund ngayon!”** (_Looks like nothing can be hidden in the ayuda fund now!_)

As Neri leaves, she begins thinking about the next phase of her journey: improving user interaction with contract data through arrays and mappings.
