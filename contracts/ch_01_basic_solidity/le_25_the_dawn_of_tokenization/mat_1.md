# The Dawn of Tokenization

## Scene

Neri, now hailed as San Juan City's blockchain hero, sits in her newly established command center—a modest coworking space above the Museo ng Katipunan. With Hackana's influence waning, the city is rebuilding its trust in digital systems.

But Neri knows this is just the beginning. To empower the community even further, she decides to create a standardized digital token to fuel local commerce and incentivize collaboration.

She recalls her learnings about ERC20 tokens, the standard for fungible tokens, and realizes its potential to transform the city’s economy.

### Solidity Topic: ERC20 Standard

The ERC20 standard is a blueprint for creating fungible tokens on the Ethereum blockchain. Tokens created using this standard are interchangeable, like traditional currency, ensuring compatibility across platforms and wallets.

### More Info About ERC20

The ERC20 standard is a set of rules and functionalities that a token must implement to be interoperable with other applications, wallets, and exchanges on the Ethereum blockchain. This standard is widely adopted, making it easier for developers to create and interact with fungible tokens.

### Key Components of ERC20:

**Functions in ERC20:**

- `totalSupply()`: Returns the total supply of tokens.
- `balanceOf(address account)`: Returns the token balance of a specific address.
- `transfer(address recipient, uint256 amount)`: Transfers tokens from the caller's address to a recipient.
- `approve(address spender, uint256 amount)`: Authorizes another account to spend a specific number of tokens on behalf of the caller.
- `allowance(address owner, address spender)`: Returns the remaining tokens that the spender is allowed to use from the owner's account.
- `transferFrom(address sender, address recipient, uint256 amount)`: Allows a spender to transfer tokens from an owner's account to another address.

**Events:**

- `Transfer(address indexed from, address indexed to, uint256 value)`: Emitted when tokens are transferred.
- `Approval(address indexed owner, address indexed spender, uint256 value)`: Emitted when an approval is set or updated.

**Interoperability:**

- ERC20 tokens can be integrated seamlessly into existing wallets (like MetaMask) and exchanges without additional development.

**Customizability:**

- Developers can extend the ERC20 standard to include features like tax mechanisms, deflationary properties, or governance functionalities.

#### Why Use ERC20?:

**Fungibility:** Ensures all tokens of a type are equivalent and interchangeable.

**Standardization:** Simplifies token integration with other smart contracts and platforms.

**Ease of Development:** OpenZeppelin provides robust and audited implementations of the ERC20 standard, saving time and improving security.

#### Example of Token Behavior

Imagine a local marketplace:

- A token like **SanJuanToken** can be used by vendors to receive payments.
- Customers transfer tokens using the transfer function.
- Vendors might set up automatic deductions or recurring payments by using the approve and `transferFrom` functions.
