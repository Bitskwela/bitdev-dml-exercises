// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// INSPECT TRANSFER EVENTS — Lesson 14
// by: <Your Name>
// ============================================
// This is your Lesson 9 WCR — a plain OpenZeppelin
// ERC-20. It already emits a `Transfer` event on every
// mint and transfer, for free — you never wrote that.
// Today you add ONE of your own events plus a helper
// that fires it, so a single call leaves two receipts
// on the public log: the automatic Transfer (who / how
// much) and your CreditsAwarded (the reason WHY).
// This starter compiles as shipped; fill in the TODOs.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    // TODO (Task 1): declare your own event, above the constructor:
    //   event CreditsAwarded(address indexed to, uint256 amount, string note);
    // `indexed` on `to` makes it searchable by recipient; `note` rides in data.

    constructor() ERC20("Workshop Credit", "WCR") {
        _mint(msg.sender, 1000 * 10 ** decimals()); // 1,000 whole WCR
    }

    // Award credits AND leave a human-readable reason on the log.
    function awardWithNote(address to, uint256 amount, string calldata note) external {
        // TODO (Task 2):
        //   1. call transfer(to, amount);        // fires the inherited Transfer event
        //   2. emit CreditsAwarded(to, amount, note);  // your extra receipt
    }
}
