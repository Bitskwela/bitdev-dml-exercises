// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// CREATE THE INITIAL SUPPLY — Full Solution
// Lesson 8 by Dan Santos
// ============================================
// _mint writes the ledger's first line: it creates
// credits AND raises totalSupply by the same amount,
// atomically. msg.sender in the constructor is the
// deployer. The 1000 here is NAIVE on purpose — it
// displays as 0.000000000000001000 WCR, and Lesson 9
// explains and fixes it with base units.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        _mint(msg.sender, 1000); // naive — Lesson 9 explains why this shows as 0.000...1000 WCR
    }
}
