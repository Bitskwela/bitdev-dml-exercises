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