# Lesson 8 Quiz: Loops

---
# Quiz 1
## Scenario: Three Loops, One Carinderia

Dan replaces his hand-typed eight-number addition with Rust's three loops: `for`, `while`, and `loop`.

**Question 1:** Which Rust loop can return a value directly, as in `let x = loop { ... break value; };`?
A. `for` — every loop in Rust is an expression
B. `while` — its condition becomes the value
C. Only `loop` — it's the only loop that guarantees you can't fall out the bottom without a `break`, so only it can promise a value
D. None — loops are statements in Rust and never produce values

**Answer:** C
**Explanation:** `loop` is an expression, and `break value;` makes the whole loop evaluate to that value. `while` and `for` can terminate on their own (condition turns false, items run out), so they can't promise a value.

---

**Question 2:** Dan wants to process all seven days of the week, so he writes `for day in 1..7 { ... }`. What happens?
A. It runs seven times — ranges include both ends
B. It runs six times (1 through 6) and silently skips the seventh day — `1..7` EXCLUDES 7; he needs the inclusive range `1..=7`
C. It does not compile — ranges must always use `..=`
D. It panics at runtime with an out-of-bounds error

**Answer:** B
**Explanation:** `1..7` yields 1, 2, 3, 4, 5, 6. The inclusive range `1..=7` yields all seven. One `=` is the difference between six days and seven — and the bug is silent, which is why you read ranges out loud until the difference is reflex.

---

**Question 3:** Which `while` condition compiles in Rust?
A. `while sales` — any non-zero number is truthy
B. `while count != 0` — the condition must be a real `bool`
C. `while 1` — C-style infinite loop
D. `while "open"` — non-empty strings are truthy

**Answer:** B
**Explanation:** Same rule as `if` in Lesson 7: Rust has no truthiness. The condition must be an actual `bool`, like a comparison. (For a deliberate infinite loop, Rust gives you the `loop` keyword instead.)

---

**Question 4:** Why is `for amount in sales` preferred over the manual `i = 0; while i < len; i += 1` indexing pattern?
A. It's only shorter to type — the two are otherwise identical
B. There is no index to get wrong, so off-by-one bugs can't exist — AND because the compiler can prove every access is in bounds, it deletes the bounds checks, making the safe loop also the fast loop
C. Manual indexing doesn't compile in Rust
D. `for` is safer but slower, a worthwhile trade

**Answer:** B
**Explanation:** The iterator hands items to the loop, so you can't run past the end — the loop stops exactly when the items do. The compiler uses that proof to remove the safety checks it would otherwise need. In Rust you don't trade safety for speed; you get both from the same `for`.

---

# Quiz 2
## Scenario: The Midnight Drag Race

Kuya JM dares Dan to sum 1 to 10 million in both languages. Python: 0.512s. Rust with `cargo run`: 81ms. Rust with `cargo run --release`: 11ms — all on the same secondhand laptop.

**Question 5:** Dan is about to post "Rust is 6x faster than Python!" based on the 81ms `cargo run` result. Why is that the wrong number to publish?
A. It's correct — `cargo run` is how Rust programs are always measured
B. `cargo run` builds in debug mode, where the compiler optimizes for fast recompiles, not fast code — benchmarking debug Rust is racing with the handbrake on; the only fair benchmark is `--release`, where the same code beat Python by ~45x
C. Python was the one running in debug mode, so the comparison favors Rust
D. 81ms and 512ms are too close to distinguish

**Answer:** B
**Explanation:** Debug builds deliberately skip optimization so the edit-compile-test loop stays instant. Release is the binary you actually ship — and the only honest basis for a speed claim. Same code, same laptop: 81ms in debug, 11ms in release.

---

**Question 6:** What does the compiler actually DO differently in `--release` that makes the same loop roughly 7x faster?
A. It caches the answer from the previous run and skips the loop
B. It inlines small functions into their callers, deletes code it can prove never runs, reorders and unrolls loops, and hands tight numeric loops to the CPU's vector instructions — several additions per step instead of one
C. It runs the program on the GPU instead of the CPU
D. Nothing — release timings vary randomly

**Answer:** B
**Explanation:** That's what "optimization" concretely means. Debug skips all of it on purpose — and also keeps integer-overflow checks that panic loudly, while release removes them and lets overflow wrap silently.

---

**Question 7:** Dan needs the INDEX of the first day whose revenue hit ₱5,000, straight out of the search. Which tool fits best, and why?
A. A `for` loop with a mutable `found` flag he checks after the loop ends
B. `loop` + `break day;` — the loop is an expression, so `let hit_day = loop { ... };` returns the index directly, with no flag variable and no post-loop cleanup
C. `while true` writing the result into a global variable
D. Recursion — loops can't produce results in Rust

**Answer:** B
**Explanation:** Search-and-return is exactly what `break`-with-value is for: the loop searches, the loop IS the answer. `while` and `for` would force the flag-variable dance because they can't carry a value out.

---
**Next:** Proceed to Lesson 8 exercises.
