# Lesson 16 Quiz: Approve a Spender

---
# Quiz 1
## Scenario: The Store That Couldn't Charge Anyone

Dan wants a RewardStore that takes 100 WCR from Kevin when Kevin buys a turon. He keeps trying to make it work with `transfer`, and keeps hitting the same wall.

**Question 1:** Why can't the store charge Kevin using `transfer`?
A. `transfer` is disabled on OpenZeppelin tokens by default
B. `transfer` always spends the *caller's* own balance, so if the store calls it the store pays; a contract can't force Kevin to press the button himself
C. `transfer` only works between two human wallets, never with a contract
D. `transfer` moves tokens but forgets to emit an event, so the store can't confirm it

**Answer:** B
**Explanation:** `transfer(to, amount)` spends `msg.sender`'s balance, full stop. If the store calls it, the store's credits move — wrong direction. The fix is a way to pull *from* Kevin, with his recorded permission.

---

**Question 2:** Kevin calls `approve(store, 50 * 10**18)`. What happens to Kevin's balance?
A. It drops by 50 WCR immediately — the store now holds them
B. It drops by 50 WCR, but only after the store confirms
C. Nothing — `approve` moves zero tokens; it only records a permission
D. It is locked and unspendable until the allowance is used

**Answer:** C
**Explanation:** `approve` is the note, not the payment. It records that the spender *may* pull up to the cap later, via `transferFrom`. Kevin's balance is byte-for-byte unchanged.

---

**Question 3:** Which event does a successful `approve` emit, and which fields are indexed?
A. `Transfer(from, to, value)`, with `value` indexed
B. `Approval(owner, spender, value)`, with `owner` and `spender` indexed
C. `Allowance(owner, spender)`, with nothing indexed
D. No event — `approve` is a silent state change

**Answer:** B
**Explanation:** Every successful `approve` emits `Approval(owner, spender, value)` with both addresses indexed, so a block explorer can filter every approval an account granted or received. The note is written in the public log.

---

# Quiz 2
## Scenario: Aling Vteng's Merienda Note

Tita Malou lets Popoy take merienda "hanggang singkwenta lang sa isang linggo," on Aling Vteng's say-so, tracked in her notebook. JM points out this is exactly the allowance model.

**Question 4:** In the allowance mapping `allowance[owner][spender]`, who plays Aling Vteng and who plays the carinderia?
A. Aling Vteng is the spender; the carinderia is the owner
B. Aling Vteng is the owner (sets the limit on her own money); the carinderia is the spender (authorized to pull up to the limit)
C. Both are spenders; Popoy is the owner
D. Aling Vteng is the token contract; the carinderia is the event log

**Answer:** B
**Explanation:** Aling Vteng owns the money and sets the cap — she's the `owner`. The carinderia is authorized to pull up to that cap — the `spender`. The notebook line is the `allowance` itself.

---

**Question 5:** Kevin calls `approve(store, 50)` and then, later, `approve(store, 20)`. What is the store's allowance now?
A. 70 — the second approve adds to the first
B. 50 — the first approve wins and later ones are ignored
C. 20 — `approve` overwrites; the second note replaces the first
D. 0 — calling approve twice cancels both out

**Answer:** C
**Explanation:** `approve` sets the allowance, it does not add. The second call replaces the first, leaving 20. (To revoke entirely, `approve(spender, 0)`.)

---

**Question 6:** An app asks Kevin to approve the maximum possible amount (`2**256 - 1`) instead of just 50. What is the main *risk*?
A. The transaction will cost more gas than Kevin can afford
B. The token will refuse an allowance that large
C. It's a standing, never-expiring authorization over Kevin's *entire* balance — if that spender is buggy or malicious, it can drain everything, not just 50
D. There is no risk; an unlimited allowance behaves exactly like a 50 allowance

**Answer:** C
**Explanation:** The cap is the *most* a spender can ever pull until you change it. Unlimited means blast radius = your whole balance. Apps still ask for it for convenience (approve once, no repeated gas), but per-purchase approval is the safer default.

---
**Next:** Proceed to Lesson 16 exercises.
