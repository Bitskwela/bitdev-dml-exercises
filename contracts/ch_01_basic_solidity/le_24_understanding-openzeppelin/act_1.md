# Smart Contract Activity

Using OpenZeppelin, let’s create an ERC20 token

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HackanaDefenseToken {
    constructor() {}
}
```

## Task for Learners

Neri needs your help to create a new ERC20 token using OpenZeppelin. This will be the currency used for rebuilding systems destroyed by Hackana.

- Import the ERC20 contract from OpenZeppelin.

  ```solidity
  import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
  ```

- Create a custom token contract named `HackanaDefenseToken` that inherits from OpenZeppelin’s ERC20. In the constructor, initialize the token with a name (_DefenseToken_) and symbol (_DEF_). Lastly, mint an initial supply of 1000 tokens to the deployer’s address.

  ```solidity
  contract HackanaDefenseToken is ERC20 {
      constructor() ERC20("DefenseToken", "DEF") {
          _mint(msg.sender, 1000 * 10 ** decimals());
      }
  }
  ```

### Breakdown of Activity

**Imports**

```solidity
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
```

Allows the contract to inherit OpenZeppelin’s ERC20 implementation.

**Constructor**

Initializes the token with a name (_DefenseToken_), symbol (_DEF_), and initial supply.

`msg.sender`: The account deploying the contract receives the initial supply.

**Mint Function**

```solidity
_mint(msg.sender, 1000 * 10 ** decimals());
```

Mints 1000 tokens and assigns them to msg.sender.

**ERC20 Benefits**

- Handles token transfers, approvals, and balances securely.
- Prevents common vulnerabilities like reentrancy.

### Closing Story

As Neri introduces the DefenseToken to the community, she sees a spark of hope reignite in their eyes. Vendors in the palengke begin using the token for transactions, jeepney drivers adopt it for QR-based fares, and even barangay halls accept it for local permits.

With OpenZeppelin’s robust framework ensuring security, Neri manages to establish trust among the people, reassuring them that their funds are safe. The token quickly becomes a symbol of resilience, uniting San Juan City against Hackana’s looming threat.

Hackana, sensing the city’s newfound strength, deploys a malicious smart contract to disrupt the DefenseToken network. But Neri’s preparations, backed by OpenZeppelin’s audited code, ensure the token holds strong.

San Juan begins to rebuild stronger than ever, and Neri knows she’s one step closer to vanquishing Hackana for good.
