# Calldata – The Art of Efficient Communication

## Scene

Neri and her team receive an urgent report: Hackana has infiltrated a major government project, exploiting inefficient smart contracts to intercept sensitive data during transactions. The attacks slow down operations and drain excessive gas from victims.

As the battle intensifies, Neri discovers that calldata, a lesser-known data location, holds the key to secure and efficient data transfer in Solidity. It’s time to dive deep into this concept and prepare her team for the ultimate showdown.

## Solidity Topics: Calldata

## More Info about Calldata

In Solidity, calldata is a special data location used for:

- **External Function Calls**: Parameters passed to external functions.
- **Read-Only**: Calldata is immutable and cannot be modified.
- **Gas Efficiency**: Since it does not allow modifications, it’s more gas-efficient compared to memory.

**Key Points**:
Use calldata for function parameters that are:

- Temporary: Needed only during the function execution.
- Immutable: Won’t be modified within the function.

### Sample Contract

```solidity
pragma solidity ^0.8.8;

contract CalldataExample {
    function processData(string calldata input) external pure returns (string memory) {
        return input; // Use the input directly without modifying it.
    }
}
```

### How to use Calldata in Solidity

**Declaring calldata parameters**:

```solidity
function exampleFunction(string calldata input) external pure returns (string memory) {
    return input;
}
```

**Comparison with memory**:

```solidity
function memoryFunction(string memory input) public pure returns (string memory) {
    return input;
}
```

#### General notes 💡

- **Calldata**: Read-only, gas-efficient, immutable.
- **Memory**: Allows modifications, costs more gas.
