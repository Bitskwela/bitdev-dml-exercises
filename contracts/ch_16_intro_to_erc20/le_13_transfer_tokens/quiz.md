# Lesson 13 Quiz: Transfer Tokens

---
# Quiz 1
## Scenario: Two Strokes of a Pen

The instructor account holds 1,000 WCR; a second account, mentally labeled "Kevin," holds 0. Dan is about to press his first orange button and send Kevin 100 WCR. JM warns him: `transfer` always spends the credits of whoever's *calling* it, and there's no "from" to fill in.

**Question 1:** The signature is `transfer(address to, uint256 amount)`. Who is the sender?
A. An address you pass in a hidden third parameter
B. `msg.sender` — the address that called the function, filled in by Solidity; there is no `from` to type
C. Always the contract's deployer, no matter who clicks
D. Whichever address currently holds the most WCR

**Answer:** B
**Explanation:** `transfer` has no `from` parameter on purpose. The sender is `msg.sender`, the address that signed the call — whoever the Account dropdown points at. You can only move credits that are yours.

---

**Question 2:** To send a real **100 WCR** with `decimals() == 18`, what do you type into the `amount` field?
A. `100`
B. `100000000000000000000` (that is `100 * 10**18`, twenty zeros)
C. `100.00`
D. `18`

**Answer:** B
**Explanation:** `transfer` speaks base units. 100 WCR is `100 * 10**18` = `100000000000000000000`. Typing `100` sends 100 base units — `0.0000000000000001 WCR`, a speck. Count the zeros twice; this is the most common ERC-20 beginner mistake.

---

**Question 3:** After the instructor sends 100 WCR to Kevin, what does `totalSupply()` read?
A. `1100000000000000000000` — the transfer added credits
B. `900000000000000000000` — it dropped with the instructor's balance
C. `1000000000000000000000` — unchanged, because a transfer relocates credits, never creates or destroys them
D. `0` — transfers reset the supply

**Answer:** C
**Explanation:** A transfer moves credits between two balances: sender down, receiver up. Nothing is minted or burned, so `totalSupply` is untouched. The books stay balanced — that's why a transfer can never inflate the total.

---

# Quiz 2
## Scenario: Paying the Whole Class

Clicking `transfer` thirty times is exactly the tedium the ledger was supposed to fix. Dan adds `awardClass(address[] students, uint256 amountEach)` that loops `transfer` over a roster, then reads the receipt to see what happened.

**Question 4:** A successful single `transfer` produces which two proofs in the receipt?
A. `bool: false` and `logs: 0`
B. `decoded output → bool: true` (transfer succeeded) and `logs: 1` (one `Transfer` event emitted)
C. A new `totalSupply` and a burned token
D. A refund of the gas and a private message

**Answer:** B
**Explanation:** `transfer` returns `bool: true` on success, exactly as its signature promises, and emits one `Transfer(from, to, value)` event — the `logs: 1` in the receipt. That event is the permanent, public receipt you open field-by-field in Lesson 14.

---

**Question 5:** `awardClass` loops `transfer(students[i], amountEach)`. If **Kevin** calls it with three addresses, whose credits are handed out?
A. The instructor's, because he deployed the token
B. Kevin's own — each `transfer` spends `msg.sender`, and the caller is Kevin; if he lacks enough for the whole list, a transfer reverts
C. The contract's own balance
D. Nobody's — batch transfers are free of any balance

**Answer:** B
**Explanation:** Every iteration calls `transfer`, which always debits `msg.sender`. Whoever clicks `awardClass` is the sender for every payment in the loop. If the caller runs out mid-list, that `transfer` reverts and undoes the whole call.

---

**Question 6:** Why can't `transfer` be used to move *someone else's* credits to yourself?
A. It can, if you pass their address as `from`
B. It cannot — `transfer` only ever spends the caller's own balance; moving someone else's credits needs the separate allowance model (Lessons 16-18)
C. It can, but only for the contract owner
D. It can, but only on a testnet

**Answer:** B
**Explanation:** `transfer` has no `from` and always debits `msg.sender`, so you can only move what you hold. Spending on someone else's behalf requires them to `approve` you first — the allowance model, which arrives in Lessons 16-18.

---
**Next:** Proceed to Lesson 13 exercises.
