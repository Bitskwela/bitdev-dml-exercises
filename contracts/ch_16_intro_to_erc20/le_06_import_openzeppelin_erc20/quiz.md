# Lesson 6 Quiz: Import OpenZeppelin ERC-20

---
# Quiz 1
## Scenario: Don't Cut Your Own Kahoy

Dan stares at a blank `WorkshopCredit.sol`, ready to hand-write two hundred lines of balances, allowances, overflow checks, and events. Kuya JM stops him: nobody writes ERC20 from scratch — you inherit OpenZeppelin's audited version with one import and `is ERC20`.

**Question 1:** What does `contract WorkshopCredit is ERC20` actually do?
A. It copies OpenZeppelin's ERC20 source code into your file so you now maintain every line
B. It **inherits** ERC20 — WorkshopCredit *is* an ERC20 plus whatever you add, gaining real, tested bodies for `transfer`, `approve`, `transferFrom`, `balanceOf`, `allowance`, and `totalSupply` for free
C. It renames the ERC20 contract to WorkshopCredit
D. It creates an empty token with no functions until you write them yourself

**Answer:** B
**Explanation:** `is` means inheritance. Your contract stands on the audited base instead of copying it — you get all six functions and both events without typing a single body.

---

**Question 2:** Why is reusing OpenZeppelin described as *bayanihan*, and why is it safer than writing your own ERC20?
A. It isn't safer — hand-written code is always more secure because you control every line
B. OpenZeppelin has been read, reviewed, and audited by thousands of developers and security firms and holds real value in production; reusing it means the whole community carries the same hardened house instead of each person cutting their own kahoy
C. Bayanihan just means the code is free of charge
D. It's faster to type, but you still own and must audit every inherited line

**Answer:** B
**Explanation:** The value isn't just fewer keystrokes — it's inheriting code that's already been hardened and is fixed once, in the open, for everyone. Rewriting it by hand means owning every future bug alone.

---

**Question 3:** Why import and inherit rather than copy-paste OpenZeppelin's code into your file?
A. Copy-paste is illegal under OpenZeppelin's license
B. Inheriting references the hardened code untouched and lets upstream security fixes reach you; copy-pasting makes you the maintainer of code you didn't write, cuts you off from fixes, and bloats your file
C. There's no real difference; both produce identical, equally maintainable results
D. Copy-paste won't compile in Remix

**Answer:** B
**Explanation:** `import` + `is` keeps the base untouched and trustworthy. Pasting the code in makes you responsible for every line and severs you from upstream improvements.

---

**Question 4:** In `import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";`, what does the `@5.0.2` do, and why does it matter?
A. It's the file's line count and can be any number
B. It **pins the version** — you get exactly that audited release, not whatever is newest, so the code you tested is the code you deploy; v5 specifically is what gives WCR modern custom errors later
C. It sets the Solidity compiler version to 5.0.2
D. It's optional decoration that Remix ignores

**Answer:** B
**Explanation:** Pinning locks the exact reviewed release so nothing changes under you. It also matters because v5 uses custom errors like `ERC20InsufficientBalance` instead of old string messages.

---

# Quiz 2
## Scenario: The Compiler's Refusal

Dan writes `contract WorkshopCredit is ERC20 { }` with no constructor and hits Compile. Instead of a green check he gets: `TypeError: No arguments passed to the base constructor. Specify the arguments or mark "WorkshopCredit" as abstract.`

**Question 5:** What is the compiler actually complaining about?
A. A typo in the word "constructor"
B. The inherited ERC20 has a constructor that **requires two arguments** — a `name_` and a `symbol_` — and WorkshopCredit, having no constructor, never passed them; Solidity won't build a token with a half-finished base
C. The import line is wrong and the file couldn't be found
D. The Solidity version is too old to support inheritance

**Answer:** B
**Explanation:** OZ v5's ERC20 demands a name and a symbol before it can be built. With no constructor, WorkshopCredit supplied neither, so the compiler refuses — a rule about how the code fits together, not a typo.

---

**Question 6:** The error offers two ways out: "specify the arguments" or "mark abstract." Which does Dan want for a real Workshop Credit token, and why?
A. Mark it abstract — that's the faster fix and still lets him deploy
B. **Specify the arguments** — pass a name and symbol up to the base so WCR is a real, deployable token; marking it abstract would declare the contract intentionally incomplete and block deployment entirely
C. Either one works identically; the choice is purely stylistic
D. Neither — he should delete `is ERC20` and write the token by hand

**Answer:** B
**Explanation:** "Abstract" means "cannot be deployed as-is," which is useless for a token students must hold. Specifying the arguments finishes the job and produces a deployable token.

---

**Question 7:** Dan panicked at the red box, but the lesson reframes it. Why is this compile error a *good* thing?
A. It isn't — any error means the code is broken and untrustworthy
B. It caught a real problem (a nameless token) at Dan's desk in three seconds, pointed at the exact line, and named the missing arguments — enforcing that a token must have an identity before it goes live, so the mistake never reaches a student's counter
C. It proves OpenZeppelin's code is buggy
D. It only appears in Remix and won't happen on a real deployment

**Answer:** B
**Explanation:** It's the compiler-as-mentor beat from the Rust course, in Solidity. Errors caught at your desk are cheaper than disputes at the counter — the refusal is the setup, not the failure.

---
**Next:** Proceed to Lesson 6 exercises.
