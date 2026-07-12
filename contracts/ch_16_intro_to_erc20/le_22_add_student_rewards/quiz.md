# Lesson 22 Quiz: Add Student Rewards

---
# Quiz 1
## Scenario: The Number Without the Reason

Dan's `mint` works, onlyOwner and all. But the log just says 200 WCR landed in Kevin's balance — it doesn't say the credits were for the final exercise. His old paper notebook was a disaster in every way except one: it always said *why*.

**Question 1:** ERC-20 gives you `Transfer` and `Approval`. Whose job is it to record *why* a particular reward was given?

A. OpenZeppelin's — the standard already logs the reason
B. Yours — a reason is application-specific meaning you add on top, with a custom function and a custom event
C. The block explorer's — it infers reasons automatically
D. No one's — reasons can't be stored on a blockchain

**Answer:** B
**Explanation:** ERC-20 is deliberately generic; it knows balances and transfers, not that *this* mint was for exercise 3. That meaning is yours to add — `rewardStudent` (a function that says what your app does) and `StudentRewarded` (an event that logs the reason).

---

**Question 2:** What is an `event` in Solidity, and what is it *not*?

A. A function other contracts call to change balances
B. A log entry a transaction leaves on-chain, meant to be read by humans and off-chain tools — it changes no balance and no other contract reads it back
C. A private variable only the owner can see
D. A way to delete old transactions from the chain

**Answer:** B
**Explanation:** Events are the ledger's receipt drawer: permanent, public log entries for humans and explorers. They don't move value and contracts can't read them back — they exist purely to record what happened, immutably.

---

**Question 3:** In `event StudentRewarded(address indexed student, uint256 amount, string reason)`, what does `indexed` on `student` buy you?

A. It encrypts the student's address
B. It makes `student` a searchable topic, so an explorer can filter "every reward to this exact student"
C. It stops non-owners from reading the event
D. It automatically increases the student's balance

**Answer:** B
**Explanation:** Indexed parameters become topics — a searchable index, like a database index on that column. You can filter every `StudentRewarded` where `student = Kevin`. Non-indexed params (`amount`, `reason`) ride in the data body: readable, but not filterable.

---

# Quiz 2
## Scenario: The Two Logs and the Memo Column

Kuya JM points out the beautiful part: `rewardStudent` can mint the credits *and* emit a custom event, so the reason lives on-chain forever, next to the amount — a memo column the paper notebook could never guarantee.

**Question 4:** Why is `reason` declared as a plain (non-indexed) `string` rather than `string indexed`?

A. Indexing a string is a compiler error
B. An indexed string is stored as its keccak256 hash, so you could match a known value but never read the sentence back — and the whole point of `reason` is to be readable
C. Non-indexed strings are more secure
D. Indexed strings cost the student gas to read

**Answer:** B
**Explanation:** Solidity can't fit a variable-length string into a fixed-size topic, so it stores the hash instead of the text. Index it and the plain reason is gone forever — defeating its entire purpose. Index what you search; leave readable what you read.

---

**Question 5:** `rewardStudent` takes `string calldata reason`. Why `calldata` instead of `memory`?

A. `memory` wouldn't compile for a string
B. The function only reads `reason`, so `calldata` reads it straight from the incoming transaction data — no copy, cheaper gas — and signals "I won't mutate this"
C. `calldata` lets the function edit the reason in place
D. `calldata` makes the reason indexed automatically

**Answer:** B
**Explanation:** `calldata` is the read-only region where arguments already sit. Since we only read and emit `reason`, copying it into `memory` would waste gas for no benefit. Rule of thumb: read-only external argument → `calldata` (the same borrow-vs-own instinct from Rust).

---

**Question 6:** One `rewardStudent(kevin, 200e18, "Finished final exercise")` call leaves two logs. What are they, and where does the reason live?

A. Two `Transfer` events; the reason is in both
B. A `Transfer` from the zero address (from `_mint`) and a `StudentRewarded` — the reason lives only in `StudentRewarded`
C. A `StudentRewarded` and an `Approval`; the reason is in `Approval`
D. Only one log, the `StudentRewarded`

**Answer:** B
**Explanation:** `_mint` fires the inherited `Transfer` from `0x000...000` (credits from nowhere), and your `emit` fires `StudentRewarded`. Only your event carries the reason — welded to the same transaction that moved the credits, so amount and "why" can never drift apart.

---
**Next:** Proceed to Lesson 22 exercises.
