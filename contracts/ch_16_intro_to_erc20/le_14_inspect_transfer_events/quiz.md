# Lesson 14 Quiz: Inspect Transfer Events

---
# Quiz 1
## Scenario: The Receipt Nobody Wrote

At midnight, Dan expands his 100 WCR transfer to Kevin and finds a `logs` field he'd been ignoring. Inside sits a decoded `Transfer` event — `from` the instructor, `to` Kevin, `value` 100000000000000000000 — that he never wrote himself.

**Question 1:** What is the difference between the *state* change and the `Transfer` *event* in that transaction?
A. They are the same thing written twice for safety
B. The state change is the balances actually moving; the event is a separate, cheaper record written into the transaction's log announcing that the move happened
C. The event moves the balances, and the state is just a display copy
D. The event is only visible to the contract's owner

**Answer:** B
**Explanation:** State (the balances) is the current truth. The `Transfer` event is a public, permanent receipt of *how* the balances got there — written by the transaction itself, not by Dan.

---

**Question 2:** In `Transfer(address indexed from, address indexed to, uint256 value)`, why are `from` and `to` marked `indexed` but `value` is not?
A. Indexed fields are encrypted, so addresses need hiding but amounts don't
B. Topics (from `indexed` fields) are searchable and data is not — you filter by *who* transferred, almost never by the exact amount, so the addresses are indexed and `value` rides in data
C. `value` is too large to index
D. It is a random OpenZeppelin choice with no meaning

**Answer:** B
**Explanation:** Each `indexed` parameter becomes a searchable topic; non-indexed parameters are packed into the unsearchable `data` blob. You query "every transfer to Kevin," so `from`/`to` are indexed; you rarely query by amount, so `value` isn't.

---

**Question 3:** What is `topic[0]` of a `Transfer` log, and why does it matter?
A. The amount transferred, in hex
B. The sender's address, padded to 32 bytes
C. The event's signature hash — `keccak256("Transfer(address,address,uint256)")` = `0xddf252ad...523b3ef` — which tells a reader the raw log is a `Transfer` before it decodes anything else
D. The block number the transfer landed in

**Answer:** C
**Explanation:** `topic[0]` is always the event's signature hash. It's identical on every ERC-20 ever deployed, and it's how explorers know which event a raw log represents so they can decode the rest correctly.

---

# Quiz 2
## Scenario: Two Receipts and a Mint from Nowhere

Dan adds `awardWithNote`, which calls `transfer` and then emits his own `CreditsAwarded(to, amount, note)`. He also scrolls up to the deployment transaction and finds a `Transfer` event he never triggered.

**Question 4:** After a successful `awardWithNote` call, how many events appear in the transaction's log, and which ones?
A. One — only `CreditsAwarded`, since Dan wrote it
B. Two — the inherited `Transfer` (fired by the `transfer` call) and Dan's `CreditsAwarded` (fired by `emit`)
C. Zero — custom events don't show in Remix
D. Three — Transfer, Approval, and CreditsAwarded

**Answer:** B
**Explanation:** `transfer(to, amount)` automatically fires the inherited `Transfer` event, and `emit CreditsAwarded(...)` fires Dan's own. One call, two receipts: who/how-much, plus the reason why.

---

**Question 5:** In the deployment transaction, the `Transfer` event has `from` = `0x0000...0000`. Why?
A. The deployment failed and defaulted to zero
B. Minting is modeled as a `Transfer` *from* the zero address, so a token's entire life — mints, transfers, and burns — is one continuous stream of a single event type
C. The zero address secretly owns all new tokens
D. Remix couldn't decode the real sender

**Answer:** B
**Explanation:** `_mint` emits a `Transfer` from `address(0)` (and burning emits one *to* it). Riding creation and destruction on the same `Transfer` event means an auditor can reconstruct total supply and every holder's history from one log type.

---

**Question 6:** How does reading the event log answer Tita Malou's *"paano ko malalaman na totoo?"*
A. Dan has to screenshot his own balance and promise it's real
B. The log is written by the transaction, is as permanent as the block, and is readable by anyone — so instead of arguing, Dan just points Tita Malou (or Kevin) at where to look
C. Only the contract owner can prove a transfer happened
D. She has to install a special app that only Dan controls

**Answer:** B
**Explanation:** An event log is the opposite of the notebook on both counts that made the notebook untrustworthy: no single person writes it and no one can edit it. Trust stops depending on Dan's word — it becomes something anyone can read.

---
**Next:** Proceed to Lesson 14 exercises.
