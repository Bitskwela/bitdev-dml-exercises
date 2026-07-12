// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// WHAT IS A TOKEN? — Lesson 1
// by: <Your Name>
// ============================================
// A token, stripped of all hype, is a LEDGER of
// who-holds-how-much. No ERC-20, no OpenZeppelin
// yet — just the idea, in plain Solidity.
// ============================================
contract WorkshopLedger {
    // TODO (Task 1): declare a PUBLIC mapping from address to uint256
    // named `balanceOf`. This single line IS the token — the listahan
    // of who holds how many credits, readable by anyone.

    // TODO (Task 2): declare a PUBLIC uint256 named `totalCredits` —
    // how many credits exist across everyone.

    // Dan hands out credits for finished work.
    function award(address student, uint256 amount) public {
        // TODO (Task 3): add `amount` to balanceOf[student] AND to totalCredits.
    }

    // Move credits from the caller to someone else — the barest "transfer".
    function transfer(address to, uint256 amount) public {
        // TODO (Task 4):
        //   1. require balanceOf[msg.sender] >= amount, "not enough credits"
        //   2. subtract `amount` from balanceOf[msg.sender], add it to balanceOf[to]
    }
}
