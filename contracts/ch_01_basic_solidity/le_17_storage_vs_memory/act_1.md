### Task for Learners

Hackana’s latest malware has been exploiting contracts that inefficiently store temporary data in storage instead of memory. Neri needs your help to:

- Create a smart contract that differentiates between storage and memory.

- Show how a storage variable can be updated, and a memory variable can be used for temporary processing.

### Smart contract activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataOptimization {
    // 🚩 Task 1: Define a storage variable
    string public storedMessage = "Stored permanently";

    // 🚩 Task 2: Use a memory variable for temporary updates
    function updateMessage(string memory tempMessage) public {
        // Memory variable used only during this function call
        storedMessage = tempMessage;
    }

    // 🚩 Task 3: Compare storage and memory
    function compareStorageAndMemory() public view returns (string memory) {
        string memory tempMessage = storedMessage; // Copy storedMessage into memory
        return tempMessage; // Returns the temporary memory variable
    }
}
```

### Breakdown of Activity

**Storage Variable**:

- `storedMessage`: A state variable stored on the blockchain.
- Changes to this variable cost gas since it writes to Ethereum’s storage.

**Memory Variable**:

- `tempMessage`: Declared within the `updateMessage` function, exists only during the function execution.
- Does not consume gas for storage, making it ideal for temporary operations.

**Functions**:

- `updateMessage`:

  - Takes a `memory` variable as input.
  - Updates the `storedMessage` (storage variable) with the new value.

- `compareStorageAndMemory`:
  - Demonstrates the difference by copying the storage variable into memory and returning it.

### Closing Story

As Neri deploys the _DataOptimization_ contract, she explains the difference to her barangay officials:

"**Kapag gumagamit tayo ng storage, parang nilalagay natin sa national archives—matagal pero pangmatagalan. Ang memory naman, parang post-it note—mabilis, pero panandalian lang.**"

(_When we use storage, it’s like filing it in the national archives—slow but long-term. Memory, on the other hand, is like a post-it note—quick but temporary._)

This analogy helps everyone understand why Hackana’s attacks are effective: inefficient contracts create bloated systems.

Hackana, watching from a remote location, chuckles:
_"Impressive, Neri. But can you optimize faster than I can corrupt?"_

Neri grins as she prepares to write even more efficient contracts for the impending battle.
