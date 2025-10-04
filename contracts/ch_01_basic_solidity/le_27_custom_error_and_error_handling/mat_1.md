# Custom Errors and Error Handling

![27.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_27_custom_error_and_error_handling/27.0%20-%20COVER.png)

## Scene

Neri is now leading a team of blockchain developers in the final battle against Hackana. To counter Hackana’s ever-evolving malware, Neri realizes her team’s contracts need to be highly optimized and efficient.

Errors must be handled gracefully to avoid unnecessary gas consumption while ensuring clarity for debugging.
As they deploy defensive smart contracts, Neri introduces her team to Custom Errors, a technique she learned at a past developer summit.

This will help them handle failures systematically while minimizing gas costs.

## Solidity Topic: Custom Errors and Error Handling

![27.1 - Custom Errors](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_27_custom_error_and_error_handling/27.1.png)

Custom Errors were introduced in Solidity version **0.8.4** to improve gas efficiency and provide a structured way of error handling. Instead of passing long revert strings, custom errors encode error data compactly.

### Syntax for Custom Errors

```solidity
// Declare custom errors
error InsufficientBalance(uint256 requested, uint256 available);

contract ExampleContract {
    uint256 public balance;

    function withdraw(uint256 amount) public {
        if (amount > balance) {
            revert InsufficientBalance(amount, balance);
        }
        balance -= amount;
    }
}
```

### Benefits of Custom Errors

**Gas Savings:** Revert strings consume more gas compared to custom errors.

**Debugging Clarity:** Custom errors provide specific data related to the error.

**Best Practice:** Encourages more structured error handling.
