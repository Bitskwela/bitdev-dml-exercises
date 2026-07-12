// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// UNDERSTAND A SMART CONTRACT — Lesson 4
// by: <Your Name>
// ============================================
// A smart contract = STATE (data it remembers) +
// CODE (functions), living at one on-chain address.
// HelloToken is a throwaway toy to see both, before
// the real WorkshopCredit token begins in Lesson 6.
// ============================================
contract HelloToken {
    // TODO (Task 1): declare a PUBLIC `string` state variable `name`
    // set to "Hello Token". `public` auto-generates a free name() getter,
    // and the value persists on-chain once you deploy.

    // TODO (Task 2): declare a PUBLIC `uint256` state variable `totalSupply`
    // set to 100. Same deal — `public` gives you a free totalSupply() getter.

    // greet() carried over from Lesson 3. A `pure` function touches no
    // state at all, so calling it is free — a `call`, never a transaction.
    function greet() public pure returns (string memory) {
        return "Kumusta, blockchain!";
    }
}
