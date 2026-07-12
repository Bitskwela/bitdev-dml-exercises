// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// ADD STUDENT REWARDS — Full Solution
// Lesson 22 by Dan Santos
// ============================================
// The Lesson 21 owner-only mint grows a memo column.
// `mint` is replaced by `rewardStudent`, which mints
// the credits AND emits a custom StudentRewarded event
// carrying a human-readable reason. The reason is
// written by the same transaction that moves the
// credits, so amount and "why" live welded together
// in one immutable, public log entry:
//   - Transfer(0x0, student, amount)          <- from _mint (inherited)
//   - StudentRewarded(student, amount, reason) <- yours
// `student` is indexed (searchable); `reason` stays
// non-indexed so the plain text is readable, not hashed.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@5.0.2/access/Ownable.sol";

/// @title Workshop Credit (WCR)
/// @notice A transparent, instructor-issued points token for Dan's workshop.
/// @dev Only the owner can reward; every reward logs a permanent, public reason.
contract WorkshopCredit is ERC20, Ownable {
    // Our own event, on TOP of ERC-20's Transfer/Approval.
    // `student` is indexed (searchable); `reason` stays readable, not indexed.
    event StudentRewarded(address indexed student, uint256 amount, string reason);

    constructor()
        ERC20("Workshop Credit", "WCR")
        Ownable(msg.sender)
    {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    /// @notice Instructor-only: mint `amount` credits to `student` and record WHY.
    /// @dev Same onlyOwner lock as Lesson 21. Emits StudentRewarded so the reason
    ///      lives on-chain, immutable and public, next to the amount.
    function rewardStudent(address student, uint256 amount, string calldata reason)
        external
        onlyOwner
    {
        _mint(student, amount);                        // credits appear in the student's balance
        emit StudentRewarded(student, amount, reason); // the reason goes on-chain, forever
    }
}
