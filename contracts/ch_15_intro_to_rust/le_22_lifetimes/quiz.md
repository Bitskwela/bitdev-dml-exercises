# Lesson 22 Quiz: Lifetimes

---
# Quiz 1
## Scenario: The Haunted Apostrophes

Eleven-forty PM. Dan writes `fn longest_dish_name(a: &str, b: &str) -> &str` and `cargo check` answers with `error[E0106]: missing lifetime specifier` — the exact error Jasper warned the group chat about months ago. The `help:` line suggests a fix full of `'a`.

**Question 1:** After the fix — `fn longest<'a>(x: &'a str, y: &'a str) -> &'a str` — what does `'a` actually promise?
A. The returned reference is guaranteed to stay valid until the end of the program
B. The result is borrowed from one of the inputs, so it must be treated as dead the moment the shorter-lived input dies — `'a` resolves to the overlap of the two input lifetimes at each call site
C. Both inputs are forced to live exactly as long as each other
D. The function allocates a new `String` so the result outlives both inputs

**Answer:** B
**Explanation:** The compiler solves for `'a` per call: the region where BOTH inputs are valid — concretely, the shorter-lived one wins. Use the result while both owners are alive and it compiles; use it after the shorter one is dropped and it's E0597, no exceptions.

---

**Question 2:** What did adding the `'a` annotations change about the program at runtime?
A. Values labeled `'a` now live slightly longer, so the returned reference stays valid
B. Nothing. Annotations DESCRIBE relationships between borrows, never extend them — every value still dies at the end of its owner's scope, and lifetimes are erased after checking: zero runtime cost
C. The compiler inserts cleanup code that frees the shorter-lived input earlier
D. The function now clones the winning string instead of borrowing it

**Answer:** B
**Explanation:** The rule that every lifetime confusion traces back to: lifetime annotations describe relationships, never extend lifetimes. No `'a` keeps a value alive one nanosecond longer — it's the return time written on the chalkboard, a schedule the compiler enforces, not new behavior.

---

**Question 3:** Lesson 11's `fn first_word(s: &str) -> &str` returns a borrow too — yet it never triggered E0106. Why?
A. String functions are exempt from lifetime checking
B. `first_word` is shorter than `longest`, and short functions get inferred automatically
C. Elision rule 2: with exactly ONE input lifetime, it is assigned to every output reference — the borrow out must come from the one borrow in. `longest` has TWO input lifetimes and isn't a method, so the rules come up empty and the compiler asks you
D. Dan got lucky — it would fail on a newer compiler

**Answer:** C
**Explanation:** The elision rules infer the obvious cases mechanically, which is why explicit lifetimes are RARE: everything in Lessons 1-21 compiled without a single `'a`. E0106 just means "the elision rules whiffed; your turn."

---

**Question 4:** What is the difference between E0106 and E0597?
A. They are the same error with different numbers
B. E0106 is a *question about a signature* — a returned borrow with no story, asked before any call is checked. E0597 is a *verdict at a call site* — a value was dropped while a borrow tied to it was still in use
C. E0106 is a warning; E0597 is an error
D. E0106 happens at runtime; E0597 happens at compile time

**Answer:** B
**Explanation:** Both are compile-time. E0106 ("missing lifetime specifier") means the contract has a hole — the compiler refuses to guess whose borrow comes back. E0597 ("does not live long enough") means the contract was written, and some code just violated it: a borrow outlived its owner.

---

# Quiz 2
## Scenario: The Scope Fortune-Teller

Dan's annotated `longest<'a>` is live. Two nearly identical callers land in his file. Caller ONE:

```rust
let a = String::from("Lechon Kawali");
let pick;
{
    let b = String::from("Turon");
    pick = longest(&a, &b);
    println!("{}", pick);
}
```

Caller TWO is identical except the `println!` sits one brace down — after the inner scope closes.

**Question 5:** Caller ONE — compiles or not?
A. Fails — `pick` is declared in the outer scope, so the borrow illegally escapes the inner one
B. Compiles — the borrow checker tracks last USES, not declarations: `pick`'s last use is the `println!` INSIDE the inner braces, while `b` is still alive, so the promise holds
C. Fails — `longest` results can never be assigned to a variable declared in an outer scope
D. Compiles, but panics at runtime when the inner scope closes

**Answer:** B
**Explanation:** This is the trap. Where `pick` is *declared* means nothing; the borrow checker cares where it is *used*. Its last use happens before `b`'s funeral, so the signature's promise — result dies with the shorter-lived input — is never broken.

---

**Question 6:** Caller TWO — "Lechon Kawali" is longer than "Turon", so at runtime `pick` would point at `a`, which is still alive at the `println!`. Compiles or not?
A. Compiles — the compiler evaluates the lengths and sees the result borrows from `a`
B. Fails with E0597, every run including the lucky ones: the signature promises the result dies with the shorter-lived input, and the compiler doesn't gamble on `.len()` — `b` is dropped while `pick` may still be borrowed from it
C. Compiles with a warning about an unused borrow
D. Fails with E0106 — the call site is missing a lifetime specifier

**Answer:** B
**Explanation:** Which input comes back depends on runtime data, so the compiler holds every call to the signed contract: treat the result as dead when the shorter-lived input dies. One brace of distance between Caller ONE and Caller TWO is the difference between legal and impossible. (And it's E0597, not E0106 — the signature is fine; this *use* is not.)

---

**Question 7:** `BestSeller<'a> { name: &'a str }` works in tonight's exercise — yet every other struct in this course holds `name: String` instead. What's the reasoning?
A. References in structs are deprecated; `String` fields are the only supported style
B. A borrowed field makes the struct cheaper, but the course avoids it to keep lessons simple — real code should always borrow
C. A reference field means the struct may never outlive the data it borrows from, and you owe the compiler a written `<'a>` schedule for that loan. Owning `String` removes the constraint entirely — right for a desktop tool whose data should own itself — while borrowing structs earn their keep in zero-copy, short-lived-view code
D. `&str` fields can't be printed, so owning `String` is required for output

**Answer:** C
**Explanation:** Lesson 12's sticky note — functions take `&str`, structs own `String` — was guarding this exact door. `BestSeller<'a>` is a poster that cannot outlive the dish: fine for short-lived views, a liability for long-lived data. Know the door exists; keep it closed by default.

---
**Next:** Proceed to Lesson 22 exercises.
