// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// APPROVE A SPENDER — Lesson 16
// by: <Your Name>
// ============================================
// This is the canonical Lesson 9 WorkshopCredit (a plain
// OpenZeppelin ERC-20 that mints 1,000 whole WCR to the
// deployer) plus ONE new helper: approveStore.
//
// approve(), allowance(), and transferFrom() are all
// inherited for free from ERC20 — nothing to reimplement.
// Your job is only to forward to the inherited approve().
// The starter compiles as shipped; finish the TODO.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        _mint(msg.sender, 1000 * 10 ** decimals()); // 1,000 whole WCR
    }

    // Let the CALLER authorize `store` to pull up to `amount` of the caller's
    // own credits later (via transferFrom). This writes the note; it moves
    // zero tokens and emits Approval(owner, spender, value).
    function approveStore(address store, uint256 amount) external returns (bool) {
        // TODO (Task 1): return the result of the inherited approve(store, amount).
        // Because approveStore is called BY the owner, msg.sender inside approve
        // is that same owner — so the allowance recorded is the caller's credits,
        // granted to `store`. Return the bool that approve hands back.
        return false; // placeholder so the starter compiles — replace with the real approve call
    }
}
