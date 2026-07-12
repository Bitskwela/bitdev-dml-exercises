// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// MEET THE ERC-20 INTERFACE — Lesson 5
// by: <Your Name>
// ============================================
// An interface = signatures only, NO bodies. It declares
// WHAT a token can do, not HOW. This is the exact shape
// WorkshopCredit will implement in Lesson 6. Compiling an
// interface proves the shape is valid Solidity, even empty.
// ============================================
interface IWorkshopCredit {
    // ---------- 3 VIEWS (read-only, cost no gas) — given as examples ----------

    /// @notice How many credits exist in the whole workshop, ever.
    function totalSupply() external view returns (uint256);

    /// @notice How many credits ONE student holds right now.
    function balanceOf(address account) external view returns (uint256);

    /// @notice How much `spender` is still allowed to pull from `owner`.
    function allowance(address owner, address spender) external view returns (uint256);

    // ---------- 3 WRITES (change state, cost gas, emit events) ----------

    // TODO (Task 1): declare `transfer(address to, uint256 amount)` — external,
    // returns (bool), no body. Moves YOUR OWN credits straight to `to`.

    // TODO (Task 2): declare `approve(address spender, uint256 amount)` — external,
    // returns (bool). Pre-authorizes a spender; NO credits move yet, just permission.

    // TODO (Task 3): declare `transferFrom(address from, address to, uint256 amount)` —
    // external, returns (bool). A spender moves SOMEONE ELSE'S credits within their allowance.

    // ---------- 2 EVENTS (public receipts written to the ledger) ----------

    // TODO (Task 4): declare `Transfer(address indexed from, address indexed to, uint256 value)`
    // as an event — the receipt fired on EVERY credit movement.

    // TODO (Task 5): declare `Approval(address indexed owner, address indexed spender, uint256 value)`
    // as an event — the receipt fired whenever a permission is granted.
}
