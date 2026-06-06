# Three Loops and a Drag Race

One program, four acts: a `for` tally, a `while` countdown, a `loop` that breaks with a value, and the 10-million-iteration drag race timed with `std::time::Instant` — the standard library's stopwatch. Open `act_1.rs` and work through the TODOs in order.

## Task 1: `for` — Tally the Day's Sales

Part 1 already sums the eight sale amounts with `for amount in sales`. Finish the loop body so it also counts HOW MANY transactions there were. No index, no off-by-one — the iterator hands you each item. Expected: 8 transactions, ₱1390.

## Task 2: `while` — Countdown to Closing

It's 16:00 and the carinderia closes at 20:00. Write a `while hour < closing_hour` loop that prints one line per hour with the hours left ("Keep cooking!"), incrementing `hour` each pass. The condition must be a real `bool` — same rule as Lesson 7.

## Task 3: `loop` — Break With a Value

Which day first hit the ₱5,000 cash target? Replace the `hit_day` placeholder with a `loop` that walks `daily_totals` and does `break day;` at the first day at or above `target` — `let hit_day = loop { ... };` catches the broken-out value. No `found` flag, no post-loop cleanup. Expected: Thu, ₱5600.

## Task 4: The Drag Race

The `Instant` stopwatch wiring is given — just write the `for` loop that sums the INCLUSIVE range `1..=10_000_000u64` into `sum` (careful: `1..10_000_000` stops one short). Then race both gears: `cargo run` (debug — training mode), then `cargo run --release` (the real car).

## Sample Output

```
$ cargo run
=== PART 1: for — tally the day's sales ===
Transactions: 8
Total kita:   ₱1390

=== PART 2: while — countdown to closing ===
16:00 — 4 hour(s) left. Keep cooking!
17:00 — 3 hour(s) left. Keep cooking!
18:00 — 2 hour(s) left. Keep cooking!
19:00 — 1 hour(s) left. Keep cooking!
20:00 — sarado na. Good work today.

=== PART 3: loop — first day to hit the target ===
First day to hit ₱5000: Thu (₱5600)

=== FINALE: the drag race ===
Sum of 1..=10,000,000 = 50000005000000
Time: 70.451ms

$ cargo run --release        (everything identical except the finale)
=== FINALE: the drag race ===
Sum of 1..=10,000,000 = 50000005000000
Time: 8.242ms
```

Same code, same machine — about 8x faster from flipping one flag. Your numbers will differ (different machine, different night), but the *shape* won't: release wins big, every time.

## Reflection Questions

1. Why can only `loop` break with a value? What do `while` and `for` lack that makes `break value` impossible for them?
2. The benchmark accumulator is `u64` even though the money rule says `u32`. Why? (Hint: the true sum is 50,000,005,000,000.)
3. Debug Rust still beat Python (~81ms vs ~512ms on Dan's laptop). Why would publishing that as "the" Rust-vs-Python benchmark be misleading?

## Challenge: The Target Hunt, Honest Edition

Part 3's loop has a hidden landmine: if *no* day hits the target, `day` walks past the end of the array and the program panics. Fix it: use `loop` + `break`-with-value to find the first day whose revenue *exceeds* ₱5,000 — and if no day qualifies, report `"walang ganon"` instead of crashing. Don't reach for `-1` as "not found": array indexes are `usize`, which can't even *be* negative. Break with `daily_totals.len()` as the "walked off the end" sentinel instead, then check for it after the loop:

```rust
let found = loop {
    if i == daily_totals.len() {
        break daily_totals.len(); // searched everything: walang ganon
    }
    if daily_totals[i] > target {
        break i;
    }
    i += 1;
};
```

Test it twice: once with the real totals (should report Thursday), once with `target = 7_000` (should report walang ganon). Rust has a beautiful type for exactly this — but `Option<T>` doesn't arrive until Lesson 14. Tonight, the sentinel works.

## What You've Learned

- Rust's three loops and when each fits: `for` for collections and ranges, `while` for conditions, `loop` + `break value` for search-and-return
- `loop` is an expression — `break value;` hands the result straight out of the loop, no flag variables, no post-loop cleanup
- How to time code with `std::time::Instant`, and why a benchmark is only honest under `cargo run --release`
