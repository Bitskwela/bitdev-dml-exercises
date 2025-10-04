# Inheritance – Building on Solidity’s Foundations

![19.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_19_soliditys-inheritance/19.0%20-%20COVER.png)

## Scene

Neri and her team have successfully thwarted Hackana’s recent attack, but they realize the malware is evolving faster than anticipated. To counter its adaptability, Neri decides to upgrade their contracts by building reusable, modular components.

Inspired by her old notes on inheritance, she devises a plan to simplify their codebase and allow rapid upgrades. "_With inheritance, we can stack the power of multiple contracts and focus on the battle ahead,_" she explains to her team.

## Solidity Topics: Inheritance

![19.1](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_19_soliditys-inheritance/19.1.png)

## More Info about Inheritance

Inheritance in Solidity allows a contract to derive properties and behavior from another contract, reducing redundancy and promoting reusability.

- Base Contract: The parent contract containing shared logic and properties.
- Derived Contract: The child contract that inherits and extends the functionality of the parent.

### How to use Inheritance in Solidity

First, create a base or parent contract

```solidity
contract ParentContract {
    // Common properties and functions
}
```

A new or existing contract can inherit the functions of parent contract

```solidity
contract ChildContract is ParentContract {
// New properties or functions
}
```

Overriding functions (optional)

```solidity
contract ParentContract {
    function greet() public virtual returns (string memory) {
        return "Hello from Parent!";
    }
}

contract ChildContract is ParentContract {
    function greet() public override returns (string memory) {
        return "Hello from Child!";
    }
}
```

### Sample syntax implementing Inheritance

```solidity
pragma solidity ^0.8.0;

contract ParentContract {
    // Base contract logic here
}

contract ChildContract is ParentContract {
    // Extending or overriding the ParentContract's logic here
}
```

### Key Features of Inheritance:

**Reusability**: Write common functionality in one contract and inherit it in others.

**Overriding**: Redefine functions in the child contract to customize behavior.

**Visibility Modifiers**: Use `internal` for inheritance-specific logic.
