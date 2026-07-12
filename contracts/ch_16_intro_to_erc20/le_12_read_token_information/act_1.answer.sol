// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// READ TOKEN INFORMATION — Full Solution
// Lesson 12 by Dan Santos
// ============================================
// The base WorkshopCredit is the canonical Lesson 9
// token (mints 1,000 whole WCR in base units). Added
// here: creditSummary(), a `view` function that bundles
// name/symbol/decimals/totalSupply into ONE gasless
// call. It only reads, so it costs no gas, signs no
// transaction, and anyone can call it — that IS the
// transparency.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        _mint(msg.sender, 1000 * 10 ** decimals()); // 1,000 whole WCR
    }

    // One click, four answers: name, symbol, decimals, totalSupply.
    // All four are inherited reads — this just returns them together.
    function creditSummary() external view returns (string memory, string memory, uint8, uint256) {
        return (name(), symbol(), decimals(), totalSupply());
    }
}
