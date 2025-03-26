# Events – Broadcasting Neri’s progress

## Scene

Neri’s blockchain solutions are now empowering more communities. While attending a barangay meeting, Neri overhears residents discussing a transparency issue.

One resident remarks:
**“Paano ba natin malalaman kung may nag-update sa ayuda fund? Mukhang hindi transparent!”** (_How do we know if someone updates the ayuda fund? It seems lacking in transparency!_)

Neri realizes that blockchain has a powerful feature that can address this: events. Events act as a messaging system
within the Ethereum network, allowing external applications (like barangay dashboards) to track contract activity.

The next step in her journey is clear: build a system that emits events every time a critical update happens in the contract.

## Solidity Topics: Events

### How to use Events

Events are a way for a smart contract to log important activities that external applications can track. When an event is emitted, it gets recorded on the blockchain’s transaction logs, making it easily accessible for off-chain monitoring.

#### Key Points:

- Events are Declared using the `event` keyword.
- Emitted using the `emit` keyword.
- Useful for tracking changes without storing all details on-chain.

### Syntax Example:

```solidity
// Event declaration:  Announces when a donation is received.
// Think of it like a "tandaan" or announcement that someone gave money.
event DonationReceived(
    address indexed donor,
    uint256 amount,
    string message
);

// Emit the DonationReceived event.
// This tells everyone that a donation happened.
emit DonationReceived(
    msg.sender,
    msg.value,
    _message
);
```

**How to use Events in Solidity**

- Defining an Event

  - Use the event keyword followed by the event structure.
  - Example: `event LogAction(address user, string action);`

- Emitting an Event
  - Using the emit keyword, call the event name and pass in the required parameters
  - Example: `emit LogAction(msg.sender, “Fund deposited”);`

### Events use Cases:

- Logging transactions (e.g., fund transfers).
- Notifying users of changes in contract state.
- Debugging contract behavior.

### Task for Learners

- Create an event that logs whenever the barangay fund is updated.
- Emit the event whenever a new deposit is made.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayFund {
    uint256 public totalFunds;

    // 🚩 Task 1: Define an event for fund updates
    event FundUpdated(uint256 newAmount, address updatedBy);

    // 🚩 Task 2: Function to update the fund
    function depositFunds(uint256 amount) public {
        require(amount > 0, "Deposit amount must be greater than zero.");
        totalFunds += amount;

        // 🚩 Emit the event
        emit FundUpdated(totalFunds, msg.sender);
    }
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
