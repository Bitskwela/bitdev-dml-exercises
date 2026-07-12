// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// UNDERSTAND TOKEN DECIMALS — Full Solution
// Lesson 9 by Dan Santos
// ============================================
// decimals() defaults to 18 and is display-only — it
// changes NOTHING on-chain. On-chain, everything is a
// whole-number uint256 in BASE UNITS. To mint 1,000
// WHOLE credits, convert to base units:
//   1000 * 10 ** decimals()  ==  1000000000000000000000
// The naive Lesson 8 mint of plain 1000 was really
// 0.000000000000001000 WCR — a speck. This is the fix.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        _mint(msg.sender, 1000 * 10 ** decimals()); // 1,000 whole WCR
    }
}
