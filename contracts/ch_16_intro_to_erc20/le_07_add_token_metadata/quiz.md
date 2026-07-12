# Lesson 7 Quiz: Add Token Metadata

---
# Quiz 1
## Scenario: Registering the Name

Yesterday's `No arguments passed to the base constructor` error is still on Dan's screen. Kuya JM reframes it: the inherited ERC20 needs a name and a symbol "on file" before it can exist — like registering the workshop with the barangay. The thing that files that paperwork is the constructor.

**Question 1:** What is a constructor, and why is it the right place to set a token's name?
A. A function you can call any time to reset the token's name
B. A special function that runs **exactly once**, at deployment, and never again — so it's where you lock in a permanent starting decision like a name, which can't be changed by hand afterward
C. A function that runs every time someone reads `name()`
D. A getter that returns the token's metadata

**Answer:** B
**Explanation:** The constructor is the setup crew: it runs one time at birth to put the contract into a valid state, then it's gone. That once-and-permanent nature is exactly why an unchangeable decision like a name belongs there.

---

**Question 2:** In `constructor() ERC20("Workshop Credit", "WCR") {}`, what is the `ERC20("Workshop Credit", "WCR")` part doing?
A. Declaring a new ERC20 variable named "Workshop Credit"
B. A **base constructor call** — it runs the inherited parent's constructor and forwards it the two strings (`name_`, `symbol_`) that OZ v5's ERC20 demanded
C. Calling the `name()` and `symbol()` getters
D. Minting 100 tokens named "Workshop Credit"

**Answer:** B
**Explanation:** That call sitting between the `)` and the `{` forwards the name and symbol up to the ERC20 you inherited. It's the direct fix for Lesson 6's error: you *specify the arguments* instead of marking the contract abstract.

---

**Question 3:** In the same line, `constructor()` has empty parentheses and the body is `{}`. What does that mean?
A. The constructor is broken and won't compile
B. WorkshopCredit's own constructor takes **no** arguments (whoever deploys types nothing), and its body is empty because there's nothing else to set up this lesson — minting will fill it in Lesson 8
C. The empty `{}` means the token has no name
D. The empty parentheses mean the constructor never runs

**Answer:** B
**Explanation:** Your constructor takes no parameters of its own; all it does is forward two literals to the base. The empty body is a placeholder — Lesson 8 puts `_mint` inside those braces.

---

**Question 4:** Why pass `"Workshop Credit"` through a constructor argument instead of hardcoding it deep inside the token?
A. Hardcoding is illegal in Solidity
B. A constructor argument is a **per-deployment choice** — the same source file can be deployed as "Workshop Credit"/"WCR" for one class and "Cebu Workshop Credit"/"CWC" for another, each identity decided at birth
C. It makes the token's name changeable at any time after deployment
D. There's no reason; it's purely stylistic

**Answer:** B
**Explanation:** Inheriting OpenZeppelin's ERC20 leaves the name and symbol as blanks you fill in at deploy time. One file, different identities — flexibility for free.

---

# Quiz 2
## Scenario: Asking the Token Its Name

Dan compiles (green at last), deploys, and clicks the blue buttons. `name()` returns "Workshop Credit", `symbol()` returns "WCR"... and then `totalSupply()` returns a stubborn `0`.

**Question 5:** `name()` and `symbol()` returned instantly, with no gas popup or pending spinner. What does that tell you?
A. Remix was just being fast; they still cost gas
B. They are **free, read-only getters** — they only read stored metadata and change nothing on the ledger, so anyone can call them without paying, unlike a `transfer`
C. They failed silently and returned cached values
D. They can only be called by the contract's deployer

**Answer:** B
**Explanation:** `name()` and `symbol()` are pure reads (blue buttons). No state changes means no gas and no confirmation — a preview of the read-vs-write distinction you'll formalize in Lesson 12.

---

**Question 6:** After deploying, Dan edits the source to a new name and redeploys, but his **first** deployed instance still reports the old name. Why?
A. Remix cached the old name by mistake
B. A constructor runs only at deployment — editing the source never touches an already-live contract, so the old instance keeps the name it was born with; only a brand-new deploy carries the new name
C. The old instance is broken and should be deleted
D. `name()` always returns the very first name any contract ever used

**Answer:** B
**Explanation:** The constructor already ran on the old instance and can never re-run. That permanence — a live token nobody can rename by hand — is exactly the tiwala property the ledger is for.

---

**Question 7:** The token deployed fine, yet `totalSupply()` reads `0`. What does that zero mean?
A. It's a bug in OpenZeppelin's ERC20
B. It's correct — Dan gave the token an **identity** (name and symbol) but never created any tokens, and naming a container is a different job from filling it; the supply is still zero until something mints credits
C. The token failed to deploy
D. `totalSupply()` always returns 0 for read-only functions

**Answer:** B
**Explanation:** Giving a token a name and giving it a supply are two separate jobs — this lesson did only the first. Fixing that `0` by minting the first credits is the entire point of Lesson 8.

---
**Next:** Proceed to Lesson 7 exercises.
