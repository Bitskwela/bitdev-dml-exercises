# Lesson 15 Quiz: Pattern Matching

---
# Quiz 1
## Scenario: Every Coin Gets a Tray

Saturday closing. Tita Malou sorts the coin can — one tray per coin — while Dan writes his first `match` to finally get the reference number out of `Payment::GCash(String)`.

**Question 1:** The ref number is stored inside `Payment::GCash(String)`. How does Dan get it OUT?
A. He can't — data inside an enum variant is permanently locked
B. With a pattern that names the data in the variant's slot: `Payment::GCash(ref_no) => format!("GCash ref {}", ref_no)` — the pattern checks the variant AND binds its contents
C. Tuple-style field access: `payment.0`
D. By calling `payment.unwrap()` on the enum

**Answer:** B
**Explanation:** A pattern does two jobs at once: it tests *which* variant the value is, and binds the data inside to a name usable in that arm's body (and only there). That's the Lesson 14 jailbreak — the data was never unreachable, it was waiting for a pattern shaped like its variant.

---

**Question 2:** Dan's first `match` on a `Payment` covers `Cash`, `GCash`, and `Maya` — he forgets `Utang`. What happens?
A. It compiles; Utang orders are silently skipped at runtime
B. It compiles; the program crashes when the first Utang order arrives
C. It does not compile — `error[E0004]: non-exhaustive patterns: Utang not covered`. A `match` must cover every possible case, and the error even suggests the missing arm
D. It compiles with a lint warning he can ignore

**Answer:** C
**Explanation:** Exhaustiveness checking makes the forgotten case a compile error tonight, not a runtime bug three weeks from now in front of a customer. The compiler points at the uncovered variant and the `help:` line literally writes the missing arm.

---

**Question 3:** `describe`'s entire body is one `match` — no `return` statement anywhere. Why does it still return a `String`?
A. Rust functions return the last println automatically
B. `match` is an expression: every arm produces the same type, and the match evaluates to whichever arm ran — so the function body evaluates to that `String`
C. It doesn't — this only works because String is special
D. The compiler inserts `return String::new()` as a fallback

**Answer:** B
**Explanation:** Like `if` in Lesson 7, `match` produces a value. All arms must agree on one type; the match evaluates to the arm that ran. You can assign it, return it, or make it an entire function body.

---

**Question 4:** Dan matches `tip: Option<u32>` with only a `Some(t)` arm and deletes the `None` arm. What happens, and how does that compare to the Python crash that started the course?
A. It compiles — `None` is rare enough that Rust lets it slide
B. It panics at runtime when a `None` shows up, same as Python
C. It does not compile — E0004 again. The "forgot the blank cell" bug that crashed Dan's Python report becomes a compile error: same bug class, opposite default
D. Rust auto-inserts `None => {}` for him

**Answer:** C
**Explanation:** `Option<T>` is just an enum — `Some(T)` or `None` — so exhaustiveness applies. Python let Dan forget the empty case until it exploded on a Sunday; Rust refuses to build until the empty case has a tray.

---

# Quiz 2
## Scenario: The Card Reader Arrives

Tita Malou says yes to the bank: card payments with approval codes start Monday. Dan adds `Card(String)` to the `Payment` enum and runs `cargo check`.

**Question 5:** Dan added the variant but hasn't touched any other code. What happens at compile time?
A. Nothing — adding a variant never affects existing code
B. Every `match` on `Payment` that doesn't handle `Card` becomes a listed compile error — file, line number, suggested fix. The compiler walks the whole program and hands Dan a refactoring checklist
C. The program compiles but crashes on the first card payment
D. Only the `match` closest to the enum definition errors; he has to grep for the rest

**Answer:** B
**Explanation:** This is exhaustiveness working in the second direction — the payoff. In Dan's program: two errors, two line numbers (`describe` and the closing tally). Add the variant, then follow the red until it's green. The compiler does the remembering.

---

**Question 6:** Jasper's version of the tally ends with `_ => other_count += 1`. He adds `Card(String)` and runs `cargo check`. What happens?
A. Same as Dan — E0004 points him to the tally
B. It compiles clean — and that's the trap: `Card` slides silently into the "other" tray, miscounted and unflagged. The `_` satisfied exhaustiveness forever, so the bodyguard can't warn about doors he's been told to ignore
C. The compiler warns that `_` now matches a new variant
D. `_` only matches the variants that existed when it was written, so Card panics

**Answer:** B
**Explanation:** A bare `_` catch-all on an enum you own hides new cases instead of handling them. `_` is honest on unlistable domains (you can't write four billion `u32` arms), but on your own enums, spell out every arm.

---

**Question 7:** For the tip line, only `Some(tip)` matters — `None` means "print nothing." Which tool fits, and what's the rule?
A. A full `match` with `None => {}` — always prefer match, no exceptions
B. `if let Some(tip) = order.tip { ... }` — it deliberately trades exhaustiveness for brevity, which is fine exactly when ignoring the other case is the plan: "match when you care about every case; if let when you care about one"
C. `unwrap()` — tips are usually present anyway
D. A `while let` loop over the tip

**Answer:** B
**Explanation:** The empty `None => {}` arm is ceremony. `if let` binds and runs on one pattern and skips otherwise (an `else` is allowed). Just know the trade: you give up the bodyguard on purpose — safe here, dangerous when you actually cared about every case.

---
**Next:** Proceed to Lesson 15 exercises.
