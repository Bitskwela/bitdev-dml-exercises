// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// CHECK ALLOWANCES — Full Solution
// Lesson 17 by Dan Santos
// ============================================
// The canonical Lesson 9 WorkshopCredit plus one read
// helper: remainingFor. allowance() is inherited from
// ERC20 — a free view that returns allowances[owner][spender],
// the remaining budget a spender may still pull. Any pair
// never approved reads back 0. It moves ZERO tokens: a
// permission read, never a payment.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        _mint(msg.sender, 1000 * 10 ** decimals()); // 1,000 whole WCR
    }

    // Free, public read of the remaining allowance for the (owner_, spender) pair.
    function remainingFor(address owner_, address spender) external view returns (uint256) {
        return allowance(owner_, spender);
    }
}
