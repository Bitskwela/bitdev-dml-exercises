# Lesson 7 Quiz: Control Flow

---
# Quiz 1
## Scenario: The Rain Remembers

Rain hits at 2 PM and the carinderia turns into a sinigang machine. Dan rebuilds Luto v1 — his first-ever Python `if/elif` rule engine — as a Rust binary, and Python muscle memory gets him exactly once.

**Question 1:** Dan types `let quantity = 3; if quantity { ... }`, exactly the way idiomatic Python allows. What does Rust do?
A. Treats `3` as truthy and runs the body, same as Python
B. Refuses to compile with E0308 — expected `bool`, found integer. Rust has no truthiness; the condition must be an actual `bool`, like `quantity > 0`
C. Runs the body only when `quantity` is exactly 1
D. Compiles, but prints a runtime warning

**Answer:** B
**Explanation:** `if` takes a `bool` — not an integer that implies one. Truthiness is a quiet bug factory (`if discount:` is false in Python when a zero-peso discount is real, deliberate data), so Rust makes you say exactly what you mean.

---

**Question 2:** Which trio correctly describes Rust's branching syntax compared to Python's?
A. `elif`, indentation for bodies, parentheses required around conditions
B. `else if` instead of `elif`, braces `{ }` always required (even for one-line bodies), no parentheses needed around the condition
C. `elseif`, semicolons end each branch, conditions in parentheses
D. `case` keywords with mandatory `break`

**Answer:** B
**Explanation:** Three small differences from the Luto v1 chain: `else if` not `elif`, braces always, and rustc even warns if you add unnecessary parentheses around the condition.

---

**Question 3:** Dan adds merienda mode: at `hour >= 15` it must outrank every weather rule. Where in the `if` / `else if` chain does the new branch go, and why?
A. Last, so it gets the final word
B. First — branches are checked top to bottom and the first true condition wins, so a rule that outranks the others must be checked before them
C. Anywhere; Rust evaluates all branches and picks the most specific one
D. Inside the final `else`

**Answer:** B
**Explanation:** The first true condition wins and everything after it is skipped. At 4 PM on a rainy day, a merienda branch placed after `weather == "rainy"` would never run — the sinigang rule would shadow it.

---

**Question 4:** In Python, `if discount:` is false when `discount` is `0`. Why does Rust's "no truthiness" rule treat this as a feature worth seven extra keystrokes?
A. Integer-to-bool conversion is slow at runtime
B. A discount of zero pesos might be real, deliberate data — not "no discount." Rust refuses to guess which one you meant; `discount > 0` removes the ambiguity forever
C. Rust cannot represent the number zero in a condition
D. It is a historical accident kept for backwards compatibility

**Answer:** B
**Explanation:** Truthiness silently conflates "zero" with "absent." Writing the comparison out states exactly which question the code is asking, and the compiler enforces it.

---

# Quiz 2
## Scenario: The Computer Agrees with Her Again

Tita Malou reads Dan's screen — "Sinigang na Baboy... comfort food for a rainy day" — and the program prices it with `let price: u32 = if is_payday { 80 } else { 70 };`.

**Question 5:** Why is there no semicolon after `80` and `70` inside the arms?
A. Semicolons are optional everywhere in Rust
B. The last expression of a block, without a semicolon, IS the block's value — Lesson 6's return rule applied to every block. A semicolon would turn the value into a statement, and the arm would produce nothing
C. rustfmt removes them automatically
D. Numbers never take semicolons

**Answer:** B
**Explanation:** Each arm hands its last expression to the whole `if` expression, which lands in `price`. The semicolon after the closing `}` belongs to the `let`, not the arm.

---

**Question 6:** Dan changes one arm: `let price = if is_payday { 80 } else { "seventy" };`. What happens?
A. It compiles; `price` becomes a string on regular days
B. E0308 — `if` and `else` have incompatible types. `price` is one variable with one type, so every arm must produce that same type; the compiler locked in "integer" at `80`, then `"seventy"` arrived as a `&str` and the deal collapsed
C. Rust converts `"seventy"` to `70` automatically
D. It compiles with a warning and defaults to `0`

**Answer:** B
**Explanation:** An `if` used as an expression must give the variable a single type. The fix is to make every arm speak the same type — `80` and `70`, both `u32`, both whole pesos.

---

**Question 7:** Tita Malou shrugs: "Ulan, sinigang. Hindi ko kailangan ng computer para malaman yan." In both Luto v1 (Intro to AI, Lesson 1) and this Rust rebuild, where did the rules actually come from?
A. The compiler inferred them from the weather data
B. From Tita Malou herself — a rule-based system encodes human expertise, and Dan just typed his mom's brain into a file; Rust only made the encoding stricter and compile-checked
C. From a machine learning model trained on sales
D. Rust's standard library ships with carinderia defaults

**Answer:** B
**Explanation:** That's the Luto v1 continuity: the computer "agrees" with her because she wrote the rules — Dan was the typist. The branching logic is the same; only the language (and its strictness) changed. The computer needs someone like her para may malaman.

---
**Next:** Proceed to Lesson 7 exercises.
