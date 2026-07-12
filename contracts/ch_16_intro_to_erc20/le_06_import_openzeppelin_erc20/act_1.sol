// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// WorkshopCredit — Lesson 6: Stand on Giants
// by: <Your Name>
// ============================================
// One import line inherits a battle-tested token.
// This starter INTENTIONALLY DOES NOT COMPILE YET —
// that is the whole point of the lesson. Compile it,
// read the error, THEN fix it in Task 3.
// ============================================

// Bayanihan: don't rebuild what the barangay already hardened.
// This one line pulls in OpenZeppelin's audited ERC20 —
// pinned to 5.0.2 so we know EXACTLY what we're getting.
import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";

// "is ERC20" = WorkshopCredit INHERITS every ERC-20 function
// (transfer, approve, transferFrom, balanceOf, allowance, ...)
// for free — real, tested bodies we did not write.
contract WorkshopCredit is ERC20 {
    // TODO (Task 3): this will NOT compile until you add a constructor
    // that passes "Workshop Credit" and "WCR" up to ERC20. Meet the error
    // first (Task 1), read what it wants (Task 2), THEN specify the two
    // arguments here via a base constructor call. Its body stays empty {}.
}
