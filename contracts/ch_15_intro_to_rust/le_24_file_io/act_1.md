# Read the Notebook, Write the Report

Feed LutoCLI its first real meal: the digitized carinderia notebook. You'll read a CSV with `fs::read_to_string`, total the month, and write your first-ever output file. Open `act_1.rs` and work through the TODOs in order.

## The Two Data Paths

The starter reads its data with one tolerant, labeled pattern — the one-liner version is:

```rust
let contents = fs::read_to_string("carinderia-sales.csv")
    .unwrap_or_else(|_| SAMPLE_CSV.to_string());
```

(The starter uses the `match` form of the same thing, so it can also stamp *which* data it ate into a `source` string.)

**Path A — the real dataset.** Copy the course file `carinderia-sales.csv` **next to `Cargo.toml`** — NOT inside `src/`; that's the working-directory gotcha, handled before it happens. You get the full month: 90 rows of May 2026.

**Path B — the embedded fallback.** No file? The code falls back to `SAMPLE_CSV`, a constant holding 14 representative rows from the same dataset (including 2 payday rows and 3 rainy rows). The exercise runs anywhere, dataset or not — same columns, same logic, smaller numbers. Every TODO you write is identical on both paths.

## Task 1: Read or Fall Back (given — read it)

The fallback `match` is already wired. Understand the choice before moving on: a missing *dataset file* has a sensible default (the embedded sample), so tolerant handling is honest here. A garbage *revenue cell* has no sensible default — that one stays strict below. Same Lesson 16 toolbox, two deliberate choices.

## Task 2: Skip the Header (TODO 1)

Add `.skip(1)` to the `.lines()` loop. The header row is labels, not data — leave it in and the word `"revenue"` hits your strict parse like a brick (try it once, on purpose, after Task 3, and read the error).

## Task 3: Parse the Row (TODO 2 and TODO 3)

The split is given: `line.split(',').collect::<Vec<&str>>()`. Now parse `fields[3]` (revenue) **strictly** with `.parse::<u32>()?` — money stops loudly on garbage, never becomes a silent 0. Then the payday column: `"True".parse::<bool>()` FAILS in Rust (lowercase only — Python wrote this file), so *compare* instead: `let is_payday = fields[5] == "True";`.

## Task 4: Rows, Total, Average (TODO 4)

Count every data row in `row_count`, accumulate `total_revenue`, and count `payday_rows`. The average line — whole-peso `u32` division, guarded against an empty file — is already in place below the loop, and the summary `println!`s are waiting.

## Task 5: Write the Report (TODO 5)

Build the WHOLE report as one `String` with `format!` — source stamp, rows, total, average, payday rows — then write it in one call: `fs::write("daily-report.txt", report)?;` and print `Report written!`. The file lands next to `Cargo.toml`, readable in Notepad with zero Dans present.

## Sample Output

Real output of the finished solution on **Path B** — no CSV present, embedded `SAMPLE_CSV` in use:

```text
=== LutoCLI: Notebook Import ===
Source:          embedded SAMPLE_CSV (14 rows, May 2026)
Rows read:       14
Total revenue:   P12870
Average per row: P919
Payday rows:     2

Report written!
```

...and `daily-report.txt` appears next to `Cargo.toml`:

```text
TITA MALOU'S CARINDERIA - MONTHLY REPORT
Source: embedded SAMPLE_CSV (14 rows, May 2026)
----------------------------------------
Rows read:       14
Total revenue:   P12870
Average per row: P919
Payday rows:     2
```

On **Path A** — the full 90-row dataset next to `Cargo.toml` — the same code prints the real month: **90 rows, P75165 total, P835 average per row, 6 payday rows**. P75165 is the exact number Tita Malou recited from memory while slicing kangkong.

## Reflection Questions

1. The starter uses *tolerant* handling (the fallback) for the missing file but demands *strict* handling (`?`) for the revenue cell. Both failures are "bad input" — what makes a sensible default honest in one case and a silent lie in the other?
2. Move the CSV into `src/` and run again. The program doesn't crash — it quietly switches to 14 rows. Why does the fallback *mask* the working-directory gotcha that crashed Dan's first attempt, and which output line is now your only clue that it happened?
3. `fs::write` overwrites the file completely on every run. Why does the build-the-whole-`String`-first, write-once pattern fit that behavior better than writing the report line by line?

## Challenge: The Sinigang Theory and the Top Three

**Part A — the Sinigang Theory.** Fifteen years, Tita Malou has sworn by one rule: *"Pag umuulan, kumakain ang tao."* Check her against the data. For each row, `match` on `fields[6]` (weather) and accumulate total revenue and row count separately for `rainy` and `sunny` rows (let `cloudy` fall through to `_`). Print totals AND per-row averages for both.

- On the embedded sample: rainy = 3 rows, P3065 total, P1021/row; sunny = 9 rows, P7910 total, P878/row.
- On the real file: rainy = 18 rows, P15495 total, P860/row; sunny = 57 rows, P47355 total, P830/row.

Sunny "wins" the raw total only because May had three times as many sunny rows — per row, rainy earns MORE. Same per-row-versus-total trap from your ML course, now in Rust: normalize first, conclude second. Tita Malou's theory holds.

**Part B — the Top Three board.** Tally `quantity` (column 2) per `item` (column 1) into a `HashMap<String, u32>` with the entry API — `*tally.entry(fields[1].to_string()).or_insert(0) += quantity;` (the map outlives the loop, so it must *own* its keys: Lesson 9 was never optional). A `HashMap` has no order, so drain it into a `Vec`, `sort_by(|a, b| b.1.cmp(&a.1))` for descending, `.iter().take(3)`, and `format!` the podium into the report before the `fs::write`.

- On the embedded sample: Sinigang na Baboy 53, Halo-Halo 40, Adobo 29.
- On the real file: Halo-Halo 254, Sinigang na Baboy 209, Adobo 170.

Notice the flip: in the 14-row sample, sinigang's rainy spikes top the board; across all 90 rows, Halo-Halo's sell-every-single-day volume wins. Two different "best-sellers," depende sa sample at sa metric. Choose both to fit the question — not the answer you were hoping for.

## What You've Learned

- `fs::read_to_string` returns `Result<String, io::Error>` — and a labeled tolerant fallback (`unwrap_or_else` or a `match`) makes the same program run with or without the dataset
- `.lines().skip(1)` + `split(',')` turn a comma-free CSV into indexed fields — and the `csv` crate exists for the day the fields aren't comma-free
- Strict `parse::<u32>()?` for money; a plain comparison (`== "True"`) for Python-flavored booleans that `parse::<bool>()` rejects
- `fs::write` creates-or-overwrites in one call: build the whole `String`, write once, handle the `Result`
- With `cargo run`, relative paths resolve from the folder with `Cargo.toml` — data files live there, and so does the report you just wrote
