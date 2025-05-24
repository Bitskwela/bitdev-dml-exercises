# Smart Contract Activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SecureDonation {
    uint256 public totalDonations;

    mapping(address => uint256) public donations;

    function donate() external {}

    function withdraw() external {}
}
```

## Task for Learners

Build a secure donation contract that prevents reentrancy attacks, validates input, and ensures only the owner can withdraw funds.

- Import the necessary OpenZeppelin library for security features - ReentrancyGuard and Ownable.

  ```solidity
  import "@openzeppelin/contracts/access/Ownable.sol";
  import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
  ```

- Define a `donate` function that accepts ETH donations, ensuring the donation is greater than zero. Use the `nonReentrant` modifier to prevent reentrancy attacks.

  ```solidity
      function donate() external payable nonReentrant {
          require(msg.value > 0, "Donation must be greater than zero.");
          donations[msg.sender] += msg.value;

          totalDonations += msg.value;
      }
  ```

- Implement a `withdraw` function that allows the owner to withdraw all funds from the contract. And ensure the `withdraw` function can only be called by the contract owner and uses a secure transfer method to send funds. Add the `nonReentrant` modifier to prevent reentrancy attacks.

  ```solidity
      function withdraw() external onlyOwner nonReentrant {
          require(totalDonations > 0, "No funds to withdraw.");
          (bool success, ) = owner().call{value: address(this).balance}("");
          require(success, "Withdrawal failed.");
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
