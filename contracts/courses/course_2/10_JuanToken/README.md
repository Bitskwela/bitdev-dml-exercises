# Sidequest #10: Barangay Tokenization (ERC20 Implementation)

## Backstory:

The bustling barangays of San Juan are struggling with financial fragmentation as they recover from Hackana's lingering disruptions. Neri proposes JuanToken, a fungible digital currency adhering to the ERC20 standard. It can streamline transactions, empower local businesses, and help rebuild trust in the digital economy.

But implementing a robust, secure token isn't trivial—it requires precision, adherence to standards, and proper use of existing tools. Neri has tasked learners with creating JuanToken, ensuring it follows the full ERC20 standard using OpenZeppelin's robust libraries.

## Problem Overview:

You must implement JuanToken, a fully compliant ERC20 token using OpenZeppelin's library. This token must:

- Be mintable by the contract owner.
- Support transfers and balance checks.
- Emit events for transparency.
- Be easily deployable and ready for real-world use.

## Time allotment: 20 minutes

## Solidity Topics Covered:

- OpenZeppelin ERC20 Library – For secure token implementation.
- Inheritance – Extending OpenZeppelin's ERC20 contract.
- Access Control – Managing permissions for minting tokens.
- Events – Emitting events for token transfers and minting.

## Code Activity:

Complete the `JuanToken` contract to add the minting functionality and ensure owner-only access for minting.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 🚩 TODO: Import ERC20 and Ownable from OpenZeppelin
// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

// 🚩 TODO: Extend ERC20 and Ownable in the contract
contract JuanToken {
    // Add a mint function that can only be called by the contract owner
}
```

## Checklist for Learners:

- Imported ERC20 and Ownable from OpenZeppelin.
- Extended the ERC20 and Ownable contracts.
- Implemented a mint function accessible only by the owner.
- Used `_mint` from OpenZeppelin to mint tokens securely.

## Hints:

- Import OpenZeppelin's `ERC20` library using the import statement.
- Use OpenZeppelin’s `ERC20` and `Ownable` contracts for a secure implementation.
- Use the `mint` function in the derived contract, accessible only to the owner.
- OpenZeppelin provides reusable and audited code. Use `ERC20` for token functionality and Ownable to control access.
- Use the `onlyOwner` modifier provided by `Ownable` to restrict minting.
- Remember to initialize the token’s name and symbol in the constructor.

## Expected answer (flagged)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract JuanToken is ERC20, Ownable {
    constructor() ERC20("JuanToken", "JUAN") Ownable(msg.sender) {}

    function mint(address to, uint256 amount) public onlyOwner {
        // 🏁 ANSWER: Mint tokens to the specified address
        _mint(to, amount);
    }
}
```

## Final thoughts

By completing this task, you’ll have implemented a secure, real-world ERC20 token with minimal custom logic while leveraging OpenZeppelin's library. This setup mimics how tokens like **USDT** or **DAI** are implemented.
