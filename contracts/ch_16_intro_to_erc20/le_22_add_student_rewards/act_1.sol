// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// ADD STUDENT REWARDS — Lesson 22
// by: <Your Name>
// ============================================
// This is your Lesson 21 token: WorkshopCredit is
// ERC20, Ownable, with an owner-only mint. Today you
// REPLACE the bare mint with rewardStudent — same
// onlyOwner lock, now writing a permanent, public
// REASON into the log via your own event.
// This starter compiles as shipped; fill the TODOs.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@5.0.2/access/Ownable.sol";

contract WorkshopCredit is ERC20, Ownable {
    // TODO (Task 1): declare your own event, above the constructor:
    //   event StudentRewarded(address indexed student, uint256 amount, string reason);
    // Index `student` (searchable); keep `amount` and `reason` non-indexed
    // (readable). Never index `reason` — a string topic is a hash, not text.

    constructor()
        ERC20("Workshop Credit", "WCR")
        Ownable(msg.sender)
    {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    // Replaces Lesson 21's bare `mint`. Same onlyOwner lock, now with a reason.
    function rewardStudent(address student, uint256 amount, string calldata reason)
        external
        onlyOwner
    {
        // TODO (Task 2):
        //   1. _mint(student, amount);                        // credits into the balance
        //   2. emit StudentRewarded(student, amount, reason); // the reason, on-chain forever
    }
}
