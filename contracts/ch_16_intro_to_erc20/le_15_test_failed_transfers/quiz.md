# Lesson 15 Quiz: Test Failed Transfers

---
# Quiz 1
## Scenario: The Ledger Refuses

Dan switches to Kevin's account (holding 100 WCR) and tries to `transfer` 1,000 WCR to a third address. The terminal flashes red with `ERC20InsufficientBalance`. Afterward, Kevin still has exactly 100, the recipient still has 0, and total supply is unchanged.

**Question 1:** What actually happened when the transfer "failed"?
A. The contract crashed mid-execution and left the balances in a partly-updated state
B. The token checked the request, found it broke a rule, and cleanly rewound everything — a refusal, not a crash
C. Kevin's balance went to -900 and the app hid it
D. The recipient received a partial 100 WCR

**Answer:** B
**Explanation:** A revert is a refusal, not a crash. The token inspects the request, decides it breaks a rule, and undoes everything as if it was never asked — unlike a paper notebook that would limp forward and lie.

---

**Question 2:** What does it mean that a revert is *atomic*?
A. The transaction runs on a single CPU core
B. The transaction either completes entirely or has no effect at all — there is no half-done, in-between state
C. Only one person can transact at a time
D. The amount must be a whole number of tokens

**Answer:** B
**Explanation:** Atomic = all-or-nothing. Even if a step ran partway, it gets rolled back to the exact pre-transaction snapshot. That's why Kevin's 100 is untouched and no `Transfer` event fired.

---

**Question 3:** Dan never wrote a balance-checking line. So how did the transfer know to refuse?
A. Remix added the check automatically for demos only
B. The check is inherited — it lives inside OpenZeppelin's `transfer` (deep in `_update`), which reverts if `fromBalance < value` before touching any balance
C. Kevin's wallet blocked the transaction locally
D. The zero address rejected it

**Answer:** B
**Explanation:** By inheriting OpenZeppelin's ERC20, Dan got the balance check for free. It fires inside `transfer` before any state changes, reverting with a custom error.

---

# Quiz 2
## Scenario: A Refusal You Can Read

The revert didn't just say "no." It returned `ERC20InsufficientBalance(sender, balance, needed)` with real numbers. Dan also added his own `sendExactly` helper with a friendly `require` message.

**Question 4:** How does OpenZeppelin v5 report an insufficient-balance failure, and why is it an improvement over the old v4 style?
A. With a plain string `require` message; v5 and v4 are identical
B. With a custom error `ERC20InsufficientBalance(address sender, uint256 balance, uint256 needed)` that carries the exact numbers — cheaper on gas and machine-readable — instead of a v4 hardcoded string
C. It silently returns false and logs nothing
D. It emails the contract owner

**Answer:** B
**Explanation:** OZ v5 replaced string `require` messages with typed custom errors. The failure comes with a receipt: who tried, what they had, and what was needed — cheaper to store and easy for apps to decode.

---

**Question 5:** Dan's `sendExactly` starts with `require(balanceOf(msg.sender) >= amount, "WCR: not enough credits")`. Is that `require` the real protection?
A. Yes — without it, anyone could overspend freely
B. No — it's a friendly courtesy that fails one step earlier with a human message; even if it were deleted, `transfer` would still revert with the inherited `ERC20InsufficientBalance`
C. Yes — it replaces OpenZeppelin's check entirely
D. No — it disables the inherited check

**Answer:** B
**Explanation:** The inherited custom error is the unremovable guard. The friendly `require` just gives a nicer, earlier message; it does not replace the underlying protection.

---

**Question 6:** JM said the revert is like the Rust compiler refusing to build a bug — but Dan noticed the terminal was still red. What's the one cost an on-chain revert has that Rust's compile-time refusal does not?
A. None — both are completely free
B. A revert happens at runtime on-chain, so it spends gas for the work done before failing and records the failed attempt — though the balances and supply it targeted stay untouched
C. A revert permanently deletes the contract
D. A revert charges the recipient instead of the sender

**Answer:** B
**Explanation:** Rust's refusal is free, at your desk, before any program runs. An on-chain revert charges gas for the effort up to the failing check and records the failed transaction — but it changes no state. You paid a small toll to be told "no."

---
**Next:** Proceed to Lesson 15 exercises.
