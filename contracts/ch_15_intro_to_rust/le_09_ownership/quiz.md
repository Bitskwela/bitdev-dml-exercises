# Lesson 9 Quiz: Ownership

---
# Quiz 1
## Scenario: The Hour Against the Wall

Dan writes the most innocent code of his week — make a `String` order, pass it to `print_order`, print it again — and `cargo check` answers with `error[E0382]: borrow of moved value: order`. One hour later, Kuya JM explains it with a cash drawer that has exactly one key.

**Question 1:** Which of the following correctly states Rust's three ownership rules?
A. Every value has many owners; owners share freely; memory is freed by a garbage collector
B. Every value has exactly one owner; assigning or passing a heap-backed value moves ownership; when the owner goes out of scope, the value is dropped
C. Every value has exactly one owner; ownership can never change hands; values are freed manually with `free()`
D. Values are copied on every assignment; nothing is ever dropped; the programmer frees the heap

**Answer:** B
**Explanation:** One drawer, one key, one owner; a move hands the key away; and the drop at end of scope is the payoff — the compiler always knows exactly who frees what, and when. No janitor at runtime, no manual `free`, no cost.

---

**Question 2:** Predict the verdict. Does this compile?

```rust
let a = String::from("adobo");
let b = a;
println!("{} {}", a, b);
```

A. Compiles — `b` is a copy of `a`, both stay valid
B. Compiles — but prints an empty string for `a`
C. Fails with E0382 — `let b = a;` moves ownership of the String to `b`, so printing `a` uses a moved value
D. Fails because two variables can never hold the same text

**Answer:** C
**Explanation:** Assignment hands the key exactly like a function call does. Only the stack trio (pointer, length, capacity) is copied to `b`; the old binding `a` is stamped INVALID at compile time. That invalidation is what makes a double free impossible.

---

**Question 3:** In the full E0382 error message, what does the final `help:` section give you?
A. A link to the Rust forum
B. A literal patch — `print_order(order.clone());` with `++++++++` marking exactly which characters to add
C. The memory address of the moved value
D. A suggestion to switch back to Python

**Answer:** B
**Explanation:** E0382's anatomy is a mentor's diagram, not an enemy's insult: the headline, the `value moved here` arrow, the `value borrowed here after move` arrow, a note naming the function that took ownership — and a `help:` line holding a copy-pasteable fix.

---

**Question 4:** Dan passed `u32` prices to functions for eight straight lessons and never saw E0382. Why?
A. Numbers are too small for the compiler to track
B. `u32` is stack-only and implements the `Copy` trait — the function receives a photocopy, and both bindings stay valid
C. Functions cannot take ownership of numbers
D. The compiler only checks `String` variables

**Answer:** B
**Explanation:** Stack-only types like `u32`, `i64`, `bool`, `char`, and `f64` are so cheap to duplicate (about one CPU instruction) that Rust just copies them. `String` doesn't get to be `Copy` because copying it means a real heap allocation — and Rust refuses to hide real costs behind an innocent-looking `=`.

---
# Quiz 2
## Scenario: The Clone Audit

Dan's first working pipeline clones everything in sight. Kuya JM's policy says that's fine — but Dan still wants to know exactly when each String lives, moves, and dies.

**Question 5:** Predict the verdict. Does this compile?

```rust
let name = String::from("tortang talong");
shout(name);
shout(name);

// helper:
fn shout(order: String) { println!("{}!!!", order.to_uppercase()); }
```

A. Compiles — functions return ownership automatically
B. Fails with E0382 — the first `shout(name)` moves the key in and the String is dropped at the function's closing brace; the second call has nothing to give
C. Fails because `to_uppercase()` is not allowed on owned Strings
D. Compiles — `String` is a `Copy` type

**Answer:** B
**Explanation:** The first call moves ownership into `shout`, where the value is dropped when the parameter leaves scope. This one's headline reads `use of moved value` instead of `borrow of moved value` — same E0382, same funeral, slightly different wording because you tried to move it again rather than print it.

---

**Question 6:** What is the course policy on `.clone()`?
A. Never clone — clones are an admission of failure
B. Clone first, understand the move, optimize later — a clone is explicit, correct, and visible, and nobody gets shamed for one
C. Clone everything forever; optimization is never needed
D. Only clone `u32` values

**Answer:** B
**Explanation:** `clone()` is the honest escape hatch: a deep copy you ask for by name, suggested by the compiler itself in the `help:` line. Some clones can later be replaced by something cheaper (borrowing — the next lesson), but a working program with three honest clones beats a rage-quit with zero.

---

**Question 7:** When is the heap memory behind a `String` actually freed?
A. At the next garbage-collection pause
B. When the programmer calls `free()`
C. When its owner goes out of scope — the value is dropped automatically, exactly once, at a line the compiler knows in advance
D. Never — Rust leaks Strings by design

**Answer:** C
**Explanation:** Rule 3. In `fn print_order(order: String) { ... }` the String dies at the function's closing brace, because that's where its owner leaves scope. One owner means the compiler always knows who frees what and when — no leaks, no double frees, no use-after-free, all settled before the program runs.

---
**Next:** Proceed to Lesson 9 exercises.
