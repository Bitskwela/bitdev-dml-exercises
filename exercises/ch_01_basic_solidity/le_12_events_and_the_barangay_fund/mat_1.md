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
