# Storage vs. Memory – Unmasking Hackana’s Data Trap

## Scene

Hackana’s attacks are becoming more complex, targeting the efficiency of the blockchain itself. Neri learns from her team that Hackana is exploiting poorly optimized smart contracts by filling them with redundant data operations. This slows down transaction speeds and increases gas costs for everyone using the blockchain.

While reviewing the latest Ethereum logs, Neri realizes that most of these issues stem from a misunderstanding of storage and memory in Solidity. Hackana knows that many developers store temporary data inefficiently, causing bloated contracts.

It’s time for Neri to optimize her smart contract to counter Hackana’s data trap.

## Solidity Topics: Storage and Memory

In Solidity, the two main data locations for storing variables are:

- **Storage**:

  - Persistent data stored on the blockchain.
  - Modifying it costs gas as it writes to Ethereum’s state.
  - Example: State variables declared at the contract level.

- **Memory**:
  - Temporary data that exists only during the execution of a function.
  - Does not persist after the function call ends.
  - Example: Variables used inside functions.

### Syntax examples

**Declaring Storage variable:**

`string public storageData = "Stored on blockchain";`

**Declaring a memory variable in a function:**

```solidity
function getMemoryData()
public pure returns (string memory) {
    string memory tempData = "Temporary in memory";
    return tempData;
}
```

### Best Practices:

- Use storage for long-term data that must persist.

- Use memory for temporary calculations or function inputs to save gas.

### How to use Storage and Memory

- **Storage** is for persistent data – use it for values that needs to persist across transactions

  Example:

  `uint256 public count = 0; // Stored on blockchain`

- **Memory** is for temporary data – use it for variables inside functions to avoid gas cost for persistent storage.

  Example:

  ```solidity
  function calculateSum(uint256 a, uint256 b) public pure returns (uint256) {
      uint256 sum = a + b; // Temporary variable
      return sum;
  }
  ```

- _Gas optimization tip_: Avoid unnecessary writes to storage. Instead, process data in memory whenever possible and update storage only once.
