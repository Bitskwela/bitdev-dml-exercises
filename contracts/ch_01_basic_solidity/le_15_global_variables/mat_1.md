# Global Variables

![15.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_15_global_variables/15.0%20-%20COVER.png)

## Scene

With Hackana’s malicious attacks escalating, Neri feels the weight of the responsibility ahead. She's set to face Hackana in a digital battleground where every second counts, and every transaction's detail matters.

She begins preparing by studying Solidity Global Variables, which will be crucial for tracking important data like transaction origins, gas usage, and timestamps. These tools could be the key to understanding and countering Hackana’s next moves.

On her laptop, Neri develops a strategy:
"**Kapag kaya nating i-track ang mga detalye ng bawat transaksyon, mas mabilis natin silang matutukoy at mahaharang.**"

(_If we can track every transaction’s details, we can identify and block them faster._)

## Solidity Topics: Global Variables

![15.1 - Global Variables](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_15_global_variables/15.1.png)

## More Info about Global Variables

Solidity provides global variables that are built into the language and accessible in any contract. These variables provide information about the blockchain and transaction context.

### Some commonly used global variables:

- `msg.sender`: The address of the entity (user or contract) calling the function.
- `msg.value`: The amount of Ether sent with the function call (in wei).
- `block.timestamp`: The timestamp of the current block.
- `tx.gasprice`: The gas price of the transaction.
- `block.number`: The number of the current block.

### Global variables are essential in scenarios such as:

- Authenticating users (`msg.sender`).
- Logging transaction details (`block.timestamp, msg.value`).
- Setting execution limits (`tx.gasprice, block.number`).

### How to use

Global variables describe the transaction that is running **right now**, so you read them _inside a function_. Each call sees its own values.

- **Access caller information:** Use `msg.sender` to identify the source of the function call.

  Example: `caller = msg.sender;` (inside a function)

- **Log transaction timestamps:** Use `block.timestamp` to save the moment a transaction is executed.

  Example: `lastCalled = block.timestamp;` (inside a function)

- **Monitor gas execution costs:** Use `tx.gasprice` to check the gas price for transactions.

  Example: `lastGasPrice = tx.gasprice;` (inside a function)

> **Watch out: don't use them as state variable initializers.**
> A line like `address public caller = msg.sender;` written at the top of the contract runs **once, when the contract is deployed**. `caller` would then be the _deployer_ forever and would never track later callers. The same goes for `uint256 public t = block.timestamp;`, which freezes the deployment time.
>
> That is occasionally what you want (for example, recording the owner at deploy time), but if you want to track **each call**, assign inside a function as in the sample contract below.

### Sample contract

```solidity
contract GlobalVar {
  // Storing the address of the sender
  address public sender;

  // Function to update the sender variable
  function updateSender () public {
    // Update the sender variable with the address calling this function
    sender = msg.sender;
  }
}
```

### Explanation

This simple GlobalVar contract demonstrates how to use the `msg.sender` global variable in Solidity.

- `address public sender;` This line declares a public state variable named `sender` of type `address`. This variable will store the address of the user or contract that last called the `updateSender` function. Because it's declared as `public`, Solidity automatically creates a getter function for it, allowing anyone to read the value of `sender`.

- `function updateSender () public { ... }`: This defines a function named `updateSender`. The `public` keyword means anyone (any user or contract) can call this function.

- `sender = msg.sender;`: Inside the `updateSender` function, this is where the magic happens. `msg.sender` is a global variable that always contains the address of the account that initiated the transaction (i.e., the caller). This line assigns the value of `msg.sender` to the `sender` state variable, effectively updating the stored address.
