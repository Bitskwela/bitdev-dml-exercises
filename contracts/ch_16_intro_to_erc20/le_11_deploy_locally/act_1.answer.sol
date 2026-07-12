// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// DEPLOY LOCALLY — Full Solution
// Lesson 11 by Dan Santos
// ============================================
// Nothing new is added this lesson — this is the exact
// clean WorkshopCredit from Lesson 9. Deploying it IS
// the lesson: push it to the Remix VM, read the receipt,
// and watch it get a contract address of its own.
//   - decimals() is 18 by default, so 1,000 WCR is
//     1000 * 10 ** decimals() base units.
//   - The deployer (msg.sender) receives the full
//     starting supply at the moment of deploy.
// Compiles green under solc 0.8.20 + OpenZeppelin 5.0.2.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        _mint(msg.sender, 1000 * 10 ** decimals()); // 1,000 whole WCR to the deployer
    }
}
