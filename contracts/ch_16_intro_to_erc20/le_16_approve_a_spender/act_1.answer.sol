// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// APPROVE A SPENDER — Full Solution
// Lesson 16 by Dan Santos
// ============================================
// The canonical Lesson 9 WorkshopCredit plus one helper:
// approveStore. approve() is inherited from ERC20 — it
// records allowance[owner][spender] = amount and emits
// Approval(owner, spender, value). It moves ZERO tokens:
// the note, never the payment. The owner is msg.sender,
// so a caller can only ever approve away their OWN credits.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        _mint(msg.sender, 1000 * 10 ** decimals()); // 1,000 whole WCR
    }

    // Authorize `store` to pull up to `amount` of the caller's own credits.
    // msg.sender (the caller) is the owner recorded in the allowance.
    function approveStore(address store, uint256 amount) external returns (bool) {
        return approve(store, amount);
    }
}
