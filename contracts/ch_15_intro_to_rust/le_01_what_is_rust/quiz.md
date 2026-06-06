# Lesson 1 Quiz: What is Rust?

---
# Quiz 1
## Scenario: Forty Seconds to Start, One Second to Die

Dan's Python sales report took forty seconds to start on the carinderia laptop, then crashed on row 113 — one blank weather cell, a `KeyError`, right in front of Tita Malou. Kuya JM says the fix is a compiled language whose compiler is "your strictest Ate."

**Question 1:** What is Rust's core claim as a systems programming language?
A. It runs a faster garbage collector than Python's
B. It achieves memory safety *without* a garbage collector — the compiler checks ownership rules at compile time and refuses to build code it can't prove safe
C. It lets the programmer manage memory by hand, exactly like C
D. It is an interpreted language with stricter typing

**Answer:** B
**Explanation:** Rust skips both the GC (Python/Java's runtime janitor, with its speed cost and pauses) and C's manual footguns. Ownership rules are checked at compile time; if the proof fails, no program is built.

---

**Question 2:** Why did Dan's *interpreted* Python script need forty seconds and a full environment on the old laptop?
A. Python files are larger than Rust files
B. Every machine that runs the script needs the interpreter plus every library (pandas, numpy) at the right versions — loaded fresh on every single run
C. Python recompiles the script into a binary on each machine
D. The script required an internet connection to start

**Answer:** B
**Explanation:** An interpreted program stays a text file; the interpreter and all dependencies must exist and wake up on the target machine, every run. That's the forty seconds — and why "just run it on Ma's desktop" was impossible.

---

**Question 3:** Tita Malou's desktop is ancient, offline, and will never have Python installed. Why is a compiled standalone binary the right fit for *her* situation?
A. Binaries are easier to edit when something goes wrong
B. The binary is one file of machine code the CPU executes directly — no interpreter, no libraries, no internet, no installs, and it starts in milliseconds
C. A compiled binary automatically corrects bad data in the notebook
D. Binaries only run on new hardware, which forces an upgrade

**Answer:** B
**Explanation:** Compile once on Dan's laptop, copy the one file by USB, double-click. The target machine needs nothing else. For an offline, Python-less desktop, the one-file property isn't a nice-to-have — it's the entire requirement. (It doesn't fix bad data — that's a separate problem.)

---

**Question 4:** "Every bug surfaces somewhere." What's the real difference between a compile-time error and a runtime crash?
A. Compile-time errors are worse because they stop you from shipping
B. A runtime crash surfaces while the program runs — in front of the user; a compile-time error surfaces while you build — at the programmer's desk, before a runnable file even exists
C. They are the same thing reported in different colors
D. Runtime errors only happen in interpreted languages

**Answer:** B
**Explanation:** The bug is the same category of mistake either way; what changes is *when* and *in front of whom* it surfaces. Rust's strictness moves the crash from Tita Malou's counter to Dan's desk. (Compiled programs can still hit runtime issues — Rust just catches whole families of them earlier.)

---

# Quiz 2
## Scenario: Reading the Refusal

In the Rust Playground, Dan uncomments three lines that use a `String` after its ownership moved to another variable. The compiler prints `error[E0382]: borrow of moved value: 'order'`, points arrows at the exact expression, and ends with a `help:` suggestion.

**Question 5:** What is `E0382` in that output?
A. The line number where the program crashed at runtime
B. Rust's error code for this category of mistake — you can look up the full explanation with `rustc --explain E0382` (or click it in the Playground)
C. A count of how many errors the program has
D. A memory address the program tried to access

**Answer:** B
**Explanation:** Every major rustc error has a code. The code is a stable handle for the whole error family — clickable in the Playground, explainable on the command line. Nothing crashed at runtime; no program was ever built.

---

**Question 6:** The `help:` line suggests `consider cloning the value if the performance cost is acceptable`. What does that suggestion — and its caveat — tell Dan about the compiler?
A. It suggests deleting the program and starting over
B. It proposes a concrete working fix (`.clone()` gives `moved` its own copy so `order` stays usable) *and* is honest about the cost — the compiler explains and teaches, it doesn't just refuse
C. It proves the error message is unreliable
D. It means the compiler will apply the fix automatically on the next run

**Answer:** B
**Explanation:** Strictest Ate, but she explains: exact line, the *why* (`String` doesn't implement `Copy`, so assignment moves it), and a suggested fix with its trade-off named. Learning to read this calmly is a skill the course trains on purpose.

---

**Question 7:** After the Playground session, Dan complains: "Rust rejected code Python would have just run. This is slower to write." What's the honest response?
A. Dan is mistaken — Rust is faster to write than Python in every way
B. Dan is right, and that's the deal: slower to *write* at first, because the compiler argues with you — in exchange, the program is faster and safer to *run* long-term. Dan writes it once; Tita Malou runs it every day, so the trade favors strict
C. Writing speed doesn't matter because Rust programs never have bugs of any kind
D. Python and Rust make exactly the same trade-offs, so it makes no difference

**Answer:** B
**Explanation:** The trade-off is real and JM made Dan read it twice. Rust front-loads the pain onto the programmer at the desk so it doesn't land on the user at the counter. (And no language eliminates *all* bugs — Rust refuses specific, important families of them at compile time.)

---
**Next:** Proceed to Lesson 1 exercises.
