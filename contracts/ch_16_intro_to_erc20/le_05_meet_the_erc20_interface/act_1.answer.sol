// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// MEET THE ERC-20 INTERFACE — Full Solution
// Lesson 5 by Dan Santos
// ============================================
// IWorkshopCredit is an interface: signatures only, no
// bodies. It declares the ERC-20 shape — 3 views, 3 writes,
// 2 events — that WorkshopCredit will implement in Lesson 6.
// An interface is a promise, not a program: it can't deploy.
// ============================================
interface IWorkshopCredit {
    // ---------- 3 VIEWS (read-only, cost no gas) ----------

    /// @notice How many credits exist in the whole workshop, ever.
    ///         (The number at the very bottom of the listahan.)
    function totalSupply() external view returns (uint256);

    /// @notice How many credits ONE student holds right now.
    ///         (One person's line in the notebook.)
    function balanceOf(address account) external view returns (uint256);

    /// @notice How much `spender` is still allowed to pull from `owner`.
    ///         (The "pwede kunin hanggang ___" note left with the tindera.)
    function allowance(address owner, address spender) external view returns (uint256);

    // ---------- 3 WRITES (change state, cost gas, emit events) ----------

    /// @notice Hand YOUR OWN credits straight to `to`. (Dan gives Kevin credits.)
    function transfer(address to, uint256 amount) external returns (bool);

    /// @notice Pre-authorize `spender` to pull up to `amount` from you later.
    ///         No credits move yet — just permission. (Approving the store.)
    function approve(address spender, uint256 amount) external returns (bool);

    /// @notice Move SOMEONE ELSE'S credits, within the allowance they set.
    ///         (The reward store collecting payment at checkout.)
    function transferFrom(address from, address to, uint256 amount) external returns (bool);

    // ---------- 2 EVENTS (public receipts written to the ledger) ----------

    /// @notice Fired on EVERY credit movement. The receipt anyone can read.
    event Transfer(address indexed from, address indexed to, uint256 value);

    /// @notice Fired whenever a permission is granted. The receipt for approvals.
    event Approval(address indexed owner, address indexed spender, uint256 value);
}
