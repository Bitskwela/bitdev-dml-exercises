// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// UNDERSTAND A SMART CONTRACT — Full Solution
// Lesson 4 by Dan Santos
// ============================================
// A smart contract = STATE + CODE at one address.
// name & totalSupply are state (they persist on-chain);
// greet() is code (a pure function that just returns).
// ============================================
contract HelloToken {
    string  public name = "Hello Token";     // state var, lives on-chain, tied to this address
    uint256 public totalSupply = 100;         // state var

    function greet() public pure returns (string memory) { // pure: reads/writes no state
        return "Kumusta, blockchain!";
    }
}
