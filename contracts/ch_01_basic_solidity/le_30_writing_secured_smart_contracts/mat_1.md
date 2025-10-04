# Writing Secured Smart Contracts

![30.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_30_writing_secured_smart_contracts/30.0%20-%20COVER.png)

## Scene: The Final Showdown

The battle reaches its peak. Hackana, furious over its inability to breach Neri's defenses, unleashes a catastrophic attack aimed at destabilizing the entire blockchain infrastructure.

As chaos looms, Neri rallies her team one last time. They realize that ultimate security lies not just in technology but in thoughtful design.

Together, they craft an unbreachable fortress: a secure smart contract that withstands even Hackana's most devious exploits.

### Solidity Topic: Writing Secured Smart Contracts

![30.1 - Writing Secured Smart Contracts](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_30_writing_secured_smart_contracts/30.1.png)

**What is a Secure Smart Contract?**

A secure contract is one that is resistant to common vulnerabilities, ensuring that funds, data, and functionality remain protected from malicious actors. Security is a mindset that permeates every line of code.

### Best Practices for Security in Solidity

- **Check for Reentrancy**: Prevent functions from being called before their execution is complete.
  - Use `checks-effects-interactions` pattern.
  - Implement the `ReentrancyGuard` from OpenZeppelin.
- **Validate Input**: Always validate user inputs and parameters using `require()` or `revert()`.
- **Avoid Floating Pragma**: Lock the compiler version to prevent unexpected behavior in new releases.
- **Use Access Control**: Restrict sensitive functions with `onlyOwner` or other modifiers.
- **Avoid `tx.origin` for Authentication**: Use `msg.sender` instead.
- **Test Extensively**: Run audits and use testing tools like _MythX_ and _Slither_.

### Example Key Security Best Practices

**Checks-Effects-Interaction Pattern** – The Checks-Effects-Interactions pattern is a best practice in Solidity to avoid reentrancy attacks and ensure safer contract execution. It involves organizing the steps of a function in three phases:

- **Checks**: Validate the conditions and inputs before making any state changes.
  Ensure the caller is authorized or that the parameters are correct.

- **Effects**: Modify the contract's state after validation.
  Update state variables to reflect changes caused by the function execution.

- **Interactions**: After validating and updating state, interact with external contracts (e.g., transferring tokens, calling other contracts).
  Interactions should be done last to avoid potential reentrancy attacks.

_By following this pattern, you prevent external calls (like transfers or contract interactions) from affecting the contract's state before it is updated, thus mitigating the risk of reentrancy._

**Code Example:**

```solidity
function safeTransfer
(address recipient, uint256 amount) public {
    require(balances[msg.sender] >= amount, "Insufficient balance."); // Checks
    balances[msg.sender] -= amount; // Effects
    (bool success, ) = recipient.call{value: amount}(""); // Interactions
    require(success, "Transfer failed.");
}
```

In this example:

- Checks: Ensure the sender has enough balance.
- Effects: Decrease the sender's balance before interacting with the recipient.
- Interactions: Finally, transfer funds to the recipient, ensuring that the contract state is updated before any external interactions.

---

**Reentrancy Guard** – A Reentrancy Guard is a security feature that prevents reentrancy attacks, a common vulnerability in smart contracts where an external contract calls back into the calling contract before its initial execution is finished. This can lead to unintended outcomes, such as draining funds from a contract.

> The ReentrancyGuard is provided by OpenZeppelin's library, which introduces a nonReentrant modifier to functions. This modifier ensures that the function cannot be re-entered during its execution. If the function is already being executed, any subsequent calls will fail until the first execution is completed.

**Code Example:**

```solidity
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
contract SafeContract is ReentrancyGuard {
    function safeAction() public nonReentrant {
        // Add Logic here
    }
}
```

_In this example, the nonReentrant modifier ensures that the withdraw function cannot be called again before the previous one is finished, preventing reentrancy attacks._
