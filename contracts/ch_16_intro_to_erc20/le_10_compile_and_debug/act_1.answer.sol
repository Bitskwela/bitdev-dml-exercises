// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// COMPILE AND DEBUG — Full Solution
// Lesson 10 by Dan Santos
// ============================================
// This is the sabotaged starter with all THREE planted
// bugs repaired — which lands it back on the exact clean
// Lesson 9 contract. The three fixes, top-down:
//   BUG 1  pragma ^0.7.0  ->  ^0.8.20      (version match)
//   BUG 2  constructr     ->  constructor  (ParserError)
//   BUG 3  (missing line) ->  the import   (DeclarationError)
// Fix the topmost red first; each fix reveals the next.
// Compiles green under solc 0.8.20 + OpenZeppelin 5.0.2.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        _mint(msg.sender, 1000 * 10 ** decimals()); // 1,000 whole WCR
    }
}
