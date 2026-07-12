# Lesson 5 Quiz: Meet the ERC-20 Interface

---
# Quiz 1
## Scenario: The Dry Document

Dan opens **EIP-20: Token Standard** expecting a recipe and finds a specification — "walang code, puro function names." JM tells him it's the most important thing he'll read all course: the shape every token agrees to speak.

**Question 1:** What *is* an interface in Solidity, in the carinderia-menu sense JM uses?
A. A finished program with all the balance math written inside
B. A list of function signatures with no bodies — a menu of *what* you can order, not *how* it's cooked
C. A wallet app that displays tokens
D. A private database only Dan can read

**Answer:** B
**Explanation:** An interface declares signatures only — no code. It's the menu (what you can order); the implementation is the kitchen (how it's cooked). Compiling one proves the shape is valid Solidity, but there's nothing to run.

---

**Question 2:** Why does *every* wallet and exchange know how to talk to a brand-new token nobody told it about?
A. Wallets scan the internet for new tokens and learn them one by one
B. Because the token implements the exact EIP-20 shape — same six functions, same inputs and outputs — so tools already know how to call it
C. The token author personally registers it with MetaMask
D. All tokens share one global contract

**Answer:** B
**Explanation:** Interoperability comes from the shared standard. If your contract exposes exactly the EIP-20 functions with the exact signatures, every tool that speaks EIP-20 can already talk to it — no teaching required.

---

**Question 3:** JM tells Dan to learn the **interface**, not the **implementation**. What's the difference?
A. The interface is the fast version; the implementation is the slow version
B. The interface is *what* the functions are called and what they take/return; the implementation is *how* they work inside (balance math, checks, storage)
C. They mean the same thing
D. The interface is for testnets; the implementation is for mainnet

**Answer:** B
**Explanation:** Interface = the "what" (names, inputs, outputs). Implementation = the "how" (the actual logic). Tonight Dan reads the what; next lesson he inherits a battle-tested how from OpenZeppelin for free.

---

# Quiz 2
## Scenario: The Allowance Model

Kevin wants to buy from the reward store. The store can't just reach into his balance — instead Kevin calls `approve(store, 100)`, and later the store calls `transferFrom(kevin, store, 100)`.

**Question 4:** After Kevin calls `approve(store, 100)` but before the store does anything, how many credits have moved?
A. 100 credits moved immediately to the store
B. Zero — `approve` only records a permission; no balance changes until `transferFrom` is called
C. 50, because approvals split the amount
D. The credits are burned

**Answer:** B
**Explanation:** `approve` moves nothing. It writes a permission ("you may pull up to 100"). The credits only move when the store calls `transferFrom`, and only up to the approved limit — that's the whole two-step allowance model.

---

**Question 5:** What is the core difference between `transfer` and `transferFrom`?
A. `transfer` is free and `transferFrom` costs gas
B. `transfer` spends *your own* balance; `transferFrom` spends *someone else's* balance, but only within the allowance they approved first
C. `transfer` is for small amounts, `transferFrom` for large ones
D. They are aliases for the same function

**Answer:** B
**Explanation:** `transfer` moves your own credits to someone else. `transferFrom` lets an approved spender move *another* account's credits within its allowance. That's why a contract can never touch your balance uninvited — you must `approve` first.

---

**Question 6:** Kevin's parents want to prove Dan actually sent Kevin 100 WCR. Which event lets them do that without trusting Dan, and what does `indexed` add?
A. The `Approval` event; `indexed` hides the amount
B. The `Transfer` event; `indexed` on the address fields lets a block explorer search and filter by address, so anyone can pull up every Transfer involving Kevin
C. There is no way to prove it on-chain
D. The `totalSupply` view; `indexed` makes it free

**Answer:** B
**Explanation:** Every credit movement emits a `Transfer(from, to, value)` event — a permanent public receipt. `indexed` on `from`/`to` makes those fields searchable, so anyone can audit "every Transfer involving Kevin" without asking Dan. A notebook can be smudged; an event cannot.

---

**Question 7:** Why does `balanceOf` take an `address` argument while `totalSupply` takes none?
A. `totalSupply` is deprecated
B. There's only one grand total for the whole token, but a balance is per-account, so you must say *whose* line to read
C. `balanceOf` is optional metadata
D. `totalSupply` reads from a different contract

**Answer:** B
**Explanation:** `totalSupply()` returns the single number at the bottom of the ledger — no argument needed. `balanceOf(account)` reads one person's line, so it must be told which account. Both are free `view` reads.

---
**Next:** Proceed to Lesson 5 exercises.
