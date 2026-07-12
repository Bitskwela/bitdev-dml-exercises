// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// DESIGN THE TOKEN — Lesson 2
// by: <Your Name>
// ============================================
// Turn the napkin into code: capture WCR's six
// design decisions as constants, plus one admin
// address set at deploy. This is the DESIGN —
// no balances, no transfers, not a working token
// yet. It just STATES the decisions, permanently.
// ============================================
contract WorkshopCreditDesign {
    // TODO (Task 1 - Identity): two PUBLIC CONSTANT strings —
    //   NAME   = "Workshop Credit"   (readable; says what it is)
    //   SYMBOL = "WCR"               (short, UPPERCASE ticker)

    // TODO (Task 2 - Precision): a PUBLIC CONSTANT uint8 named
    //   DECIMALS = 18   (the ERC-20 default; a display setting, see Lesson 9)

    // TODO (Task 3 - Supply): a PUBLIC CONSTANT uint256 named
    //   INITIAL_SUPPLY = 1000   (whole credits minted to admin at launch)

    // TODO (Task 4 - Roles): a PUBLIC IMMUTABLE address named `admin`
    //   (the one accountable person; the only one who may ever mint).
    //   An immutable is set exactly once — in the constructor below.

    constructor() {
        // TODO (Task 4): set admin = msg.sender (the deployer becomes admin).
    }
}
