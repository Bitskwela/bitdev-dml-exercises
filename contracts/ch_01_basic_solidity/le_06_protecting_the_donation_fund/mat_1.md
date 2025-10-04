# Protecting the donation fund

![6.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_06_protecting_the_donation_fund/6.0%20-%20COVER.png)

## Scene

Neri’s fight against Hackana intensifies as she encounters a new challenge: unauthorized access attempts to her blockchain-based systems. Hackana’s bots are trying to exploit her donation contracts by calling restricted functions. Neri needs to ensure that only authorized users can access certain functions in her smart contracts.

Determined to secure her system, Neri learns about function _modifiers_ — a Solidity feature that adds an extra layer of control and protection to her smart contracts. She realizes that by using modifiers, she can enforce specific rules and conditions before executing functions, ensuring that only the right people can access sensitive operations.

## Solidity Topics: Function modifiers

![6.1](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_06_protecting_the_donation_fund/6.1.png)

What are Function Modifiers?

Function modifiers are used to alter the behavior of functions in Solidity. They allow developers to reuse common logic across multiple functions, ensuring specific conditions are met before or after a function is executed. Modifiers can help enforce rules and improve the security of smart contracts by restricting access to sensitive functions. They are defined using the `modifier` keyword and can be applied to functions to add preconditions or postconditions.

### Key Uses of Modifiers:

- Restricting access to certain functions (e.g., only the owner can execute).
- Checking preconditions or postconditions.
- Reducing code duplication by centralizing repetitive checks.

### Sample Syntax:

```solidity
modifier onlyOwner() {
    require(msg.sender == owner, "Not the owner");
    _;
}
```

_The underscore (`_`) is a placeholder that represents the rest of the function’s body. The modifier code runs before the function body by default.\_
