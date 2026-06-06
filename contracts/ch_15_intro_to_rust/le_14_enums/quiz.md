# Lesson 14 Quiz: Enums

---
# Quiz 1
## Scenario: The Tray That Doesn't Exist

Dan's tally script once reported the GCash total P120 short — the notebook said `GCash`, `gcash`, and `Gkash`, and the string comparison silently matched nothing. Tonight he replaces the string with `enum Payment { Cash, GCash(String), Maya(String), Utang }`.

**Question 1:** Why does an enum beat a `String` for a payment-method field?
A. Enums use less memory, and that's the whole advantage
B. A `String` can hold anything — every misspelling type-checks and fails silently at runtime — while an enum lists every possible value at the definition, so the type itself *is* the truth: a `Payment` can only be one of the four declared variants
C. Strings are not allowed inside structs in Rust
D. Enums automatically fix misspelled input from users at runtime

**Answer:** B
**Explanation:** Whenever a type allows more than the truth ("any text" vs. "exactly four payment methods"), the gap eventually becomes a bug. The enum closes the gap: `"Gkash"` compiles fine as a `String` but does not exist as a `Payment` variant.

---

**Question 2:** For science, Dan deliberately writes `Payment::Gkash(String::from("REF-2384-001"))` — Tita Malou's 6 AM typo. What happens?
A. It compiles, and the payment silently matches nothing at runtime — same as the string version
B. It compiles but panics at runtime when the variant is printed
C. It does not compile — E0599, "no variant or associated item named `Gkash`" — and the compiler's `help:` line even suggests the correct spelling, `GCash`, because it can see the full list of variants
D. Rust creates the `Gkash` variant automatically on first use

**Answer:** C
**Explanation:** The typo that once cost a recount, a false customer suspicion, and half an hour of panic now costs one `cargo check` — and the fix comes attached. Compile-time errors with suggestions are exactly the trade the enum buys.

---

**Question 3:** What do the parentheses in `GCash(String)` mean, compared to the bare `Cash` variant?
A. `GCash` is a function and `Cash` is a constant — they are unrelated kinds of things
B. The `GCash` variant carries data inside it — you *cannot* construct a `GCash` without its reference String, and `Cash` *cannot* smuggle one in; each tray's shape is part of the menu
C. Parentheses are optional decoration; `GCash` and `Cash` both store a String
D. `GCash(String)` means the variant can hold any number of values of any type

**Answer:** B
**Explanation:** Variants can carry data, and the data is glued to the variant. `Payment::GCash` alone is just a constructor still waiting for its String — that's the `fn(String) -> Payment` in Dan's E0369 error. `Cash` needs no data, so it carries none.

---

**Question 4:** Dan's struct is `Order { dish: String, total: u32, payment: Payment, tip: Option<u32> }`. Which guarantees does this composition enforce *before the program ever runs*?
A. None — structs only check types at runtime
B. Only that the fields exist; their contents are unchecked
C. Every `Order` must have a payment; that payment can only be one of the four real methods; a GCash payment always carries its reference; and the tip is honestly optional — four business rules, enforced at compile time
D. That the tip is always present, because `Option<u32>` defaults to `Some(0)`

**Answer:** C
**Explanation:** Types compose: a struct (AND) holding an enum (OR) and an `Option` (maybe). Each layer encodes a business rule the compiler enforces — the drawer's whole truth, typed.

---

# Quiz 2
## Scenario: No Tip, No Null

The jeepney driver said "keep the change" (`tip: Some(5)`); the lunch and merienda orders have no tip at all. Dan needs the tip-jar total — and remembers the `None`-shaped blank cell that once ended his Sunday demo in Python.

**Question 5:** Rust has no null. How does it represent the possibly-missing tip instead?
A. With `tip: u32` set to 0, since zero means "no tip"
B. With a special `null` value that only `Option` fields may hold
C. With `tip: Option<u32>` — a standard-library enum, `Some(T)` or `None`: absence is a *type of its own*, visible right on the struct, and the compiler forces you to handle the "eh kung wala?" case before the code compiles
D. With an empty `String` in place of the number

**Answer:** C
**Explanation:** Null is a non-value in a value's uniform that explodes when touched — its inventor calls it the billion-dollar mistake. Rust makes absence a type: an `Option<u32>` is not a `u32` in disguise, so forgetting the missing case is a compile error, not a 12:40 PM crash in front of customers.

---

**Question 6:** With tips `Some(5)`, `None`, and `None`, what does `breakfast.tip.unwrap_or(0) + lunch.tip.unwrap_or(0) + merienda.tip.unwrap_or(0)` evaluate to, and why?
A. It panics on the first `None`
B. `5` — `unwrap_or(default)` takes the value inside a `Some`, and substitutes the default you supplied for each `None`; no crash is possible because the fallback came from you
C. It does not compile — you cannot add `Option<u32>` values
D. `0` — `unwrap_or` always returns the default

**Answer:** B
**Explanation:** `Some(5)` yields 5; each `None` yields the supplied 0. For tips, `None` honestly means zero pesos, so `unwrap_or(0)` is both safe and correct — the gentle first Option tool.

---

**Question 7:** Reviewing a classmate's drawer code, Dan finds `let tip = order.tip.unwrap();` with no comment. What's wrong, and what does house policy demand?
A. Nothing — `unwrap()` and `unwrap_or(0)` are interchangeable
B. `unwrap()` doesn't compile on `Option`; only `unwrap_or` exists
C. `unwrap()` silently converts `None` to 0, which hides bugs
D. `unwrap()` **panics** — crashes the whole program — if the tip is `None`; it's tolerated only in prototypes and only with a confession label like `// PROTOTYPE: crashes on None`, because every `unwrap()` is a debt that proper error handling (Lesson 16) must pay off

**Answer:** D
**Explanation:** The blunt tool takes the value out or kills the program. The house policy makes the risk visible: label it, treat it as a debt, and replace it before anyone — especially Ma — touches the code.

---
**Next:** Proceed to Lesson 14 exercises.
