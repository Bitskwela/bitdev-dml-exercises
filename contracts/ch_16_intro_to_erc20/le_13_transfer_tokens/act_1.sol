// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// TRANSFER TOKENS — Lesson 13
// by: <Your Name>
// ============================================
// The WorkshopCredit token below is unchanged since
// Lesson 9. `transfer` is inherited from OpenZeppelin —
// you already have it, no code to write for a single
// move. Your job is ONE method that batches transfers:
// awardClass() loops `transfer` over a list of students
// so a single click pays a whole roster.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        _mint(msg.sender, 1000 * 10 ** decimals()); // 1,000 whole WCR
    }

    // Pay `amountEach` to every student on the list — from the CALLER's balance.
    function awardClass(address[] calldata students, uint256 amountEach) external {
        // TODO (Task 4): loop over `students` from index 0 to students.length and,
        // for each one, call transfer(students[i], amountEach).
        // transfer() is inherited and always spends msg.sender's own credits, so
        // awardClass hands out the caller's balance to the whole roster. No `from`
        // parameter exists — the sender is whoever signed this call.
    }
}
