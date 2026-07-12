# Lesson 12 Quiz: Read Token Information

---
# Quiz 1
## Scenario: The Blue Buttons

Monday night, empty lab. Dan expands his deployed WCR and sees two kinds of button — blue and orange. He clicks the blue `name` and gets "Workshop Credit" instantly: no wallet popup, no gas, no confirmation. He clicks `totalSupply` ten times in a row and gets the same answer every time.

**Question 1:** Why did clicking `name` cost no gas and open no wallet?
A. Because the token is on a test network, so everything is free
B. Because `name()` is a `view` (read-only) function — it only looks at state without changing it, so no transaction and no signature are needed
C. Because Dan is the contract's owner and owners read for free
D. Because the first ten calls of any function are always free

**Answer:** B
**Explanation:** `view` functions only read state. Nothing changes, so no block has to be mined and no one has to sign — the call is answered locally, instantly, and free. That's true for anyone, not just the owner or a testnet.

---

**Question 2:** In the Remix terminal, how does a read like `balanceOf` show up compared to a write like `transfer`?
A. Both show up identically as `transact`
B. A read logs as a **`call`** (no tx hash, no gas, no block); a write logs as a **`transact`** (a real transaction with gas and a hash)
C. A read logs as a `transact` and a write logs as a `call`
D. Reads are never logged at all

**Answer:** B
**Explanation:** Remix labels a read-only invocation a `call` — a question answered locally, with no transaction hash, gas, or block. A state change is a `transact`. The color tells you before you click: blue = call, orange = transact.

---

**Question 3:** Dan clicks `totalSupply` and Remix shows `1000000000000000000000`, not `1000`. Why?
A. The contract minted a million-million credits by mistake
B. `totalSupply` returns **base units** — with `decimals() = 18`, 1,000 whole WCR is stored as `1000 * 10^18`; a wallet divides by `10^18` to show `1,000 WCR`
C. Remix adds eighteen zeros to every number for security
D. The number is a transaction hash, not a balance

**Answer:** B
**Explanation:** On-chain balances are integers in base units. With 18 decimals, one whole WCR is `10^18` base units, so 1,000 WCR reads as `1000000000000000000000`. Remix shows raw base units; a wallet applies the decimals.

---

# Quiz 2
## Scenario: One Call, Four Answers

Instead of clicking five separate buttons, Dan writes his own `view` function, `creditSummary()`, that returns `name()`, `symbol()`, `decimals()`, and `totalSupply()` as a tuple. He wants to explain to Tita Malou how she can check the credits herself.

**Question 4:** `creditSummary()` calls four other functions. Why is it still gasless and callable by anyone?
A. Because it's marked `payable`
B. Because all four functions it calls are reads (`view`), so the whole bundle only looks at state and never changes it — it stays a free `call`
C. Because it returns a tuple, and tuples are always free
D. Because Dan deployed it, so only he pays

**Answer:** B
**Explanation:** A function is only as "writing" as what it does to state. `creditSummary()` calls four read-only functions and changes nothing, so it remains a `view` — gasless, signature-free, and open to anyone.

---

**Question 5:** Which set of functions comes FREE from OpenZeppelin's ERC20, without Dan writing them?
A. Only `name` and `symbol`
B. `name`, `symbol`, `decimals`, `totalSupply`, and `balanceOf` — all inherited, all public reads
C. None — Dan had to implement every read himself
D. Only `totalSupply`, because it's the most important

**Answer:** B
**Explanation:** Inheriting `ERC20` gives Dan all five reads for free. He wrote none of them, yet every one is public — which is exactly why `creditSummary()` can just call them and return the results.

---

**Question 6:** How is this the answer to Tita Malou's "paano ko malalaman kung totoo?"
A. She has to trust Dan's word, same as the notebook
B. With only the contract address, she can call the reads herself and get the same answers as anyone — reading changes nothing, costs nothing, and doesn't depend on trusting Dan
C. She would need Dan's private key to check the balance
D. Only the contract owner can read the total supply

**Answer:** B
**Explanation:** The transparency *is* the read function. Anyone with the address gets the same honest answer, for free, without permission — so the number never depends on trusting Dan's memory or his notebook.

---
**Next:** Proceed to Lesson 12 exercises.
