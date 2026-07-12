// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// WHAT IS A TOKEN? — Full Solution
// Lesson 1 by Dan Santos
// ============================================
// A token is a LEDGER of who-holds-how-much.
// balanceOf is the listahan; award adds a line;
// transfer moves credits between names.
// ============================================
contract WorkshopLedger {
    // The whole "token": a public list of balances anyone can read.
    mapping(address => uint256) public balanceOf;

    // How many credits exist across everyone.
    uint256 public totalCredits;

    // Dan hands out credits for finished work. (Real "only Dan can mint"
    // access control arrives in Lesson 21; today is about the ledger itself.)
    function award(address student, uint256 amount) public {
        balanceOf[student] += amount;
        totalCredits += amount;
    }

    // Move credits from the caller to someone else — the barest "transfer".
    function transfer(address to, uint256 amount) public {
        require(balanceOf[msg.sender] >= amount, "not enough credits");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        // totalCredits is unchanged — a transfer moves credits, never creates them.
    }
}
