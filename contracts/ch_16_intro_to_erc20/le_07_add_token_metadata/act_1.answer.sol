// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// WorkshopCredit — Full Solution
// Lesson 7 by Dan Santos
// ============================================
// The constructor forwards the real name and symbol up to
// the inherited ERC20 — turning yesterday's red error green.
// name() now returns "Workshop Credit", symbol() returns "WCR".
// totalSupply() still returns 0: an identity, not yet a supply
// (that's Lesson 8's job).
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    // Runs once, at deployment. The parent ERC20 constructor runs first,
    // storing the name and symbol, before this (empty) body would run.
    constructor() ERC20("Workshop Credit", "WCR") {}
}
