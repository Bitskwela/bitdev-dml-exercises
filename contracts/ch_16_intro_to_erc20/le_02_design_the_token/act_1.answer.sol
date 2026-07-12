// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// DESIGN THE TOKEN — Full Solution
// Lesson 2 by Dan Santos
// ============================================
// The napkin, in code: WCR's six design decisions
// captured as constants, plus one immutable admin
// set at deploy. Not a working token yet — the
// DESIGN, made concrete and permanent.
// ============================================
contract WorkshopCreditDesign {
    string  public constant NAME = "Workshop Credit";
    string  public constant SYMBOL = "WCR";
    uint8   public constant DECIMALS = 18;            // ERC-20 default (see Lesson 9)
    uint256 public constant INITIAL_SUPPLY = 1000;    // whole credits minted at launch
    address public immutable admin;                   // who can create credits; set at deploy
    constructor() { admin = msg.sender; }
}
