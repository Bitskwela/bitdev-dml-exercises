// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// READ TOKEN INFORMATION — Lesson 12
// by: <Your Name>
// ============================================
// The WorkshopCredit token below is unchanged since
// Lesson 9 — it already exposes name(), symbol(),
// decimals(), totalSupply(), and balanceOf() for free
// from OpenZeppelin's ERC20. Your job is ONE small
// read-only function that bundles the reads into a
// single gasless call: creditSummary().
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        _mint(msg.sender, 1000 * 10 ** decimals()); // 1,000 whole WCR
    }

    // Return the token's identity card in ONE gasless call.
    function creditSummary() external view returns (string memory, string memory, uint8, uint256) {
        // TODO (Task 2): return the four inherited reads as a tuple, in order:
        //     name(), symbol(), decimals(), totalSupply()
        // Keep it `view` — it only LOOKS, so it must stay free and callable by
        // anyone. Replace the placeholder below with the real four values.
        return ("", "", 0, 0);
    }
}
