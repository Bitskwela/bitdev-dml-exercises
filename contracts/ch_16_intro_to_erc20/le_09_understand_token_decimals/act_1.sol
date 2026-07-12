// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// UNDERSTAND TOKEN DECIMALS — Lesson 9
// by: <Your Name>
// ============================================
// Your Lesson 8 token minted a naive 1000 — which a
// wallet reads as 0.000000000000001000 WCR, a speck.
// The fix is one multiplication: convert the human
// amount into BASE UNITS with 10 ** decimals().
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        // TODO (Task 2): this naive mint creates 1000 BASE UNITS, which a
        // wallet shows as 0.000000000000001000 WCR — a sliver, not a
        // thousand. Convert it into 1,000 WHOLE credits by multiplying the
        // amount by 10 ** decimals():
        //     _mint(msg.sender, 1000 * 10 ** decimals());
        // decimals() returns 18, so 10 ** decimals() is the number of base
        // units in one whole WCR. Let the contract compute the zeros — never
        // hand-type eighteen of them.
        _mint(msg.sender, 1000);
    }
}
