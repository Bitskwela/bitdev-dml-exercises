# Task for Learners

Create an ERC20 token called `SanJuanToken` to be used by the local community for seamless transactions. Ensure that the token complies with the ERC20 standard and has basic functionality.

## Smart Contract Activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 🚩 TODO: Import OpenZeppelin's ERC20 implementation
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// 🚩 ANSWER: Define the contract and inherit from ERC20
contract SanJuanToken is ERC20 {
    // 🚩 ANSWER: Constructor to initialize the token
    constructor(uint256 initialSupply) ERC20("SanJuanToken", "SJT") {
        _mint(msg.sender, initialSupply);
    }
}
```

### Breakdown of Activity

- **Import OpenZeppelin’s ERC20 Library**:
  Use OpenZeppelin’s implementation to simplify the process and ensure security.
- **Define the Token Contract**:
  Inherit from the ERC20 contract to get access to its predefined functionalities.
- **Constructor Initialization**:
  Name the token _SanJuanToken_ with the symbol _SJT_.
  Mint an initial supply of tokens to the deployer’s address.

### Closing Story

With the launch of **SanJuanToken**, Neri witnesses a revolutionary shift in the city. Vendors, jeepney drivers, and even local artists use the token to trade goods, services, and ideas.

The community is stronger, and Hackana's grip weakens further as Neri's systems gain resilience and trust. She knows the battle isn't over, but for now, she smiles, watching her city thrive through the power of decentralized technology.
