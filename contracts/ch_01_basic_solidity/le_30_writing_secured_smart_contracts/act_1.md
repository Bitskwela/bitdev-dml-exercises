# Task for Learners

Build a secure donation contract that prevents reentrancy attacks, validates input, and ensures only the owner can withdraw funds.

## Smart Contract Activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import OpenZeppelin utilities for security
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract SecureDonation is Ownable, ReentrancyGuard {
    constructor() Ownable(msg.sender) ReentrancyGuard() {}

    // State variable to track total donations
    uint256 public totalDonations;

    // Mapping to store donations per user
    mapping(address => uint256) public donations;

    // Function to accept donations
    function donate() external payable nonReentrant {
        require(msg.value > 0, "Donation must be greater than zero.");

        // 🚩 TODO: Update the state variable (donations mapping) first before updating totalDonations
        donations[msg.sender] += msg.value;
        totalDonations += msg.value;
    }

    // 🚩 TODO: Add a function for the owner to withdraw funds. Add reentrancy guard
    function withdraw() external onlyOwner nonReentrant {
        require(totalDonations > 0, "No funds to withdraw.");

        // Transfer all funds to the owner
        (bool success, ) = owner().call{value: address(this).balance}("");
        require(success, "Withdrawal failed.");
    }
}
```

### Breakdown of the Activity

**Imports:**

- `Ownable`: Manages owner-specific functionality.
- `ReentrancyGuard`: Prevents reentrancy attacks.

**State Variables:**

- `totalDonations`: Tracks the total ETH received.
- `donations`: Maps user addresses to their contributions.

**Donation Function:**

- `donate()`: Accepts ETH while ensuring the donation is non-zero.
- `nonReentrant`: Blocks reentrancy attacks.

**Withdraw Function:**

- Restricted to the owner via `onlyOwner`.
- Transfers contract balance safely using `.call`.

### Closing Story

As Neri's secure smart contract goes live, Hackana's final attack begins. However, every exploit attempt is met with impenetrable defenses. Reentrancy attacks fail, input manipulations are
rejected, and funds remain protected. With no vulnerabilities left to exploit, Hackana disintegrates, defeated by Neri's brilliance.

The city of San Juan rejoices, its blockchain infrastructure restored and fortified. Neri's journey inspires a new wave of secure development, ensuring a future where trust in technology is unshakable.

She stands as a hero, not just for her technical skills but for her unwavering commitment to a secure digital world.
