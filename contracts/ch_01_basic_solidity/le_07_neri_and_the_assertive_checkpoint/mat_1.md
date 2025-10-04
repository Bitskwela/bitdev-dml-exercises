# Neri and the Assertive Checkpoint

![7.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_07_neri_and_the_assertive_checkpoint/7.0%20-%20COVER.png)

## Scene

Neri’s anti-Hackana mission intensifies as the rogue malware starts tampering with crucial government databases, causing data mismatches and unauthorized access. She realizes that the integrity of her smart contracts is at stake, and she needs to implement robust error handling mechanisms to prevent further damage. Neri recalls her training on the importance of using `assert()` and `revert()` functions in Solidity to ensure the reliability of her contracts.

As she analyzes the issue, Neri identifies the importance of building systems that halt operations completely when a critical error occurs to prevent further damage. To secure her smart contracts, she studies `assert()` and `revert()` in Solidity. She learns that these functions are essential for ensuring the integrity of her contracts and preventing unauthorized access or data corruption.

## Solidity Topics: `assert()` and `revert()`

![7.1](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_07_neri_and_the_assertive_checkpoint/7.1.png)

In Solidity, `assert()` and `revert()` are crucial for error handling and ensuring the integrity of smart contracts. They help in maintaining the reliability of the contract by stopping execution when something goes wrong.

- `assert()`: Used to check for conditions that should never fail under normal execution. If the condition evaluates to false, the transaction is reverted, and all changes are undone. It consumes all remaining gas, making it suitable for internal errors or invariants.

  **Example use case: Validating internal states or ensuring critical assumptions remain true.**

  ```solidity
  assert(balance[msg.sender] >= amount);
  ```

- `revert()`: A function that stops execution and reverts the transaction explicitly. It allows you to provide an error message or perform additional cleanup before halting the contract. It can be used to handle errors gracefully and provide feedback to users.

  **Example use case: Handling errors and providing user-friendly feedback.**

  ```solidity
  if (amount > balance[msg.sender]) {
      revert("Insufficient balance");
  }
  ```
