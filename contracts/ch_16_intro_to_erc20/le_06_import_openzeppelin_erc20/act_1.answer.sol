// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// WorkshopCredit — Full Solution
// Lesson 6 by Dan Santos
// ============================================
// One import line inherits OpenZeppelin's audited ERC20.
// The constructor satisfies the base's demand for a name
// and a symbol — the direct fix for the Lesson 6 error
// "No arguments passed to the base constructor."
// ============================================

// Bayanihan: inherit the hardened token instead of hand-rolling 200 lines.
// Pinned to 5.0.2 so we deploy exactly the audited code we tested against.
import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    // The base ERC20 constructor requires (name_, symbol_). We specify the
    // arguments — the first exit the compiler offered — instead of marking
    // this contract abstract. Our own constructor takes none, and its body
    // is empty for now (minting arrives in Lesson 8).
    constructor() ERC20("Workshop Credit", "WCR") {}
}
