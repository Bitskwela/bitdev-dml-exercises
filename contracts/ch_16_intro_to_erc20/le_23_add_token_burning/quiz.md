# Lesson 23 Quiz: Add Token Burning

---
# Quiz 1
## Scenario: Nagamit Na, Ubos Na

Kevin earned 200 WCR, approved the store, and bought a turon for 100. The turon was eaten — but `balanceOf(store)` read 100 and `totalSupply` still said 1,200. Dan realized the store had become a hoarder of dead credits, and Tita Malou compared a spent credit to a used prepaid-load pin: nagamit na, ubos na.

**Question 1:** Which operations change the size of `totalSupply`?
A. Every `transfer` and `transferFrom`, because credits move between accounts
B. Only `_mint` (raises it) and `_burn` (lowers it); transfers just shuffle credits between balances and leave the total unchanged
C. Only `approve`, because it grants permission to move credits
D. Nothing can change `totalSupply` after deployment

**Answer:** B
**Explanation:** `totalSupply == sum of all balances`, always. Transfers move credits between accounts without changing the total. Only minting (a credit is born) and burning (a credit dies) change the size of the pile.

---

**Question 2:** `_burn(from, amount)` is best described as what?
A. A special kind of transfer that sends credits to the store's address
B. The exact mirror of `_mint`: it lowers `from`'s balance **and** decreases `totalSupply`, emitting `Transfer(from, 0x0, value)`
C. A function that only the contract owner may ever call
D. A way to move credits without emitting any event

**Answer:** B
**Explanation:** Burn is mint run backwards. Where mint raises a balance and the total (emitting `Transfer(0x0, to, value)`), burn lowers a balance and the total (emitting `Transfer(from, 0x0, value)`). The credit is deleted, not parked.

---

**Question 3:** Why does sending credits to the zero address via `_burn` actually reduce supply, when a plain `transfer` to any address never does?
A. The zero address automatically forwards credits back to the deployer
B. `_burn` subtracts from `totalSupply` as part of its operation; a transfer only moves a balance from one account to another and conserves the total
C. Because the zero address has an infinite balance
D. There is no difference — both reduce `totalSupply`

**Answer:** B
**Explanation:** A transfer conserves the total no matter the recipient. `_burn` is different: it genuinely subtracts from `totalSupply`, so the credit is destroyed rather than parked at an address with a live balance.

---

# Quiz 2
## Scenario: The Store That Learned to Burn

Dan gives WorkshopCredit two new functions — `burn` and `burnFrom` — and rewires `RewardStore.buyItem` to pull the WCR in with `transferFrom` and then call `credit.burn(item.price)`. To make that call compile, he retypes the store's `credit` field from `IERC20` to a new `IWorkshopCredit` interface.

**Question 4:** What is the difference between `burn` and `burnFrom`?
A. `burn` is for the owner and `burnFrom` is for everyone else
B. `burn(amount)` destroys the caller's **own** credits (`_burn(msg.sender, ...)`); `burnFrom(account, amount)` destroys **another** account's credits within an allowance (`_spendAllowance` then `_burn`)
C. `burn` reduces `totalSupply` but `burnFrom` does not
D. They are identical; `burnFrom` is just an alias

**Answer:** B
**Explanation:** `burn` mirrors `transfer` — you spend your own, no permission needed. `burnFrom` mirrors `transferFrom` — it spends someone else's allowance first (`_spendAllowance`, reverting `ERC20InsufficientAllowance` if short), then burns.

---

**Question 5:** Why did Dan have to retype `credit` from `IERC20` to `IWorkshopCredit`?
A. `IERC20` is deprecated in OpenZeppelin v5
B. `IERC20` has no `burn` function, so `credit.burn(...)` won't compile; `IWorkshopCredit is IERC20` adds a `burn` signature so the compiler allows the call
C. The store needed a different token entirely
D. To make the store the owner of the token

**Answer:** B
**Explanation:** An interface describes which functions a type promises. `IERC20` never promises `burn`, so the compiler refuses `credit.burn(...)`. `IWorkshopCredit is IERC20 { function burn(uint256) external; }` adds exactly that promise, and the deployed token really does have it.

---

**Question 6:** After `buyItem(0)` burns a 100 WCR turon, what are the store's balance and the token's supply?
A. Store balance 100 WCR; supply unchanged at 1,200 — the store keeps the credits
B. Store balance **0** (pulled 100 in, burned 100 out — net zero); supply drops from 1,200 to 1,100
C. Store balance 100 WCR; supply rises to 1,300
D. Both the store balance and supply are unchanged

**Answer:** B
**Explanation:** `buyItem` pulls 100 WCR into the store, then immediately burns it — a pass-through that nets zero for the store and drops `totalSupply` by 100. The total now means "credits still live," not "credits ever printed."

---

**Question 7:** Why are `burn` and `burnFrom` **not** marked `onlyOwner`, while `rewardStudent` is?
A. It's an oversight that should be fixed
B. Printing credits is the power that must be guarded (only the instructor can mint), but destroying your *own* credits is always allowed — you can't cheat anyone by deleting what's yours
C. `onlyOwner` cannot be applied to burn functions in Solidity
D. Because burning is more dangerous than minting

**Answer:** B
**Explanation:** Minting creates value from nothing, so it stays locked to the instructor. Burning only removes credits the caller already holds (or was explicitly approved to spend), so it needs no special permission — that's why the store, not the owner, can trigger the burn on redemption.

---
**Next:** Proceed to Lesson 23 exercises.
