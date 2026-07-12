// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// SET UP REMIX — Lesson 3
// by: <Your Name>
// ============================================
// The blockchain's "Hello World": one pure
// function that greets. No token yet, no
// balances — we compile this ONLY to prove the
// setup works:
//   file name  (HelloToken.sol)
//   SPDX line
//   pragma
//   compiler   (pick 0.8.20 or newer)
// Get the boring green first. Then we build.
// ============================================
contract HelloToken {
    // TODO (Task 2): make greet() RETURN the exact string
    //   "Kumusta, blockchain!"  — a single `return` statement is the
    //   whole body. (`pure` = this function touches no on-chain data.)
    function greet() public pure returns (string memory) {
        // TODO (Task 2): return "Kumusta, blockchain!";
    }
}
