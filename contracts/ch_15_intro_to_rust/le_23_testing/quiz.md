# Lesson 23 Quiz: Testing

---
# Quiz 1
## Scenario: Receipts or It Didn't Happen

Dan posts a screenshot of LutoCLI's clean receipt output. Ate Rina DMs back: "How do you know the numbers are right? Bata, LutoCLI computes Tita Malou's money. *Prove* it works."

**Question 1:** What makes a Rust function a test, and how does it pass or fail?
A. Any function whose name starts with `test_`; it passes if it returns `true`
B. A function marked with the `#[test]` attribute; `cargo test` finds and runs it, and it passes by running to the end without panicking — any panic (usually from a failed `assert!`) means it fails
C. A function listed in a `[tests]` section of `Cargo.toml`; it passes if it compiles
D. Any function called from `main()`; it passes if `main` prints output

**Answer:** B
**Explanation:** `#[test]` is the entire registration — no framework to install. Pass = finished without panicking; fail = panicked. The `assert!` family exists precisely to panic with a useful report when reality doesn't match expectation.

---

**Question 2:** Dan's tests live in `#[cfg(test)] mod tests { use super::*; ... }` at the bottom of `src/main.rs`. What happens to that module when he runs `cargo build --release` for the USB stick?
A. The tests run once before the build, as a safety gate
B. The tests are compiled into the binary but skipped at runtime
C. The module is never compiled at all — `#[cfg(test)]` is conditional compilation, so Tita Malou's binary carries zero bytes of test code; the proof stays in the kitchen, only the dish goes out
D. The build fails unless the test module is deleted first

**Answer:** C
**Explanation:** `#[cfg(test)]` compiles the module only for `cargo test`. Not skipped, not disabled — never compiled. That's why tests can live in the same file as the code they check without costing the release binary anything. (`use super::*;` is the other piece: it pulls the parent module's functions into the tests' scope.)

---

**Question 3:** Dan runs `cargo test discount` in the lesson project (7 tests total, 2 with `discount` in their names). What runs, and how does the summary report the rest?
A. All 7 tests — the argument is just a label for the log
B. Only a test named exactly `discount`; the rest are reported as failures
C. Every test whose *name contains* `discount` — 2 tests — and the other 5 are reported as `filtered out`, not failed or skipped in shame
D. Nothing — `cargo test` takes no arguments

**Answer:** C
**Explanation:** The argument is a substring filter on test names. `cargo test discount` runs the two `senior_discount` checkers and reports `5 filtered out` — that's how you iterate on one bug without re-running the world.

---

**Question 4:** `compute_change` must panic when the payment is short — that's its contract. Dan writes `#[should_panic(expected = "kulang ang bayad")]` on the test. Why is the `expected = "..."` part important?
A. It's required syntax — `#[should_panic]` won't compile without it
B. A bare `#[should_panic]` is satisfied by *any* panic — including a brand-new bug panicking for the wrong reason two lines earlier. `expected` makes the test pass only if the panic message *contains* that substring, so only the right panic counts
C. It makes the test run faster by skipping the panic handler
D. It converts the panic into a `Result` so `?` works

**Answer:** B
**Explanation:** The test passes only if the code panics AND the message contains the `expected` substring. Without it, any accidental panic — even one from a different bug — would quietly pass as "correct."

---

# Quiz 2
## Scenario: Left: 79, Right: 80

Dan tests an ugly number from the real ledger — Lola Cion's P99 senior order — and the suite goes red:

```text
thread 'tests::test_senior_discount_99' panicked at src/main.rs:92:9:
assertion `left == right` failed: Lola Cion's P99 order: dapat P80
  left: 79
 right: 80
```

**Question 5:** Following the course convention (call first, expected value second), how should Dan read this failure?
A. `left` is the expected value and `right` is a compiler suggestion
B. Both numbers come from the test; the function never ran
C. `left: 79` is what the code actually returned, `right: 80` is what the ledger says it should have been — and a gap of exactly one peso on an integer-math function practically shouts *truncation*
D. The test is broken, because functions that compiled for weeks can't be wrong

**Answer:** C
**Explanation:** Left = what the code did, right = what it should have done. The thread name says which test, the custom message says what was at stake, and the gap's size and direction (off by exactly P1) points straight at where integer division threw away a remainder. "The test must be wrong" was Dan's first reaction too — the ledger disagreed.

---

**Question 6:** The bug: Dan had "simplified" `total - total * 20 / 100` into `total * 80 / 100`. For `total = 99` in `u32`, the first gives 80, the second gives 79 — yet `senior_discount(80)` returned 64 under BOTH formulas. Why did the friendly test vouch for the buggy code?
A. The compiler optimized the two formulas into the same machine code
B. In `u32`, integer division truncates, so *where* you divide decides *what* gets thrown away: `99*20/100 = 19` truncates the discount (price P80), `99*80/100 = 79` truncates the price. But 80 divides cleanly through every step, so truncation never gets to lie — friendly, divisible inputs hide exactly this class of bug
C. `assert_eq!` only checks the first digit of each number
D. Tests run in parallel, so the 80 test saw a different version of the function

**Answer:** B
**Explanation:** Algebra is algebra — but not in integer math, where truncation makes the two formulas differ on any total that isn't a multiple of 5. Easy numbers are where bugs go to hide: test boundaries, odd totals, real ledger entries.

---

**Question 7:** Dan fixes the formula and the suite goes green. Ate Rina insists `test_senior_discount_99` stays in the file forever — "bayanihan with future-Dan." What permanent value does a passing test have after the bug it caught is fixed?
A. None — a test that passes is dead weight and should be deleted to speed up CI
B. It documents who wrote the bug, for blame purposes
C. It guards the formula against the future: the day anyone "simplifies" that line again — next month, next maintainer, next 2 AM idea — `cargo test` screams before the wrong number ever reaches Tita Malou. Past-you carries the house so future-you can't silently drop it
D. It makes `cargo build --release` produce a faster binary

**Answer:** C
**Explanation:** Tests are written for future-you, not today-you. Every kept assertion is cheap, permanent insurance: the one-peso truncation bug can never ship again, because a checker that never sleeps now stands exactly where it once hid.

---
**Next:** Proceed to Lesson 23 exercises.
