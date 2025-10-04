# Unlocking the Payable Arsenal

![20.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_20_unlocking_the_payable_arsenal/20.0%20-%20COVER.png)

## Scene

The moment had arrived. Neri stood at the edge of a digital battlefield—Hackana’s malicious malware was wreaking havoc in the financial ecosystem.

Transactions were being drained, leaving people penniless. But Neri knew that this time, the people could fight back with blockchain tools that empowered decentralized, transparent, and secure financial systems.

She realized that to truly enable the masses, her system needed to accept Ether directly. How could vendors receive Ether payments securely? Enter payable functions—the gateway for transferring funds on the blockchain.

As Neri enabled this powerful mechanism, the battle with Hackana began to shift. Vendors could now accept payments safely through smart contracts, unshaken by Hackana’s malware tricks.

### Solidity Topics: Payable functions

![20.1 - Payable Functions](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_20_unlocking_the_payable_arsenal/20.1.png)

Payable functions in Solidity allow smart contracts to receive Ether directly.

These functions are marked with the payable keyword, enabling the contract to handle Ether transactions securely.

### Features of Payable Functions:

**Ether Handling**: They can receive Ether from external accounts.

**Security**: Ensures Ether transfers are properly validated.

**Transparency**: Logs each transaction with event mechanisms for tracking.

### More Info about Payable Functions

- **Declaration**: Functions must use the payable modifier to accept Ether.
- **Transfer of Ether**: Ether sent to a contract through a payable function is automatically added to the contract’s balance.
- **Fallback with Payable**: A fallback function can also include payable to handle unexpected Ether.

### How to use payable syntax

**Basic payable function**

```solidity
function deposit() public payable {
    // Ether sent with this function call will be added to the contract balance
}
```

**Accessing Sender and Value**

```solidity
function receiveEther() public payable {
    address sender = msg.sender; // Address of the sender
    uint256 amount = msg.value; // Amount of Ether sent
}
```

**Fallback function payable**

```solidity
fallback() external payable {
    // Fallback function to accept unexpected Ether transfers
}
```

💡**Note**

A fallback function in Solidity is a special function that gets triggered when a contract receives Ether but does not specify any data, or when an unknown function is called on the contract.

It’s typically used to handle unexpected interactions, like receiving Ether without a specific function call, and can be marked as `payable` to allow Ether transfers.

If not marked as `payable`, any Ether sent to the contract will cause the transaction to fail. This function is useful in cases like wallets or contracts that need to accept funds, but do not have predefined function signatures for all incoming transactions.
