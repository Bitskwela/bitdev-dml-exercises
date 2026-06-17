# Smart Contract Activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
```

## Task for Learners

Create an ERC20 token for the local community to use for seamless transactions. Ensure the token complies with the ERC20 standard and has basic functionality.

- Import OpenZeppelin's ERC20 implementation.

  ```solidity
  import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
  ```

- Create a contract named `SanJuanCityToken` that inherits from `ERC20`. The contract **must** be named `SanJuanCityToken` — that is the name the grader checks (the token's display name is set separately, below).

- In the constructor, set the token name to `SanJuanToken` and the symbol to `SJC`, then mint an initial supply of 1000 tokens to the deployer.

  ```solidity
  contract SanJuanCityToken is ERC20 {
      constructor() ERC20("SanJuanToken", "SJC") {
          _mint(msg.sender, 1000 * 10 ** decimals());
      }
  }
  ```

### Breakdown of Activity

- **Import OpenZeppelin’s ERC20 Library**:
  Use OpenZeppelin’s implementation to simplify the process and ensure security.
- **Define the Token Contract**:
  Inherit from the ERC20 contract to get access to its predefined functionalities.
- **Constructor Initialization**:
  Name the token _SanJuanToken_ with the symbol _SJC_.
  Mint an initial supply of tokens to the deployer’s address.

### Closing Story

With the launch of **SanJuanToken**, Neri witnesses a revolutionary shift in the city. Vendors, jeepney drivers, and even local artists use the token to trade goods, services, and ideas.

The community is stronger, and Hackana's grip weakens further as Neri's systems gain resilience and trust. She knows the battle isn't over, but for now, she smiles, watching her city thrive through the power of decentralized technology.
