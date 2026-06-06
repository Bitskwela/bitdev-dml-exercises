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
