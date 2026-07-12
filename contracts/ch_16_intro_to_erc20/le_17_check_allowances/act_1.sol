// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// CHECK ALLOWANCES — Lesson 17
// by: <Your Name>
// ============================================
// This is the canonical Lesson 9 WorkshopCredit (a plain
// OpenZeppelin ERC-20 that mints 1,000 whole WCR to the
// deployer) plus ONE new read helper: remainingFor.
//
// allowance(), approve(), and transferFrom() are all
// inherited for free from ERC20. Your job is only to
// forward to the inherited allowance() view.
// The starter compiles as shipped; finish the TODO.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        _mint(msg.sender, 1000 * 10 ** decimals()); // 1,000 whole WCR
    }

    // Report how much `spender` may still pull from `owner_`. A free view:
    // it reads the allowances[owner_][spender] note and moves no tokens.
    // (owner_ has a trailing underscore to avoid clashing with names used
    // inside some OpenZeppelin contracts.)
    function remainingFor(address owner_, address spender) external view returns (uint256) {
        // TODO (Task 1): return the result of the inherited allowance(owner_, spender).
        // It looks up the (owner_, spender) pair and returns the remaining budget in
        // base units — or 0 if that pair was never approved.
        return 0; // placeholder so the starter compiles — replace with the real allowance call
    }
}
