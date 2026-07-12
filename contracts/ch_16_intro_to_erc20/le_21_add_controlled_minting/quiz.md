# Lesson 21 Quiz: Add Controlled Minting

---
# Quiz 1
## Scenario: The One-Line Mint

Dan writes `function mint(address to, uint256 amount) external { _mint(to, amount); }` and calls it "one line to top up the supply." Ate Rina reads it and asks: *"Who can call that, bata?"*

**Question 1:** What is fatally wrong with Dan's open `mint`?

A. It costs too much gas to call
B. `_mint` is spelled wrong and won't compile
C. It has no access check, so *anyone* with a wallet can mint themselves unlimited WCR — which makes every credit worthless
D. It mints to the wrong address by default

**Answer:** C
**Explanation:** The function is `external` with no guard, so `_mint` is reachable by the whole internet. If anyone can print credits, credits mean nothing — Ate Rina's whole point. The fix isn't removing minting; it's controlling *who* can mint.

---

**Question 2:** `_mint(to, amount)` does three things atomically. Which is NOT one of them?

A. Increases `balanceOf[to]` by `amount`
B. Increases `totalSupply` by `amount`
C. Emits a `Transfer` event from the zero address
D. Deducts `amount` from the caller's own balance

**Answer:** D
**Explanation:** `_mint` creates tokens out of nothing — no one's balance is deducted. It raises the recipient's balance and `totalSupply`, and logs a `Transfer` from `0x000...000` to signal the credits did not exist before. Deducting a balance is what `transfer` does, not `mint`.

---

**Question 3:** In `constructor() ERC20("Workshop Credit", "WCR") Ownable(msg.sender)`, what does `Ownable(msg.sender)` do, and why is it required?

A. It mints 1,000 WCR to `msg.sender`
B. It sets the initial owner to the account that deploys the contract; OZ v5 requires you to name the owner explicitly rather than guessing
C. It approves `msg.sender` to spend everyone's credits
D. It is optional decoration that can be safely deleted

**Answer:** B
**Explanation:** OpenZeppelin v5 `Ownable` has no default owner — you must pass one in the constructor. `msg.sender` there is whoever sent the deploy transaction, so the deployer (Dan, the instructor) becomes the owner. Remove it and the contract won't compile.

---

# Quiz 2
## Scenario: The Rejected Mint

The token is now `is ERC20, Ownable` with an `onlyOwner` mint. From the owner account, `mint` succeeds and `totalSupply` rises. Then a student account calls `mint` — and the ledger refuses.

**Question 4:** When a non-owner calls the `onlyOwner` mint, what does OpenZeppelin v5 revert with?

A. A require string, `"Ownable: caller is not the owner"`
B. The custom error `OwnableUnauthorizedAccount(address account)`, where `account` is the refused caller
C. `ERC20InsufficientBalance`
D. Nothing — the call silently does nothing

**Answer:** B
**Explanation:** OZ v5 uses typed custom errors, not v4's require strings. `OwnableUnauthorizedAccount(account)` names the exact address that tried and was refused — cheaper on gas and machine-readable, the same style as `ERC20InsufficientBalance`.

---

**Question 5:** After the non-owner's `mint` reverts, `totalSupply` is unchanged. Why?

A. The revert rolled back a mint that had already happened
B. `onlyOwner` runs *before* the function body, so `_mint` never executed and no state changed
C. `totalSupply` is a constant that can never change
D. The student's balance absorbed the new credits instead

**Answer:** B
**Explanation:** The `onlyOwner` gate runs before a single line of the body. Because `msg.sender` wasn't the owner, the call reverted before `_mint`, so no credits were created and no state moved. The unchanged supply is the proof that the lock held.

---

**Question 6:** `Ownable` gives a free public getter `owner()`. Why is that *transparency*, not a security leak?

A. It lets attackers steal the owner's private key
B. It hides who the owner is from everyone
C. Anyone can read who holds the minting key, so the lock is public and verifiable — the honest answer to "printing money sounds like a scam"
D. It disables minting entirely

**Answer:** C
**Explanation:** Knowing the owner's *address* grants no power — only the owner's private key can act. Making `owner()` public means the whole barangay can confirm exactly one account can mint, and watch every credit it prints. Restricted *and* visible is the opposite of a scam.

---
**Next:** Proceed to Lesson 21 exercises.
