// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// SET UP REMIX — Full Solution
// Lesson 3 by Dan Santos
// ============================================
// The smallest contract that answers back: one
// pure function returning a greeting. Compiled
// ONLY to prove the Remix setup works before we
// build anything token-shaped. Get the boring
// green first.
// ============================================
contract HelloToken {
    function greet() public pure returns (string memory) {
        return "Kumusta, blockchain!";
    }
}
