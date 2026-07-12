// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// WorkshopCredit — Lesson 7: Register the Name
// by: <Your Name>
// ============================================
// This starter COMPILES as shipped — but the token has
// no identity yet: it hands ERC20 two EMPTY strings.
// Your job is to fill in the real name and symbol.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

contract WorkshopCredit is ERC20 {
    // The constructor runs ONCE, at deployment. It forwards the name and
    // symbol up to the ERC20 we inherited (the base constructor call).
    //
    // TODO (Task 1): replace the two empty strings below with the token's
    // real metadata — the full name "Workshop Credit" as the first argument
    // and the ticker "WCR" as the second. Leave the () and the {} as they are.
    constructor() ERC20("", "") {}
}
