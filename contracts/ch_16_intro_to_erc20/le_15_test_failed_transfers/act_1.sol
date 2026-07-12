// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// TEST FAILED TRANSFERS — Lesson 15
// by: <Your Name>
// ============================================
// This is your Lesson 9 WCR — a plain OpenZeppelin
// ERC-20. Its revert protection is already INHERITED:
// transfer() checks the balance internally and reverts
// with the custom error ERC20InsufficientBalance if you
// try to overspend. You never write that check.
//
// Today you add ONE friendly helper, sendExactly, that
// does a human-readable pre-check BEFORE calling transfer.
// It's a courtesy on top of the guard that already exists.
// This starter compiles as shipped; fill in the TODO.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        _mint(msg.sender, 1000 * 10 ** decimals()); // 1,000 whole WCR
    }

    // A friendly guard: check first with a human message, then transfer.
    function sendExactly(address to, uint256 amount) external {
        // TODO (Task 2):
        //   1. require(balanceOf(msg.sender) >= amount, "WCR: not enough credits");
        //   2. transfer(to, amount);
        // Note: even without the require, transfer() would still revert with
        // the inherited ERC20InsufficientBalance custom error — you're just
        // adding a friendlier, earlier message on top.
    }
}
