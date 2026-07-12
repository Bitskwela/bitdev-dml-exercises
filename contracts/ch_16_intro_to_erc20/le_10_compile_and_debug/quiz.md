# Lesson 10 Quiz: Compile and Debug

---
# Quiz 1
## Scenario: Break It on Purpose

Four lessons of nothing but green checks, and Kuya JM gets suspicious: Dan has never actually *read* a Solidity error. So JM sends over a sabotaged copy of WorkshopCredit — three classic bugs planted — with one rule: read each red box like a letter, and fix them top-down, one at a time.

**Question 1:** What is the difference between a red **error** and a yellow **warning** in the Solidity compiler?
A. They're the same thing shown in two colors; both stop compilation
B. An **error** fails the compile — no bytecode, nothing to deploy — while a **warning** compiles successfully but flags something suspicious; on a credit contract you still fix the yellow
C. A warning stops compilation and an error lets it through
D. Warnings only appear on a real network, never in Remix

**Answer:** B
**Explanation:** An error means there is no contract to deploy. A warning means the compiler built it but noticed a smell. On a token tracking real credits, you treat yellow like red and clean it up.

---

**Question 2:** A Solidity error is described as "a letter with four parts." What are they?
A. The gas cost, the block number, the sender, and the receipt
B. The **category word** (like `ParserError`), the **message**, the **`file:line:column`** location, and the **`^^^` caret** under the exact span
C. The contract name, the compiler version, the license, and the pragma
D. A title, a greeting, a body, and a signature

**Answer:** B
**Explanation:** The category tells you *what kind* of rule you broke, the message says *why*, the location says *where*, and the caret underlines the exact offending span. Read it top to bottom like a letter, not an alarm.

---

**Question 3:** Dan fixes three bugs but only ever sees **one** red box at a time. Why, and what habit does it teach?
A. Remix only displays one error to save screen space; you should guess the rest
B. The compiler runs in **stages** — parse, then resolve names, then check types — so an early error **hides** the later ones; the habit is to fix the topmost red, recompile, and let the next surface
C. The bugs were actually all the same error repeated three times
D. The compiler picks a random error each time, so order doesn't matter

**Answer:** B
**Explanation:** If the compiler can't parse the file, it never reaches name resolution or type-checking. That staging is why you fix top-down, one at a time — each fix uncovers the next real problem.

---

# Quiz 2
## Scenario: Three Letters

Dan compiles the sabotaged file and, one after another, meets a version-mismatch pragma, a misspelled keyword, and a deleted import — three different families of red.

**Question 4:** The first red box reads `Source file requires different compiler version (current compiler is 0.8.20...)`, underlining `pragma solidity ^0.7.0;`. What's wrong and what's the fix?
A. The word `pragma` is misspelled; retype it
B. The file's pragma asks for a `0.7`-era compiler that doesn't overlap with the `0.8.20` you're running; the fix is to change the version to `^0.8.20` so it matches the compiler (and OpenZeppelin 5.0.2's requirement)
C. Nothing is wrong; that box is just a warning you can ignore
D. The OpenZeppelin import is too new for any compiler

**Answer:** B
**Explanation:** A version pragma declares which compilers may build the file. `^0.7.0` excludes `0.8.20`, so the compiler refuses. Matching the pragma to the compiler you actually run clears it.

---

**Question 5:** After the pragma is fixed, a `DeclarationError: Identifier not found or not unique.` points at `ERC20` on the `contract WorkshopCredit is ERC20 {` line. Why isn't this a `ParserError`, and what's the fix?
A. It is a `ParserError`; the message is just worded differently
B. The grammar is perfectly readable — so it passed the parse stage — but the deleted `import` means the name `ERC20` was never introduced; the fix is to paste the OpenZeppelin import line back
C. The contract name `WorkshopCredit` is illegal and must be renamed
D. `ERC20` must be written in lowercase

**Answer:** B
**Explanation:** A `DeclarationError` comes from the name-resolution stage, which only runs after parsing succeeds. The line reads fine; the compiler simply can't find where `ERC20` was declared, because the import that brought it in was removed.

---

**Question 6:** The middle bug, `constructr`, produced `ParserError: Expected identifier but got '('`. What family is this and why?
A. A `TypeError`, because the constructor returns the wrong type
B. A `ParserError` — broken grammar — because `constructr` isn't a keyword Solidity recognizes, so the parser can't even read the declaration
C. A `DeclarationError`, because `constructr` was never imported
D. A warning, because misspellings are only advisory

**Answer:** B
**Explanation:** `constructor` is a keyword; `constructr` is not, so the parser fails at the grammar stage before any names or types are checked. Correcting the spelling to `constructor` fixes it.

---

**Question 7:** The lesson insists the compiler is "a mentor, not an alarm." What's the point of deliberately meeting these three errors in the sandbox?
A. To prove OpenZeppelin's code is buggy
B. So the families won't scare you at 2 a.m. before graduation — a red box caught at your desk, on a contract nobody deployed, is far cheaper than a dispute at the counter, the same lesson `E0382` taught in the Rust course
C. Because a contract with no errors can never be trusted
D. To make the file harder for other students to copy

**Answer:** B
**Explanation:** Errors caught at your desk are cheap; errors caught in production are not. Reading `ParserError`, `DeclarationError`, and a version mismatch on purpose turns future red boxes from panic into a letter you already know how to read.

---
**Next:** Proceed to Lesson 10 exercises.
