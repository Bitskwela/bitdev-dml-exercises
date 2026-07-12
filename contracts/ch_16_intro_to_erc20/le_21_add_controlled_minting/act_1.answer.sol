// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// ADD CONTROLLED MINTING — Full Solution
// Lesson 21 by Dan Santos
// ============================================
// The Lesson 9 WCR gains two powers at once:
//   1. it becomes Ownable — exactly one privileged
//      "owner" address, set to the deployer at launch.
//   2. it gains an owner-only `mint`, so the instructor
//      can create credits for newcomers AFTER deploy.
// The lock is `onlyOwner`: a non-owner call to mint
// reverts with OwnableUnauthorizedAccount(caller)
// BEFORE _mint ever runs — nothing minted, no state
// touched. And owner() is public, so the whole barangay
// can read who holds the key. Controlled, and visible.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@5.0.2/access/Ownable.sol";

/// @title Workshop Credit (WCR)
/// @notice A transparent, instructor-issued points token for Dan's workshop.
/// @dev The deployer becomes the owner; only the owner can mint new credits.
contract WorkshopCredit is ERC20, Ownable {
    // The deployer is set as owner (Ownable(msg.sender)) AND receives the
    // initial 1,000 WCR. decimals() defaults to 18.
    constructor()
        ERC20("Workshop Credit", "WCR")
        Ownable(msg.sender)
    {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    /// @notice Instructor-only: create new credits and send them to `to`.
    /// @dev onlyOwner is the lock. A non-owner call reverts with
    ///      OwnableUnauthorizedAccount(caller) before _mint ever runs.
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
