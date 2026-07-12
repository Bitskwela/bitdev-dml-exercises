# Lesson 20 Quiz: Purchase a Reward

---
# Quiz 1
## Scenario: The Menu With No Cashier

Dan's store lists a turon for 100 WCR but has no way to charge for it. His first instinct is to write `buyItem` as `credit.transfer(address(this), item.price)` — until Kuya JM asks him whose balance `transfer` actually spends.

**Question 1:** Why is `credit.transfer(address(this), item.price)` wrong inside `buyItem`?
A. `transfer` doesn't exist on ERC-20 tokens
B. `transfer` spends `msg.sender`'s balance, and inside the call `msg.sender` is the *store* — whose WCR balance is zero — so it moves nothing useful
C. `transfer` can only send to an EOA, never to a contract
D. It would send the student's entire balance, not just the price

**Answer:** B
**Explanation:** From the token's view, the caller of `transfer` is the store, and the store holds no WCR. A contract can't reach into someone's wallet with `transfer` — it must be granted permission and *pull* with `transferFrom`.

---

**Question 2:** ERC-20 splits paying a contract into two steps. What are they, in order?
A. `transferFrom` first, then `approve`
B. `approve(store, amount)` by the student, then `transferFrom(student, store, amount)` by the store
C. `mint` then `burn`
D. `deposit` then `withdraw`

**Answer:** B
**Explanation:** First the student signs the permission (`approve` sets the allowance — no tokens move). Then the store pulls with `transferFrom`, which checks the allowance, moves the tokens, and lowers the allowance.

---

**Question 3:** In `credit.transferFrom(msg.sender, address(this), item.price)` inside `buyItem`, what are `msg.sender` and `address(this)`?
A. `msg.sender` is the store; `address(this)` is the student
B. `msg.sender` is the buyer (the student who clicked buy); `address(this)` is the store contract, where the WCR lands
C. Both are the token contract
D. `msg.sender` is Dan; `address(this)` is the token

**Answer:** B
**Explanation:** The student called `buyItem`, so `msg.sender` is the student. `address(this)` is the store itself — the destination the credits flow into. The store pulls *from* the buyer *into* itself.

---

# Quiz 2
## Scenario: Approve First, or Get Refused

Kevin has 200 WCR. He calls `buyItem(0)` without approving, and the transaction reverts with `ERC20InsufficientAllowance`.

**Question 4:** Whose address appears as the `spender` in that error?
A. Kevin's address
B. Dan's address
C. The **store's** deployed address — because inside `buyItem`, the store is the one calling the token's `transferFrom`
D. The token's own address

**Answer:** C
**Explanation:** The spender is whoever calls `transferFrom` — here, the store. So the student must `approve` the *store's* address, not their own. That's the detail everyone trips over once.

---

**Question 5:** The store's `buyItem` starts with `require(item.active, "RewardStore: item not available")`. What happens if `item.active` is `false`?
A. The function returns `false` and continues
B. The whole transaction reverts, every change is undone, and the reason string comes back to the caller — before any WCR moves
C. The item is deleted from the catalog
D. The buyer is charged anyway but flagged

**Answer:** B
**Explanation:** `require` is the guard at the door: true continues, false reverts the entire transaction with the reason string. Because it's the first line, an inactive item is refused before any `transferFrom` runs.

---

**Question 6:** A *successful* `buyItem` call produces how many events, and from where?
A. One — `ItemPurchased`, from the store
B. One — `Transfer`, from the token
C. Two — a `Transfer` from the token and an `ItemPurchased` from the store
D. None — purchases aren't logged

**Answer:** C
**Explanation:** One call, two contracts, two events. The token's `transferFrom` emits `Transfer`; then the store emits `ItemPurchased`. Both sit in the same transaction log, both public and verifiable.

---

**Question 7:** After Kevin's successful purchase, where are the 100 WCR, and what is his allowance for the store?
A. Burned; allowance stays at 100
B. In the store contract's balance; allowance is now 0 (the buy consumed the whole approval)
C. Back with Kevin; allowance is now 200
D. Sent to Dan; allowance is unchanged

**Answer:** B
**Explanation:** At this stage the store *holds* the WCR it collects — it's a piggy bank until burning (Lesson 23). The allowance dropped from 100 to 0, so a second `buyItem` needs a fresh `approve` or it hits `ERC20InsufficientAllowance` again.

---
**Next:** Proceed to Lesson 20 exercises.
