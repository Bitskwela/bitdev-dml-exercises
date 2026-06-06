# Lesson 5 Quiz: Data Types

---
# Quiz 1
## Scenario: GCash-and-Cash Hour

It's the 15th — quincena. Dan is turning the morning's sales into code, and Kuya JM has just told him a two-day war story about a payment system whose daily report was off by exactly one centavo, every single day.

**Question 1:** Why does this course store pesos as `u32` instead of a float?
A. `u32` prints faster than `f64`
B. Money is a count, not a measurement — counts are integers; unsigned because the cash drawer never goes negative, and the ~4.29 billion ceiling is no real constraint for a carinderia
C. Rust does not support floating-point numbers
D. GCash's API requires `u32`

**Answer:** B
**Explanation:** Integers represent money exactly. `u32` is unsigned because a drawer can't hold a negative amount, and its range comfortably covers carinderia-scale revenue.

---

**Question 2:** In Rust (and Python, and JavaScript), `0.1 + 0.2 == 0.3` evaluates to `false`. Why?
A. A bug in Rust's compiler
B. Binary floating-point cannot represent 0.1 exactly — like 1/3 in decimal, it repeats forever and gets rounded, so the sum is actually 0.30000000000000004
C. The `==` operator is not defined for floats
D. 0.3 is secretly stored as an integer

**Answer:** B
**Explanation:** 0.1 is a repeating fraction in binary, so it's rounded on storage. The hair-thin error is real — and across thousands of additions per day it compounds into JM's Finance-rejecting centavo.

---

**Question 3:** What is a Rust `char`, exactly?
A. One byte, like in C
B. A 4-byte Unicode scalar value — which is why `'₱'` and `'ñ'` each fit in a single `char`
C. A string of length one, written in double quotes
D. An alias for `u8`

**Answer:** B
**Explanation:** `char` uses single quotes and is always 4 bytes — `std::mem::size_of::<char>()` returns 4. That's why one `char` holds `'₱'` with no mojibake and no multi-byte hacks.

---

**Question 4:** Dan mixes a `u32` with an `f64` in two different ways. Which error does each produce?
A. Both produce E0308
B. *Adding* them (`total + avg_rating`) raises **E0277** — "cannot add `f64` to `u32`", no implementation for the operator — while *comparing* them (`gcash_balance >= total`) raises **E0308** — "mismatched types"
C. Both produce E0277
D. Neither — Rust promotes the integer automatically, like Python

**Answer:** B
**Explanation:** Same disease, two symptoms: arithmetic mixing fails with E0277 (missing operator implementation between the types), comparison mixing fails with E0308 (mismatched types). Either way, Rust never converts silently.

---

# Quiz 2
## Scenario: Which Side Do You Cast?

A suki holds her phone over the counter: balance **₱358.25**. Dan types it as `f64` and compares it against the `u32` total of ₱285. The compiler refuses with E0308, and the fix is an explicit `as` cast — but there are two candidate fixes.

**Question 5:** Which cast is correct, and why?
A. `gcash_balance as u32` — floats should always be converted to integers
B. `total as f64` — cast the integer UP: every `u32` fits in an `f64` exactly, nothing lost; casting the float down would truncate 358.25 to 358, silently discarding ₱0.25 of real money
C. Either one — they are equivalent
D. Neither — both sides must be rewritten as strings

**Answer:** B
**Explanation:** `u32 → f64` is lossless; `f64 → u32` truncates — exactly the class of quiet loss this lesson exists to prevent. (The grown-up pattern: convert decimal money once, at the boundary, into integer centavos.)

---

**Question 6:** What does `avg_rating as u32` do to the value `4.6`?
A. Rounds it to 5
B. Truncates it to 4 — the decimals are simply cut off, not rounded
C. It's a compile error
D. Keeps the value 4.6 but changes only the label

**Answer:** B
**Explanation:** `as` truncates toward zero. That's the point of `as` being explicit and visible: if information gets lost, it's because you signed for it on that exact line.

---

**Question 7:** A `u8` holds 255 and the program adds 1. What happens?
A. It always wraps to 0 silently, in every build
B. In a debug build it panics with "attempt to add with overflow"; in a release build the check is skipped and the value silently wraps to 0 — so never rely on wrapping unless you ask for it by name (`wrapping_add`)
C. It always panics, in every build
D. The compiler rejects the program before it runs

**Answer:** B
**Explanation:** Overflow checks are on in debug builds and off in release builds. If you genuinely want wraparound math, say so explicitly with methods like `wrapping_add`.

---
**Next:** Proceed to Lesson 5 exercises.
