// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// TEST FAILED TRANSFERS — Full Solution
// Lesson 15 by Dan Santos
// ============================================
// This is the Lesson 9 WCR — a plain OpenZeppelin
// ERC-20 — plus one practice method. The revert
// protection is entirely INHERITED: transfer() checks
// fromBalance >= value inside OpenZeppelin and, if it
// fails, reverts with the v5 CUSTOM ERROR
//   ERC20InsufficientBalance(sender, balance, needed)
// carrying the real numbers. You never wrote that check.
//
// sendExactly adds a FRIENDLY require on top with a
// human message. It is a courtesy, not the safety net:
// delete it and transfer() still reverts with the
// inherited custom error. The require just fails one
// step earlier with a beginner-readable string.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        _mint(msg.sender, 1000 * 10 ** decimals()); // 1,000 whole WCR
    }

    // A friendly guard: check first, then transfer. The require message is
    // human-friendly; the inherited ERC20InsufficientBalance is the real,
    // unremovable protection underneath.
    function sendExactly(address to, uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "WCR: not enough credits");
        transfer(to, amount);
    }
}
