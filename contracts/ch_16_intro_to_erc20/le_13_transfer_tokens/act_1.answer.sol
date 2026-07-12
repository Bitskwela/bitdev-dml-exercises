// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// TRANSFER TOKENS — Full Solution
// Lesson 13 by Dan Santos
// ============================================
// The base WorkshopCredit is the canonical Lesson 9
// token (mints 1,000 whole WCR in base units). `transfer`
// is inherited from OpenZeppelin — a single move needs no
// new code. Added here: awardClass(), which loops
// `transfer` over a roster so one transaction pays a whole
// class. Every iteration spends msg.sender's own balance —
// there is no `from`, the sender is whoever signs the call.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        _mint(msg.sender, 1000 * 10 ** decimals()); // 1,000 whole WCR
    }

    // Pay `amountEach` to every student on the list — from the CALLER's balance.
    function awardClass(address[] calldata students, uint256 amountEach) external {
        for (uint256 i = 0; i < students.length; i++) {
            transfer(students[i], amountEach);
        }
    }
}
