# Neri and the Assertive Checkpoint

## Scene

Neri’s anti-Hackana mission intensifies as the rogue malware starts tampering with crucial government databases, causing data mismatches and unauthorized access.

As she analyzes the issue, Neri identifies the importance of building systems that halt operations completely when a critical error occurs to prevent further damage. To secure her smart contracts, she studies `assert()` and `revert()` in Solidity.

## Solidity Topics: `assert()` and `revert()`

- `assert()`: Used to check for conditions that should never fail under normal execut ion. If the condition evaluates to false, the transaction is reverted, and all changes are undone. It consumes all remaining gas, making it suitable for internal errors or invariants.

  **Example use case: Validating internal states or ensuring critical assumptions remain true.**

- `revert()`: A function that stops execution and reverts the transaction explicitly. It allows you to provide an error message or perform additional cleanup before halting the contract.

  **Example use case: Handling errors and providing user-friendly feedback.**
