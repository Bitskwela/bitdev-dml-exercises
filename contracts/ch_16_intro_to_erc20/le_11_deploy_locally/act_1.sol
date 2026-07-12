// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// DEPLOY LOCALLY — Lesson 11
// by: <Your Name>
// ============================================
// This is the same WorkshopCredit you've built since
// Lesson 9 — nothing new is added this lesson. The one
// job before you deploy: set the starting supply so the
// constructor mints a real 1,000 WHOLE credits to you,
// the deployer. The mint amount is left as a TODO on
// purpose. As shipped it mints 0, so it COMPILES — but
// deploy it as-is and totalSupply reads 0. Fill in the
// amount first, THEN deploy on the Remix VM.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        // TODO (Task 1): mint 1,000 WHOLE credits to the deployer (msg.sender).
        // Remember Lesson 9: on-chain amounts are in BASE UNITS, so convert
        // the human amount with 10 ** decimals(). Replace the 0 below with:
        //     1000 * 10 ** decimals()
        _mint(msg.sender, 0);
    }
}
