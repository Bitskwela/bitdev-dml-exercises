// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// INSPECT TRANSFER EVENTS — Full Solution
// Lesson 14 by Dan Santos
// ============================================
// This is the Lesson 9 WCR — a plain OpenZeppelin
// ERC-20 — plus one practice method. You do NOT
// declare the Transfer event: it is inherited, and
// _mint and transfer fire it for you automatically.
// On top of that, you declare your OWN event to
// record the one thing Transfer can't: the WHY.
//   - Transfer(from, to, value)  -> who / how much
//   - CreditsAwarded(to, amount, note) -> the reason
// awardWithNote does a transfer AND emits your note,
// so one call leaves two receipts on the log.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    // Your own event. `indexed` on `to` makes it searchable by recipient,
    // exactly like Transfer indexes `from` and `to`. `note` rides in data.
    event CreditsAwarded(address indexed to, uint256 amount, string note);

    constructor() ERC20("Workshop Credit", "WCR") {
        // This line alone emits a Transfer FROM the zero address (a mint).
        _mint(msg.sender, 1000 * 10 ** decimals()); // 1,000 whole WCR
    }

    // Award credits and leave a human-readable reason on the public log.
    function awardWithNote(address to, uint256 amount, string calldata note) external {
        transfer(to, amount);                  // fires the inherited Transfer event
        emit CreditsAwarded(to, amount, note); // your extra receipt: the "why"
    }
}
