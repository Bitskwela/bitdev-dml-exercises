# Prove It Works

LutoCLI computes Tita Malou's money, and "I ran it once and it looked tama" is not a QA process. Open `act_1.rs` — the money functions are done. The checkers are not. Two tests are written for you as models; the rest are yours. Run everything with `cargo test` (not `cargo run` — `main()` only *claims*; the tests *prove*).

---

## Task 1: Write the Missing Checkers

Three empty test bodies wait inside `mod tests`. An empty test passes by default — finishing without a panic is all it takes — so the suite is green right now *and proving nothing*. Fix that. The two finished tests show the shape:

- **`test_compute_change_sukli`** — P500 paid on a P387 order must return P113. `assert_eq!` with the custom message `"sukli dapat {}", expected`.
- **`test_senior_discount_99`** — the ugly input that convicted the old formula. Ledger: P99 total, P19 discount, **P80** to pay. `assert_eq!` with the message `"Lola Cion's P99 order: dapat P{}", expected`. This test guards the truncation fix forever.
- **`test_parse_price_rejects_garbage`** — `assert!` that `parse_price("tatlong piso").is_err()` and that `parse_price("").is_err()`. Yes, the row-113 blank. It gets a permanent guard now.

## Task 2: Run the Suite — and Filter It

```
cargo test
```

All six pass. Run it twice and watch the test *order* shuffle — parallel threads, one per checker. Then re-run a subset: `cargo test senior` runs only the two tests whose *names contain* `senior` and reports the others as `filtered out`. That's how you iterate on one bug without re-running the world.

## Task 3: The Boundary Hunt

Tita Malou's new promo spec is one sentence: **"Tatlo o higit pa na merienda items, 10% off."** Three OR MORE. `merienda_combo_price` in your file is *Dan's draft* — shipped untested, with a bug of the same species as the senior-discount one: hiding at a boundary.

1. Write `test_combo_exactly_3_gets_discount`: 3 turon at P25 each = P75, minus 10% (P7) = **P68**. Message: `"spec says 3 OR MORE items get the discount"`.
2. Run `cargo test combo` and read the red:

```text
thread 'tests::test_combo_exactly_3_gets_discount' (121488) panicked at src\main.rs:117:9:
assertion `left == right` failed: spec says 3 OR MORE items get the discount
  left: 75
 right: 68

test result: FAILED. 0 passed; 1 failed; 0 ignored; 0 measured; 5 filtered out; finished in 0.00s
```

3. Do the ritual out loud: *left* is what the code did (charged full price), *right* is the spec. A P7 gap on a P75 order is exactly the missing 10% — the discount never fired on *exactly* 3 items. Find the comparison in `merienda_combo_price`, change `>` to `>=`, re-run, green.
4. In a comment above the test, answer: **why could a test with 2 items or 4 items never catch this bug?** Work it out — `count > 3` and `count >= 3` agree everywhere except one single value of `count`. Off-by-ones live exactly *at* the threshold, so that's exactly where a test must stand.

## Sample Output

`cargo test`, all tasks done (your test order may differ — parallel threads):

```text
running 6 tests
test tests::test_combo_exactly_3_gets_discount ... ok
test tests::test_compute_change_exact_payment ... ok
test tests::test_senior_discount_80 ... ok
test tests::test_parse_price_rejects_garbage ... ok
test tests::test_senior_discount_99 ... ok
test tests::test_compute_change_sukli ... ok

test result: ok. 6 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s
```

## Reflection Questions

1. `test_senior_discount_80` passed under both the correct formula and the buggy one. What property of the number 80 made it useless as a witness — and what does that tell you about choosing test inputs from the real ledger instead of inventing friendly ones?
2. `#[cfg(test)]` means the tests are *never compiled* into `cargo build --release`. Why does it matter that Tita Malou's USB-stick binary carries zero test code — and why is "never compiled" a stronger guarantee than "not run"?
3. The combo failure's left/right gap was P7; the senior-discount failure's was P1. How does the *size and direction* of the gap point you toward the bug before you even open the function?

## Challenge: The Panic and the Question Mark

Two more tests, against `split_tips_or_panic` and `parse_price` — both already in your file. Finish these skeletons inside `mod tests`:

```rust
#[test]
// TODO: add the attribute that makes this test PASS only if the code
// panics, AND require that the panic message mentions "zero staff".
fn test_split_tips_zero_staff_panics() {
    // TODO: call split_tips_or_panic with P450 in tips and 0 people
}

#[test]
fn test_parse_price_95() /* TODO: give this test a return type so `?` works */ {
    // TODO: parse_price("95"), use `?` (hint: map_err, like the lesson's
    // test_parse_price_trims_spaces), assert_eq! against 95,
    // and end with the value that means "pass".
}
```

Done right, `cargo test` reports **8 passed; 0 failed**, the panic test shows `- should panic ... ok`, and `cargo test tips` runs exactly one test. If your `should_panic` test fails saying the panic message didn't match, read the message it *did* find — that's the `expected = "..."` substring check refusing to let the wrong panic count as the right one.

## What You've Learned

- `#[test]` functions plus the `assert!` family turn "it looked tama" into a checker that never sleeps
- `cargo test` runs every checker in parallel; `cargo test <name>` filters by substring, reporting the rest as `filtered out`
- Failure output reads as `left` (what the code did) vs `right` (what it should have done) — the gap's size and direction point at the bug
- Boundary inputs (`count == 3`, `total == 99`) catch the off-by-ones that friendly inputs quietly vouch for
- `#[should_panic(expected = "...")]` tests a panic contract; a `Result`-returning test unlocks `?` — and an empty test proves nothing
