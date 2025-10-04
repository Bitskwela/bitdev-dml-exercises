# Fallback and Receive Functions – Handling Unexpected Situations

![13.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_13_fallback_and_receive_functions/13.0%20-%20COVER.png)

## Scene

Neri is making great strides in implementing blockchain for public projects. One day, while visiting the Barangay Tech Fair, she encounters an unusual situation. A local programmer approaches her and says:

**“Neri, paano kapag ang smart contract ko nakatanggap ng funds nang walang tinawag na function? Paano ‘yun hahandle?”** (_Neri, what if my smart contract receives funds without a function being explicitly called? How do I handle that?_)

Neri realizes this is a perfect opportunity to explain the fallback and receive functions in Solidity. These functions act as a safety net, ensuring contracts can handle unexpected transactions or interactions.

## Solidity Topics: Fallback and Receive functions

![13.1](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_13_fallback_and_receive_functions/13.1.png)

### Overview

Fallback and receive functions are special functions in Solidity designed for handling unexpected situations:

**Receive Function**

- Triggered when a contract receives Ether directly (e.g., via `send` or `transfer`) without any data.
- Declared using `receive()` external payable.
- Can only handle Ether transactions, no additional logic.

**Fallback Function**

- Triggered when a contract receives a call to a function that doesn’t exist.
- Declared using `fallback()` `external`.
- Handles both Ether transfers (if payable) and invalid function calls.

### Example

```solidity
contract Example {
    // Handles direct Ether transfer
    receive() external payable {}

    // Handles unexpected or invalid calls
    fallback() external payable {}
}
```

### How to use Fallback and Receive functions

**Receive Ether**

If someone sends Ether to a contract without calling a function, the `receive()` function is triggered automatically.

**Example:**

    ```solidity
    receive() external payable { // Add Ether received to a variable }
    ```

**Handle Invalid Calls**

When a function that doesn’t exist is called, the `fallback()` function is triggered.

**Example:**

```solidity
    fallback() external {
        // Log invalid call inside this function
    }
```
