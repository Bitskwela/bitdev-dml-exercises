// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// SPEND WITH transferFrom — Full Solution
// Lesson 18 by Dan Santos
// ============================================
// The token itself is UNCHANGED since Lesson 9 —
// transfer, approve, allowance, AND transferFrom all
// come free from OpenZeppelin's ERC20. The only new
// code is `collectFrom`: a one-line wrapper that lets
// a SPENDER pull an owner's approved credits to itself.
//
//   collectFrom(from, amount)
//     -> transferFrom(from, msg.sender, amount)
//        - `from`       = the owner whose balance drops
//        - `msg.sender` = the caller/spender, who receives
//     -> requires `from` approved the caller first
//     -> spends (decreases) the allowance by `amount`
//     -> reverts ERC20InsufficientAllowance if over the cap
//
// This is exactly the move RewardStore makes in Lesson
// 19-20: credit.transferFrom(buyer, address(this), price).
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        // 1,000 whole credits to the deployer (the instructor), in base units.
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    /// @notice Pull `amount` of `from`'s credits to the caller (the spender).
    /// @dev The caller must have been approve()'d by `from` for at least
    ///      `amount`. transferFrom spends that allowance and moves the credits;
    ///      an over-the-cap pull reverts with ERC20InsufficientAllowance.
    function collectFrom(address from, uint256 amount) external {
        transferFrom(from, msg.sender, amount);
    }
}
