# Lesson 4 Quiz: Understand a Smart Contract

---
# Quiz 1
## Scenario: The Green Check on an Empty Box

Dan's `contract WorkshopCredit { }` compiled with a green check — but it holds nothing and does nothing. JM tells him to first build a throwaway, `HelloToken`, with a `name`, a `totalSupply`, and a `greet()` function, then deploy it on the Remix VM.

**Question 1:** A smart contract, once deployed, is best described as which two things living at one address?
A. A username and a password
B. **State** (the data it remembers) and **code** (the functions that act on it)
C. A private key and a public key
D. A frontend and a backend

**Answer:** B
**Explanation:** A deployed contract is state + code at a single on-chain address. State is what it remembers (`name`, `totalSupply`); code is the functions (`greet()`). Everything else in the course builds on that split.

---

**Question 2:** JM compares deploying to copying LutoCLI onto a USB and running it on Tita Malou's desktop — then says a contract is the *opposite*. What's the key difference?
A. A contract runs faster than a native binary
B. A contract lives on thousands of computers you don't own, and once deployed you can't secretly edit it
C. A contract can only be read by its author
D. A contract must be reinstalled every time it runs

**Answer:** B
**Explanation:** LutoCLI lived on a machine Dan controlled — swap the USB and change the program. A contract lives on the chain (thousands of machines, none his) and can't be quietly edited. That "server nobody owns" is the whole source of tiwala.

---

**Question 3:** Dan marks `name` as `public` but never writes a `name()` function, yet a `name()` button appears in Remix. Why?
A. Remix invents random buttons for every variable
B. `public` on a state variable tells Solidity to auto-generate a free getter function with the same name
C. He must have copied it from another contract
D. `name()` only appears after you pay gas to create it

**Answer:** B
**Explanation:** `public` on a state variable auto-generates a same-named getter for free. This is the exact trick every ERC-20 read leans on — `name()`, `symbol()`, `totalSupply()`, `balanceOf()` are all just public getters.

---

# Quiz 2
## Scenario: Blue Buttons and Orange Buttons

After deploying `HelloToken`, Dan sees blue buttons (`name`, `totalSupply`, `greet`). Clicking `greet()` logs a `call`, not a transaction, and costs no gas.

**Question 4:** Why does calling `greet()` cost zero gas?
A. Because it returns a `string` instead of a number
B. Because `greet()` is `pure` — it touches no state at all, so the network has nothing to update and charges nothing
C. Because the Remix VM is free but a real network would charge for it
D. Because `greet()` was deployed separately from the contract

**Answer:** B
**Explanation:** Reading is free; changing state costs gas. `pure` means the function touches no state, so there's nothing to rewrite and no gas to pay — it's a `call`, not a transaction. (This is free on a real network too.)

---

**Question 5:** What does `view` mean, and how does it differ from `pure`?
A. `view` writes state while `pure` reads it
B. `view` reads state but never changes it; `pure` touches no state at all — both are free reads
C. They are identical keywords with different spellings
D. `view` is only for strings and `pure` is only for numbers

**Answer:** B
**Explanation:** `view` reads state without changing it (a getter like `name()` is effectively a view); `pure` doesn't even look at state (`greet()`). Neither writes, so both are free. A function with neither modifier that *assigns* to a state variable is the one that costs gas.

---

**Question 6:** Dan edits `HelloToken.sol` to add a `symbol` variable but forgets to redeploy. The already-deployed contract shows no `symbol` button. Why?
A. `symbol` is a reserved word and can't be added
B. Editing the source never touches a contract already on-chain — only a fresh Deploy creates a new instance carrying the change
C. Remix caches the old file permanently
D. `symbol` needs a `pure` modifier to appear

**Answer:** B
**Explanation:** Deploying creates one live instance at a fixed address. Editing the source afterward changes only the text in the editor; the on-chain copy is frozen. A new Deploy makes a fresh instance (at a new address) that includes your change.

---
**Next:** Proceed to Lesson 4 exercises.
