# Lesson 18 Quiz: Spend With transferFrom

---
# Quiz 1
## Scenario: The Pull

Kevin holds 100 WCR and has `approve`d the store for 50 WCR. The `allowance(Kevin, store)` reads 50, but nothing has moved. Dan switches the Remix account to the store and calls `transferFrom(Kevin, store, 30)`.

**Question 1:** Why did nothing move until Dan called `transferFrom`, even though the allowance already read 50?
A. The allowance was set incorrectly and had to be reset first
B. `approve` only grants permission — it moves zero credits; `transferFrom` is the actual pull that moves them
C. `transferFrom` cannot run until the owner comes back online to confirm
D. The store needed to `transfer` the credits to itself instead

**Answer:** B
**Explanation:** `approve` fires an `Approval` event and leaves every balance untouched — a promise on paper. `transferFrom` is that promise being collected: it's the move that actually shifts credits.

---

**Question 2:** In `transferFrom(from, to, amount)`, which account is `msg.sender`, and whose balance drops?
A. `msg.sender` is `from`; `from`'s balance drops
B. `msg.sender` is the spender/store that called it; `from`'s (the owner's) balance drops
C. `msg.sender` is `to`; the store's balance drops
D. `msg.sender` is the token contract; no balance drops

**Answer:** B
**Explanation:** The caller (`msg.sender`) is the *spender* — a different address from `from`. The credits leave `from`'s account, not the caller's. That's the whole trap: caller and sender are the same in `transfer`, but different in `transferFrom`.

---

**Question 3:** When the store pulls 30 of a 50 allowance, which three numbers change — and what stays the same?
A. Only the two balances change; the allowance is untouched
B. `from`'s balance down 30, `to`'s balance up 30, and the allowance down to 20; `totalSupply` is unchanged
C. All three numbers and `totalSupply` change
D. Only the allowance changes; balances update later

**Answer:** B
**Explanation:** One `transferFrom` moves three numbers: owner balance down, recipient balance up, allowance down by the amount. Nothing is minted or burned, so `totalSupply` never moves — credits only change hands.

---

# Quiz 2
## Scenario: collectFrom and the Refused Pull

Dan wraps the store's move into `collectFrom(from, amount) { transferFrom(from, msg.sender, amount); }`. After pulling 30, the allowance is 20. As the store, he calls `collectFrom(Kevin, 30)` — more than what's left.

**Question 4:** What does the `collectFrom(Kevin, 30)` call do when only 20 WCR of allowance remains?
A. It pulls 20 and silently ignores the extra 10
B. It reverts with `ERC20InsufficientAllowance(spender, allowance, needed)` and moves no credits
C. It succeeds and drives the allowance to -10
D. It reverts with `ERC20InsufficientBalance` because Kevin is short on funds

**Answer:** B
**Explanation:** The allowance (20) is checked first and is less than the requested 30, so OpenZeppelin reverts `ERC20InsufficientAllowance` with `allowance` = 20 and `needed` = 30. The check happens before any credits move, so nothing changes.

---

**Question 5:** After a successful `transferFrom` in OpenZeppelin v5, how do you know the allowance dropped?
A. A new `Approval` event is emitted with the reduced value
B. There is no allowance-change event — only a `Transfer` is emitted, so you re-read `allowance(owner, spender)` yourself
C. `transferFrom` returns the new allowance value
D. The allowance never changes on a `transferFrom`

**Answer:** B
**Explanation:** OZ v5 emits only `Transfer` on a `transferFrom`, not a new `Approval`. The allowance really does shrink, but silently in the log — to see the new cap you read `allowance(owner, spender)` directly.

---

**Question 6:** `transferFrom` checks the allowance *before* the balance. If Kevin has only 10 WCR but the store holds 40 WCR of allowance and tries to pull 30, which error fires?
A. `ERC20InsufficientAllowance`, because 30 is a large pull
B. `ERC20InsufficientBalance`, because the allowance check passes (40 ≥ 30) but Kevin's 10 < 30
C. Both errors fire at once
D. No error — the pull takes whatever is available

**Answer:** B
**Explanation:** Allowance is checked first: 40 ≥ 30, so that gate passes. The code then checks the balance, finds 10 < 30, and reverts on balance. Permission was fine; the funds weren't.

---

**Question 7:** Why is `collectFrom` (a wrapper over `transferFrom(from, msg.sender, amount)`) called the RewardStore's engine?
A. Because it mints new credits for the store
B. Because the store's future `buyItem` runs the same pull — `credit.transferFrom(buyer, address(this), price)` — collecting the buyer's approved credits into itself
C. Because it only works inside a store contract
D. Because it bypasses the allowance entirely

**Answer:** B
**Explanation:** `collectFrom` is the store's move by hand: a spender pulling an owner's approved credits into itself. `RewardStore.buyItem` will run the identical `transferFrom` line to collect payment — same machinery, just automated.

---
**Next:** Proceed to Lesson 18 exercises.
