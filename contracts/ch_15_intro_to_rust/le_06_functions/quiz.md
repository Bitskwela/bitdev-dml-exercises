# Lesson 6 Quiz: Functions

---
# Quiz 1
## Scenario: The Third Paste

Dan copy-pasted the sukli-and-discount block into three projects, fixed a bug in only one copy, and Kuya JM gave him the rule: kapag inulit mo ng tatlong beses, function na 'yan. Dan rewrites the math as Rust functions.

**Question 1:** Dan writes `fn compute_change(paid, total) -> u32 { paid - total }`. What happens?
A. It compiles — Rust infers the parameter types from the body
B. It does not compile — parameter types are mandatory in Rust, unlike Python's optional hints
C. It compiles with a warning about missing types
D. It compiles but panics at runtime

**Answer:** B
**Explanation:** Every parameter must declare its type. They're not hints — the compiler uses them to check every call site in the program before it ever runs.

---

**Question 2:** What does `-> u32` in a function signature mean?
A. The function takes a `u32` argument
B. The function returns a `u32` value to its caller
C. The function may overflow at `u32::MAX`
D. It is optional documentation, like a Python type hint

**Answer:** B
**Explanation:** The arrow declares the return type. Omit the arrow entirely and the function returns the unit type `()` — "nothing meaningful here."

---

**Question 3:** This function won't compile — why?

```rust
fn compute_change(paid: u32, total: u32) -> u32 {
    paid - total;
}
```

A. Subtraction isn't allowed on `u32`
B. The trailing semicolon discards the value, so the body returns `()` while the signature promises `u32` — `error[E0308]: expected u32, found ()`
C. It's missing the `return` keyword, which is always required in Rust
D. Function bodies can't end with arithmetic

**Answer:** B
**Explanation:** A semicolon turns an expression into a statement and throws its value away. The compiler's `help:` line even prescribes the cure: *remove this semicolon to return this value*.

---

**Question 4:** Which of these is an *expression* (produces a value) rather than a statement?
A. `let x = 5;`
B. `{ let a = 2; a + 3 }` — a block whose last line has no semicolon evaluates to `5`
C. `paid - total;`
D. `let total = apply_senior_discount(125);`

**Answer:** B
**Explanation:** Even `{ }` blocks are expressions in Rust — they evaluate to their last semicolon-less line. A function body is just a big block, which is why its bare final expression is the return value.

---

# Quiz 2
## Scenario: Reading the Compiler's Receipt

Dan's three helpers — `compute_change`, `apply_senior_discount`, `receipt_line` — now live in one place each. He experiments with what the compiler accepts and rejects.

**Question 5:** What is the unit type `()`?
A. An empty array index
B. Rust's "nothing meaningful here" value — what a function returns when its signature has no `->`, or when a semicolon discards its last expression
C. A null pointer, like `None` in Python
D. A compile error in all contexts

**Answer:** B
**Explanation:** `fn greet_customer(name: &str) { println!(...) }` has no arrow, so it implicitly returns `()`. Side effects only — and the type is honest about it.

---

**Question 6:** Dan renames his function to `computeChange`. What does the compiler do?
A. Refuses to compile — camelCase is a syntax error
B. Compiles it, but emits `warning: ... should have a snake case name` — Rust convention is `snake_case` for functions and variables
C. Automatically renames it to `compute_change`
D. Nothing — naming style is never checked

**Answer:** B
**Explanation:** `snake_case` is enforced by a lint warning, not a hard error. The code builds — but the warning (and every Rust programmer reading the code) will nag until it's `compute_change`.

---

**Question 7:** Dan writes a function that returns a tuple and destructures the result:

```rust
fn senior_breakdown(subtotal: u32) -> (u32, u32, u32) {
    let discount = subtotal * 20 / 100;
    (subtotal, discount, subtotal - discount)
}

let (s, d, t) = senior_breakdown(125);
```

What are `s`, `d`, and `t`?
A. `125`, `25`, `100` — the tuple is the function's last expression, and the single `let` unpacks all three values
B. `125`, `100`, `25`
C. It won't compile — a Rust function can return only one value
D. `25`, `25`, `25`

**Answer:** A
**Explanation:** One value out (the tuple), three values inside. The tuple literal is the bare final expression, so it IS the return value; `let (s, d, t) = ...` destructures it in one statement.

---
**Next:** Proceed to Lesson 6 exercises.
