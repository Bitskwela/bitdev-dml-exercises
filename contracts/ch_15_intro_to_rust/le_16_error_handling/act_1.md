# Bury the Sunday Crash

Re-run the crash that started this course — same kind of messy notebook data, this time the price column — and watch it bounce off. Open `act_1.rs` and work through the TODOs in order.

## Task 1: `parse_price` — Forward, Don't Decide

Implement `parse_price(s: &str) -> Result<u32, std::num::ParseIntError>`: trim the string, parse it with `.parse::<u32>()`, and put `?` after the call so any `Err` returns to the caller unopened. Wrap the number in `Ok(...)`. This function never panics and never decides — `main` is the layer that knows it's printing a report for a human.

## Task 2: Open Every Box — the `Ok` Arm

The loop already walks the digitized notebook, exactly as messy as real life: `["120", " 95 ", "abc", "", "210"]` — good rows, stray spaces, garbage text, and the same BLANK that killed `sales_report.py` on row 113. In the `Ok(price)` arm: add the price to `total`, count the row in `parsed_rows`, and print the `ok` line.

## Task 3: The Polite Warning — the `Err` Arm

In the `Err(_)` arm: count the row in `skipped_rows` and print `warn  Hindi ma-parse ang '{raw}' — nilaktawan`. A bad row is worth a warning, not a funeral — the report keeps going, the program never dies.

## Sample Output

```
=== Carinderia Sales: Sunday Replay ===
(prices in whole pesos, u32)

ok    '120' -> P120
ok    ' 95 ' -> P95
warn  Hindi ma-parse ang 'abc' — nilaktawan
warn  Hindi ma-parse ang '' — nilaktawan
ok    '210' -> P210

Parsed rows:  3
Skipped rows: 2
Total kita:   P425

Dalawang sirang row, zero crash.
Sorry, Sunday lunch — hindi na mauulit.
```

The blank string `''` — the exact one-cell ambush that produced `KeyError: ''` in front of Tita Malou — gets one polite warning line, gets counted, and the report keeps going.

## Reflection Questions

1. `parse_price` never decides anything — the `?` forwards every failure to `main` unopened. Why is `main` the right layer to decide that a bad row gets a warning instead of a crash?
2. Delete the `.trim()` and predict the new report: which row flips from `ok` to `warn`, and what do the three summary numbers become? Why would Ate Rina call cleaning input before judging it "respecting the encoder"?
3. The Sunday crash isn't merely fixed here — it's *structurally impossible*. What about the shape of `match` guarantees there is no path through the loop that forgets the `Err` case?

## Challenge: The Tip Split

Saturday's tip jar holds the day's tips, and they get split evenly among the staff. Write this function and make both arms work:

```rust
fn split_tips(total: u32, staff: u32) -> Result<u32, String> {
    // TODO: kung staff == 0, return
    //   Err("Walang staff? Sino maghahati ng tips?".to_string())
    // BEFORE the division ever happens. Otherwise, Ok(total / staff).
    Ok(total / staff) // <- as-is, staff == 0 panics: "attempt to divide by zero"
}

fn main() {
    // TODO: call split_tips twice — once with staff = 3, once with staff = 0 —
    // and handle BOTH arms with a match each time:
    //   Ok(share) -> "Tig-P{share} ang bawat staff"
    //   Err(msg)  -> print the message, walang crash
    match split_tips(450, 3) {
        Ok(share) => println!("Tig-P{share} ang bawat staff"),
        Err(msg) => println!("{msg}"),
    }
}
```

Notice what you're doing: division by zero is one of Rust's built-in *panics* — an unrecoverable crash — and your `if` check converts it into a *recoverable* `Result` with a human-readable reason. You are literally moving a failure from the unrecoverable column to the recoverable one. That migration is what error handling *is*. (Integer division, whole pesos — if the split isn't even, the remainder stays in the jar for tomorrow. House rules.)

## What You've Learned

- `.parse::<u32>()` returns `Result<u32, ParseIntError>` — the compiler refuses to let bad input wait until a Sunday lunch rush
- The `?` operator forwards an `Err` to the caller as an early return, so errors get handled where the *context* lives
- A full `match` on `Result` makes forgetting the failure case structurally impossible — two broken rows, zero crashes
- Converting a built-in panic (divide by zero) into a `Result` with a friendly message is the whole craft of error handling
