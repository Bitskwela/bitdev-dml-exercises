// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// SPEND WITH transferFrom — Lesson 18
// by: <Your Name>
// ============================================
// The token is UNCHANGED since Lesson 9 — transfer,
// approve, allowance, and transferFrom are all inherited
// from OpenZeppelin's ERC20. Your only job is the body of
// `collectFrom`: the store's move, wrapped into one call.
//
// The starter COMPILES as shipped (an empty body is legal),
// but collectFrom does nothing until you fill it in.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        // 1,000 whole credits to the deployer, in base units.
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    /// @notice Pull `amount` of `from`'s credits to the caller (the spender).
    function collectFrom(address from, uint256 amount) external {
        // TODO (Task 1): forward this to the inherited transferFrom so the
        // caller (msg.sender = the spender/store) pulls `amount` OUT of `from`
        // and INTO itself. Remember the three roles of transferFrom:
        //     transferFrom( from , to , amount )
        //   - `from`       is the owner whose balance drops
        //   - the recipient should be msg.sender (whoever is collecting)
        //   - `amount`     is how many base units to pull
        // One line:
        //     transferFrom(from, msg.sender, amount);
        // transferFrom will check the allowance FIRST, spend it, then move the
        // credits — reverting ERC20InsufficientAllowance if you pull over the cap.
    }
}
