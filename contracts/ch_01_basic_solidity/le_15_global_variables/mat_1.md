# Global Variables

## Scene

With Hackana’s malicious attacks escalating, Neri feels the weight of the responsibility ahead. She's set to face Hackana in a digital battleground where every second counts, and every transaction's detail matters.

She begins preparing by studying Solidity Global Variables, which will be crucial for tracking important data like transaction origins, gas usage, and timestamps. These tools could be the key to understanding and countering Hackana’s next moves.

On her laptop, Neri develops a strategy:
"**Kapag kaya nating i-track ang mga detalye ng bawat transaksyon, mas mabilis natin silang matutukoy at mahaharang.**"

(_If we can track every transaction’s details, we can identify and block them faster._)

## Solidity Topics: Global Variables

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

- **Access caller information:** Use msg.sender to identify the source of the function call.

  Example: `address public caller = msg.sender;`

- **Log transaction timestamps:** Use block.timestamp to save the moment a transaction is executed.

  Example: `uint256 public currentTime = block.timestamp;`

- **Monitor gas execution costs:** Use tx.gasprice to check the gas price for transactions.

  Example: `uint256 public gasPrice = tx.gasprice;`

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
