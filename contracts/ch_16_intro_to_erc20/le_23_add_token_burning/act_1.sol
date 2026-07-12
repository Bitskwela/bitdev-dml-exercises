// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// ADD TOKEN BURNING — Lesson 23
// by: <Your Name>
// ============================================
// This is the Lesson 22 WorkshopCredit: metadata, a
// 1,000 WCR starting supply, onlyOwner minting, and
// rewardStudent with a reason. All of that is DONE and
// untouched — do not change it.
//
// Your job is the last two functions: teach the token to
// BURN. burn() and burnFrom() destroy credits and drop
// totalSupply — the exact mirror of _mint.
//
// The starter COMPILES as shipped (an empty body is legal),
// but burn/burnFrom do nothing until you fill them in.
//
// RewardStore.sol (in this folder) already calls
// credit.burn(item.price) on every redemption — deploy it
// against your finished token to watch totalSupply fall.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@5.0.2/access/Ownable.sol";

contract WorkshopCredit is ERC20, Ownable {
    event StudentRewarded(address indexed student, uint256 amount, string reason);

    constructor()
        ERC20("Workshop Credit", "WCR")
        Ownable(msg.sender)
    {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    /// @notice Instructor-only: issue new credits to a student, with a reason.
    function rewardStudent(address student, uint256 amount, string calldata reason)
        external
        onlyOwner
    {
        _mint(student, amount);
        emit StudentRewarded(student, amount, reason);
    }

    /// @notice Burn your OWN credits (the RewardStore calls this on each redemption).
    function burn(uint256 amount) external {
        // TODO (Task 1): destroy `amount` of the CALLER's own credits.
        // Call the inherited internal helper _burn on msg.sender — mint's mirror:
        //     _burn(msg.sender, amount);
        // msg.sender's balance drops AND totalSupply drops. No onlyOwner:
        // burning your own credits is always allowed.
    }

    /// @notice Burn credits from `account`, drawing on the caller's approved allowance.
    function burnFrom(address account, uint256 amount) external {
        // TODO (Task 2): the mirror of transferFrom — two internal calls, IN ORDER:
        //   1. _spendAllowance(account, _msgSender(), amount);  // check + deduct allowance
        //   2. _burn(account, amount);                          // then destroy the credits
        // Step 1 reverts with ERC20InsufficientAllowance if the caller
        // wasn't approved by `account` for at least `amount`.
    }
}
