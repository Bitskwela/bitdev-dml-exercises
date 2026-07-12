// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// CREATE THE INITIAL SUPPLY — Lesson 8
// by: <Your Name>
// ============================================
// Your Lesson 7 token already knows its name and
// symbol — it just holds ZERO credits. Write the
// ledger's first line: mint yourself a starting pile
// the moment the token is born.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        // TODO (Task 1): mint the starting supply to the deployer.
        // Call _mint(msg.sender, 1000).
        //   - _mint is inherited from ERC20 (internal — no Remix button).
        //   - The constructor runs ONCE, at deploy, so msg.sender here is
        //     the account that deployed this contract (you).
        //   - It raises balanceOf(msg.sender) AND totalSupply by 1000.
        // Yes, plain 1000 for now. It will read back as a strange sliver
        // (0.000000000000001000 WCR) — that is the whole point of the
        // lesson, and Lesson 9 fixes it.
    }
}
