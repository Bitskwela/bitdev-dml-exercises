# Task for Learners

Secure a function to ensure **only the contract owner** can execute it using a modifier. This task helps learners understand how to centralize access control in their contracts.

## Smart Contract Activity

Here’s a simple donation contract where only the owner can withdraw funds using a function modifier.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SecureFund {
    address public owner;
    uint256 public totalDonations;

    constructor() {
        owner = msg.sender; // Set the deployer as the owner
    }

    // 🚩 Task 1: Add a modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // Function to donate funds
    function donate() public payable {
        require(msg.value > 0, "Donation must be greater than zero");
        totalDonations += msg.value;
    }

    // 🚩 Task 2: Add function modifier to withdraw funds and only the owner can call this
    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
```

### Expected Results:

- Non-owners attempting to call withdraw will see the error: **"Not the owner."**
- Owners can withdraw funds seamlessly, transferring the balance to their address.

### Breakdown of the Activity:

- Variables Defined:
  - `owner`: Stores the address of the contract deployer.
  - `totalDonations`: Tracks the total donations received.
- Modifier Defined:
  - `onlyOwner`: Ensures only the owner can call specific functions, protecting the withdrawal process from unauthorized access.
- Functions:
  - `donate`: Accepts Ether donations and updates the total donations.
  - `withdraw`: Allows the owner to withdraw all funds, but only after passing the onlyOwner modifier check.
- Key Concepts Introduced:
  - Access Control: Demonstrates how to use modifiers to limit who can call specific functions.
  - Dynamic Ownership: The owner is set dynamically during contract deployment.
