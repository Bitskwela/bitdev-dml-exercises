// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

// ============================================
// COMPILE AND DEBUG — Lesson 10
// by: <Your Name>
// ============================================
// This starter is INTENTIONALLY BROKEN. It carries
// THREE planted, classic beginner bugs — the exact
// kinds you WILL hit for real at 2 a.m. before a
// demo. Your job: compile it, read each red Remix
// error like a letter, and fix the bugs ONE AT A
// TIME, top-down, until you reach a clean green check.
//
//   BUG 1 (Task 1) — the version pragma on line 2 is wrong.
//   BUG 2 (Task 2) — the `constructor` keyword is misspelled.
//   BUG 3 (Task 3) — the OpenZeppelin ERC20 import is MISSING.
//
// Do NOT fix all three blindly at once. Fix the TOP
// error, recompile, and let the NEXT one surface. The
// compiler works in stages, so an early error hides
// the ones beneath it — that staging IS the lesson.
// ============================================

// TODO (Task 3, BUG 3): the ERC20 import line belongs on the
// blank line below — it was deleted. Without it, the name
// `ERC20` on the contract line is a stranger to the compiler.
// Restore exactly this line (pinned to 5.0.2):
//   import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";


contract WorkshopCredit is ERC20 {
    // TODO (Task 2, BUG 2): the declaration keyword just below is
    // misspelled. The parser wants the real keyword `constructor`
    // here and trips on the typo. Fix the spelling.
    constructr() ERC20("Workshop Credit", "WCR") {
        // TODO (Task 1, BUG 1): before any of this can run, fix the
        // version pragma on line 2 — ^0.7.0 asks for a compiler this
        // project does not use. Change it to ^0.8.20.
        _mint(msg.sender, 1000 * 10 ** decimals());
    }
}
