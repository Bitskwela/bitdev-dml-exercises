# Neri’s Battle Against Hackana and understanding Solidity’s `require`

## Scene:

As Hackana’s malware spreads throughout the country, Neri watches in horror as it steals from bank accounts, disables critical government websites, and causes widespread financial chaos. She learns that the rogue malware Hackana and it’s creators has been exploiting vulnerabilities in various financial systems, allowing unauthorized transactions to pass through unchecked.

Determined to fight back, Neri realizes that in order to protect the public’s funds, she needs to develop smart contracts that can prevent malicious actions from slipping through. One of the key features she focuses on is the require function in Solidity. This will be crucial in ensuring that only valid and legitimate transactions are processed in her contracts, and that any attempt to bypass the rules is stopped immediately.

As Neri works on her blockchain-based solution, she builds a new smart contract for a Community Fund. This fund will allow people to donate securely, but only if certain conditions are met—such as verifying that the donation amount is correct and that the sender has sufficient funds. If any condition fails, the contract will reject the transaction and revert the state, preventing malicious actions like those of Hackana.

## Solidity Topics: `require`

`require`, is an essential Solidity function for error handling and validation. It is used to ensure that certain conditions are true before allowing a transaction to proceed.

If the condition fails, it stops the execution and reverts the changes, ensuring that invalid operations don’t go through, and at the same time an optional error message can be provided to indicate the reason for the failure.

### Sample Syntax

```solidity
require(msg.value == 7, "Unauthorized");
```

### Tasks for Learners

Neri wants to build a Community Fund contract that allows people to donate funds. However, to ensure the integrity of the system, donations can only be accepted if they meet the following conditions:

- Inside the `donate` function, ensure that donations can only be made with a non-zero amount.

- Add a condition that checks if the amount donated equals the amount sent (using `msg.value`).

- Inside the `withdraw` function, only allow the contract owner to withdraw funds.

- Ensure the `withdraw` function verifies there are enough funds before allowing a withdrawal.

- If any of these conditions fail, the transaction should be rejected.

## Smart contract activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CommunityFund {
    address public fundOwner;
    uint256 public totalDonations;

    constructor() {
        fundOwner = msg.sender; // The contract creator is the fund owner
    }

    // Function to donate to the fund
    function donate(uint256 amount) public payable {
        // 🚩 Task 1: Use require to ensure the donation amount is greater than zero
        require(amount > 0, "Donation must be greater than zero");

        // 🚩 Task 2: Ensure the sender has enough Ether to make the donation
        require(msg.value == amount, "Insufficient Ether provided");

        totalDonations += amount; // Update the total donations
    }

    // Function to withdraw funds (only the owner can withdraw)
    function withdraw(uint256 amount) public {
        // 🚩 Task 3: Ensure only the owner can withdraw funds
        require(msg.sender == fundOwner, "Only the owner can withdraw funds");

        // 🚩 Task 4: Ensure enough funds are available to withdraw
        require(amount <= totalDonations, "Not enough funds");

        totalDonations -= amount;
        payable(fundOwner).transfer(amount);
    }
}
```

### Breakdown for Learners

`require` is a guardrail: It acts as a checkpoint to ensure that the contract operates within the defined rules. If the condition in `require` is not met, the transaction is **stopped**, and any changes made to the contract state are reverted.

**Why use require?**

- Security: Prevents invalid operations from affecting the contract state (e.g., Hackana trying to withdraw funds without meeting conditions).

- Efficiency: require helps enforce conditions before performing costly operations or state changes, saving gas when conditions aren’t met.
