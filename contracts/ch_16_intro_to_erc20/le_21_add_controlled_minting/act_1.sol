// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// ADD CONTROLLED MINTING — Lesson 21
// by: <Your Name>
// ============================================
// This is your Lesson 9 WCR — a plain OpenZeppelin
// ERC-20 that mints 1,000 WCR to the deployer. Today
// you lock the money printer: make the token Ownable
// and add a mint that ONLY the owner can call.
// Both imports are ready; this starter compiles as
// shipped (Ownable is imported but not yet wired).
// Fill the TODOs and it becomes the controlled token.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@5.0.2/access/Ownable.sol";

// TODO (Task 1a): add `, Ownable` after ERC20 so this reads:
//   contract WorkshopCredit is ERC20, Ownable
contract WorkshopCredit is ERC20 {
    constructor()
        ERC20("Workshop Credit", "WCR")
        // TODO (Task 1b): add `Ownable(msg.sender)` here — OZ v5 requires
        // naming the first owner; msg.sender = the deployer = the instructor.
    {
        _mint(msg.sender, 1000 * 10 ** decimals()); // 1,000 whole WCR (unchanged)
    }

    // TODO (Task 2): add an owner-only mint. It MUST carry the onlyOwner
    // modifier (the lock) and create new credits with _mint:
    //   function mint(address to, uint256 amount) external onlyOwner {
    //       _mint(to, amount);
    //   }
}
