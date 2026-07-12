# Lesson 17 Quiz: Check Allowances

---
# Quiz 1
## Scenario: "Sabi Mo Lang"

Dan tells Kevin he set up a 50-WCR approval for the store. Kevin asks, *"paano ko malalaman? sabi mo lang, e."* Instead of saying "trust me," Dan turns the laptop around and shows him a function.

**Question 1:** Which function lets Kevin verify the approval himself?
A. `balanceOf(kevin)` — it shows approvals in a separate field
B. `allowance(owner, spender)` — a free `view` that returns how much a spender may still spend of an owner's tokens
C. `approve(spender, amount)` — calling it again reveals the current value
D. `transferFrom(owner, to, amount)` with amount 0

**Answer:** B
**Explanation:** `allowance(owner, spender)` is exactly the read for this. It's the third of ERC-20's three `view` functions, alongside `totalSupply` and `balanceOf`, and it answers "how much may this spender still pull?"

**Question 2:** Why does calling `allowance` cost no gas and require no permission?
A. Because Dan pre-paid the gas when he called `approve`
B. Because it's a `view` — it only reads state, changing nothing, so anyone can call it for free
C. Because Remix waives gas for the contract owner only
D. Because allowances are stored off-chain, so there's nothing to charge for

**Answer:** B
**Explanation:** `view` functions read without writing, so they cost no gas and need no transaction. That's the whole tiwala upgrade — *anyone* can verify an approval, not just Dan.

**Question 3:** `balanceOf` needs one address but `allowance` needs two. Why?
A. `allowance` needs a backup address in case the first is invalid
B. An allowance is a property of a *relationship* — whose credits, and who may spend them — so it's keyed by the `(owner, spender)` pair
C. The second address is the token contract's own address
D. It's a historical quirk with no real meaning

**Answer:** B
**Explanation:** A balance belongs to one person; a permission only means something as a pair. `allowance(owner, spender)` reads the note keyed by both names.

---

# Quiz 2
## Scenario: The Tracker Table

Kevin approved the store for 50 WCR. He reads it back, records it, then experiments with re-approving to see what happens.

**Question 4:** Kevin calls `allowance(kevin, someRandomAddress)` for an address he never approved. What comes back?
A. A revert — the pair doesn't exist
B. `0` — any pair never approved reads a hard zero, not an error
C. Kevin's full balance, as a default
D. The last allowance Kevin set for anyone

**Answer:** B
**Explanation:** No approval, no allowance. An un-approved pair reads a clean `0` — the ledger's silence is a hard zero, never a guess or an error.

**Question 5:** Kevin's allowance to the store is 50. He calls `approve(store, 30 * 10**18)`. What does `allowance(kevin, store)` now return?
A. 80 WCR — the new approval adds to the old
B. 50 WCR — the first approval is locked in
C. 30 WCR — `approve` overwrites the allowance, it does not add
D. 0 WCR — changing an allowance always resets it to zero first

**Answer:** C
**Explanation:** `approve` is an assignment (`=`), not an addition (`+=`). The 30 replaces the 50 entirely. To revoke, `approve(spender, 0)`.

**Question 6:** In OpenZeppelin v5, how do you *reduce* an existing allowance from 50 to 20?
A. Call `decreaseAllowance(spender, 30)`
B. Call `approve(spender, 20 * 10**18)` — a fresh approve with the new total; OZ v5 removed the increase/decrease helpers
C. Call `transferFrom` with the difference to burn it
D. You can only ever raise an allowance, never lower it

**Answer:** B
**Explanation:** OZ v5 removed `increaseAllowance` / `decreaseAllowance`. The one true way to change an allowance now is a fresh `approve` with the new total — so "overwrite" isn't a quirk, it's the whole interface.

---
**Next:** Proceed to Lesson 17 exercises.
