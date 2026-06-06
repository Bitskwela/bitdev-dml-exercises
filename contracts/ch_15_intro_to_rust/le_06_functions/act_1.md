# Turn the Sukli Math into Functions

Dan copy-pasted the same five lines into three projects and fixed the bug in only one of them. Tonight: write each helper ONCE. Open `act_1.rs` — three signatures are waiting for bodies, and `main` is waiting to be wired up.

---

## Task 1: `compute_change`

Sukli math, written once, called everywhere. In `fn compute_change(paid: u32, total: u32) -> u32`, replace `todo!()` with the formula from the starter comment: `paid - total`. Remember: the last expression takes NO semicolon — that bare expression IS the return value. No `return` keyword needed.

## Task 2: `apply_senior_discount`

The 20% senior citizen discount is not optional courtesy — Republic Act 9994 legally mandates it in the Philippines. Every carinderia, every fast food counter, every pharmacy. Return the total *after* taking 20% off. Careful: `total * 20 / 100` alone is the *discount amount*, not the discounted total — that exact bug is what bit Dan three times this week.

## Task 3: `receipt_line`

Format one line of the receipt. `format!` works exactly like `println!` but hands back a `String` instead of printing. Use `"{:<18} ₱{:>4}"` — dish left-aligned in 18 columns, price right-aligned in 4, so the receipt lines up like a real POS. (`&str` is a *borrowed* string — you get to look at the text without owning it. That sentence is all you need today; the full `String` vs `&str` story is Lesson 12.)

## Task 4: Wire Up `main`

Uncomment the marked `// TODO` blocks in `main` and build Lola Cion's Tuesday receipt: three items, subtotal, senior discount, bayad ₱200, sukli.

---

## Sample Output

```text
===== LUTO CARINDERIA — Order #042 =====

Sinigang na Baboy  ₱  95
Kanin              ₱  15
Extra Kanin        ₱  15
------------------------------
Subtotal           ₱ 125
Senior 20% off     ₱ 100
Bayad              ₱ 200
Sukli              ₱ 100

Salamat po, Lola. Balik kayo bukas!
```

---

## Reflection Questions

1. Put a reflex semicolon after `paid - total` in `compute_change` and run `cargo check`. What does `error[E0308]: expected u32, found ()` mean, and what does the `help:` line tell you to do?
2. `apply_senior_discount(125)` returns `100`. Trace the arithmetic: where does the `25` go, and why would returning `total * 20 / 100` bankrupt Lola Cion's bill instead?
3. Parameter types are mandatory in Rust but optional hints in Python. What class of bug does this eliminate at compile time instead of at the counter?

---

## Challenge: One Function, Three Answers

Sometimes the caller wants the whole breakdown, not just the final number. A function can return a tuple:

```rust
fn senior_breakdown(subtotal: u32) -> (u32, u32, u32) {
    // return (subtotal, discount, total) — in that order
}
```

Then destructure it in `main` with a single `let`:

```rust
let (s, d, t) = senior_breakdown(125);
println!("Subtotal ₱{} | Discount ₱{} | Total ₱{}", s, d, t);
```

For `125` you should get `(125, 25, 100)`. Notice the tuple itself is the last expression of the function — one value out, three values inside.

---

## What You've Learned

- `fn` with mandatory parameter types and `->` return types — checked at every call site before the program runs
- The last semicolon-less expression of a function body IS the return value; a trailing semicolon discards it and returns `()`
- `format!` builds a `String`, `&str` borrows one, and the sukli math now lives in exactly one place
