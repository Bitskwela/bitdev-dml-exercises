# Lesson 4 Quiz: Variables & Mutability

---
# Quiz 1
## Scenario: The Recipe You Cannot Edit

Dan's second-ever Rust program reassigns `cups_of_rice` — and for the first time in his life, a compiler tells him *no*.

**Question 1:** In Rust, what is true of a plain binding like `let cups_of_rice = 50;`?
A. It is mutable, like a Python variable
B. It is immutable by default — reassigning it is a compile-time error (E0384)
C. It is immutable only if you add a `final` keyword
D. It can be reassigned, but only once

**Answer:** B
**Explanation:** Rust bindings are immutable by default. Reassignment without `mut` is rejected at compile time with E0384 — before the program ever runs.

---

**Question 2:** Why did Rust's designers make immutability the default instead of mutability?
A. To make programs run faster
B. Because accidental, silent overwrites are one of the most common bug classes — a plain `let` guarantees the value never changes, so readers only need to watch the variables marked `mut`
C. Because the compiler cannot handle mutation
D. To save memory

**Answer:** B
**Explanation:** Change is the dangerous case, so change is the case that must be declared. In a 50,000-line codebase, that turns "audit every variable" into "audit the few marked `mut`."

---

**Question 3:** Dan scrolls to the bottom of the E0384 message and finds `help: consider making this binding mutable` with `let mut cups_of_rice = 50;` and `+++` markers underneath. What is the `help:` line?
A. A warning that the program may crash at runtime
B. A literal proposed fix — the compiler typed the corrected line and marked exactly where the three new characters go
C. A link to the Rust community forums
D. Part of the stack trace

**Answer:** B
**Explanation:** Rust errors very often end with a concrete patch. The error-reading ritual: error code first, then the `help:` line, then the span arrows (`------` marks where the binding was born, `^^^^^` marks the line that broke the rule).

---

**Question 4:** Tita Malou's tracker contains exactly this program. What happens?

```rust
fn main() {
    let mut cups = 50;
    cups -= 4;
    println!("{} cups left", cups);
}
```

A. error[E0384] — cannot assign twice to immutable variable
B. It compiles and prints `46 cups left` — `mut` is the explicit opt-in that makes the `-=` update legal
C. It compiles but prints `50 cups left`
D. It panics at runtime

**Answer:** B
**Explanation:** `mut` turns the rejection into a permission slip. The value can now change (the type still cannot), so the update runs and prints 46.

---

# Quiz 2
## Scenario: A New Price Card Over the Old One

Payday hits, and Dan re-plates the lunch price three times under one name.

**Question 5:** Does this compile — and if so, why?

```rust
let price = 70;
let price = price + 10;
let price = format!("P{} (payday)", price);
println!("{}", price);
```

A. No — error[E0384], `price` is assigned twice
B. Yes — each `let` is shadowing: a brand-new binding that reuses the name, so even the u32 -> String type change on the last line is legal
C. No — a variable's type can never change in Rust under any mechanism
D. Yes, but only because `format!` is a special macro

**Answer:** B
**Explanation:** Shadowing is not mutation. Each `let` creates a new binding that covers the old one — like a new price card taped over yesterday's — and a new binding is free to have a new type.

---

**Question 6:** Dan tries the same trick with mutation instead: `let mut price: u32 = 70;` then later `price = format!("P{} (payday)", price);`. What happens?
A. It compiles — `mut` allows any change
B. A type-mismatch error — `mut` lets the value change but the binding's type is locked at u32 forever; only shadowing (a new binding) can change the type
C. error[E0384] — cannot assign twice to immutable variable
D. It panics at runtime

**Answer:** B
**Explanation:** `mut` permits new values in the same binding, and a binding's type is fixed for its whole life. A String can never be assigned into a u32 binding — that move belongs to shadowing alone.

---

**Question 7:** Which declaration of the senior-discount house rule follows Rust's `const` requirements and conventions?
A. `const senior_discount = 20;`
B. `let SENIOR_DISCOUNT_PCT = 20;`
C. `const SENIOR_DISCOUNT_PCT: u32 = 20;` — type annotation required, SCREAMING_SNAKE_CASE name, value known at compile time
D. `mut const SENIOR_DISCOUNT_PCT: u32 = 20;`

**Answer:** C
**Explanation:** A `const` requires an explicit type annotation, uses SCREAMING_SNAKE_CASE by convention, and its value must be known at compile time and can never change. There is no such thing as `mut const`.

---
**Next:** Proceed to Lesson 4 exercises.
