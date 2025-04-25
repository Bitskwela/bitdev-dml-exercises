# Protecting the donation fund

## Scene

Neri’s fight against Hackana intensifies as she encounters a new challenge: unauthorized access attempts to her blockchain-based systems. Hackana’s bots are trying to exploit her donation contracts by calling restricted functions.

Determined to secure her system, Neri learns about function _modifiers_ — a Solidity feature that adds an extra layer of control and protection to her smart contracts.

## Solidity Topics: Function modifiers

What are Function Modifiers?

Function modifiers are used to alter the behavior of functions in Solidity. They allow developers to reuse common logic across multiple functions, ensuring specific conditions are met before or after a function is executed.

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
