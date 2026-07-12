# Lesson 19 Quiz: Build a Reward Store

---
# Quiz 1
## Scenario: Two Contracts, One Ledger

Dan finishes the WCR token and starts a *second* contract, `RewardStore`, in a new file next to `WorkshopCredit.sol`. The store must know which token it accepts and keep a list of rewards.

**Question 1:** Why is `RewardStore` a separate contract instead of more functions bolted onto `WorkshopCredit`?
A. Solidity forbids a contract from having more than a handful of functions
B. Each contract does one job — the token holds *balances*, the store holds a *catalog and a pointer to the token* — and they cooperate instead of duplicating each other
C. A project is only allowed one contract, so the store had to go somewhere else
D. The store is written in a different language than the token

**Answer:** B
**Explanation:** A project can be many contracts. WCR is the money; RewardStore is the shop. Splitting responsibilities is the same instinct that made Dan inherit OpenZeppelin's ERC20 instead of rewriting it.

---

**Question 2:** What does `credit = IERC20(creditToken)` actually give the store?
A. A full copy of every WCR balance, kept in sync automatically
B. WCR's *address* plus the knowledge of which functions it may call — a pointer and an interface, not a copy of the token
C. Ownership of the WCR token contract
D. A brand-new token that the store mints itself

**Answer:** B
**Explanation:** `IERC20(creditToken)` means "treat the contract at this address as an ERC-20." The store holds WCR's location and how to call it — like saving the tindera's number, not putting the tindera in your phone.

---

**Question 3:** `credit` is declared `immutable`. What does that guarantee?
A. The store can change which token it accepts whenever the owner wants
B. `credit` is assigned exactly once, in the constructor, and can never be reassigned — so anyone can verify the store will never swap WCR for a worthless token
C. The token's balances can never change
D. The store's items can never be removed

**Answer:** B
**Explanation:** `immutable` freezes the value after deployment. That's tiwala you can verify: the store is permanently married to the WCR address you passed in. (It's also cheaper to read than storage.)

---

# Quiz 2
## Scenario: Writing Price Cards

Dan adds a struct `Item { string name; uint256 price; bool active; }`, a dynamic array `Item[] public items`, and `addItem`, which pushes a new item and emits `ItemAdded`.

**Question 4:** Dan lists a turon for 100 WCR. What value goes into the item's `price` field?
A. `100`
B. `100.00`
C. `100000000000000000000` — that is `100 * 10**18`, because prices use base units, exactly like balances
D. `1.0e2`

**Answer:** C
**Explanation:** The store speaks the same integer language as the token: no floats, ever. 100 WCR in base units is `100 * 10 ** 18`, matching how the token stores balances (the Lesson 9 reason).

---

**Question 5:** In `addItem`, the event is emitted as `ItemAdded(items.length - 1, name, price)`. Why `items.length - 1`?
A. It's an off-by-one bug that should be `items.length`
B. The item was just pushed to the end, so its id (its index) is the new length minus one — the first item ever added is id `0`
C. Arrays in Solidity are one-indexed, so you subtract one to reach zero
D. It reserves an empty slot before the item

**Answer:** B
**Explanation:** The index *is* the id, and it's zero-based. After pushing, `items.length` counts the new item, so the item's own index is `items.length - 1`. First push → id 0, second → id 1.

---

**Question 6:** After deploying the store and adding one item, what does `itemCount()` return, and what would `items(0)` give you?
A. `itemCount()` → `0`; `items(0)` → the whole array
B. `itemCount()` → `1`; `items(0)` → that one item's fields: `name`, `price`, `active`
C. `itemCount()` → `1`; `items(0)` → only the item's name
D. `itemCount()` → `2`; `items(0)` → an error

**Answer:** B
**Explanation:** One item listed means `items.length` is `1`. The auto-generated public getter `items(i)` returns a single element by index, decoded field by field — not the entire array at once.

---

**Question 7:** Right now `addItem` has no access control — anyone can call it. Is that a bug this lesson?
A. Yes; the store is broken until it's fixed
B. No; it's deliberate — restricting actions to the instructor is what `Ownable`/`onlyOwner` are for, and that arrives in Lesson 21 (one idea per lesson)
C. Yes; students will be able to mint free WCR through it
D. No; `addItem` can never be called by anyone but the deployer anyway

**Answer:** B
**Explanation:** Just like `award` back in Lesson 1, the guard is deferred on purpose. Adding `onlyOwner` is Lesson 21's job; today is about wiring two contracts and building a catalog.

---
**Next:** Proceed to Lesson 19 exercises.
