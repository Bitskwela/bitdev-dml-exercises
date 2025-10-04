# Interfaces in Solidity

![21.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_21_interfaces_in_solidity/21.0%20-%20COVER.png)

## Scene

Neri is getting closer to tracking down Hackana, but Hackana is using advanced techniques to mask transactions across multiple decentralized platforms. Neri realizes that she needs to create a decentralized payment gateway that allows multiple systems to interact seamlessly.

To do so, she decides to implement an interface to enable her payment platform to communicate with other external contracts and systems, ensuring that transactions are efficient, secure, and able to scale.

### Solidity Topics: Interfaces

![21.1 - Interfaces](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_21_interfaces_in_solidity/21.1.png)

As Neri continues to build a secure environment to fight against Hackana, she realizes that communication between different contracts is essential. Interfaces in Solidity help make different contracts interoperable by providing a standard that other contracts can implement.

With interfaces, Neri can define the structure of functions that other contracts must implement, allowing her contract to interact with them without knowing their exact implementation.

### Key points about interfaces:

- Interfaces define a contract’s external function signatures without implementation.
- Contracts that implement the interface must define the behavior of those functions.
- Interfaces allow interaction between contracts across different networks or platforms, enabling modular and scalable dApps.

In Neri’s case, she’ll define an interface that can be used by any contract to interact with a decentralized payment system.

**When to Use an Interface?**

- Use interfaces when you want to interact with other contracts.
- They are helpful for calling functions in another contract without needing to know how it is implemented.

### How to use Interfaces

**Define the interface:**

Declare the functions that other contracts will implement

Example:

```solidity
interface IToken {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}
```

**Implement the interface:** In your contract, declare an instance of the interface and call its functions

Example:

```solidity
contract TokenSender {
    IToken token; // Declare an interface instance
    constructor(address tokenAddress) {
    token = IToken(tokenAddress); // Set the token contract address
}

// Function to send tokens
    function sendTokens(address recipient, uint256 amount) external {
        require(token.transfer(recipient, amount), "Transfer failed");
    }
}
```

#### Quick Summary:

- Interfaces only declare function signatures.
- Contracts implement these interfaces by calling the functions defined in the interface.
- Use interfaces to interact with external contracts while keeping your code clean and modular.
