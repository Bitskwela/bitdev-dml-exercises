# Ship LutoCLI v1.0

This is it — ship day. You are building the whole tool: argument parsing, CSV parsing, four reports, tests, and a release binary.

One note on layout. In the real shipped project this is `cargo new lutocli` with **three files** — `src/main.rs` (the counter), `src/record.rs` (the prep station), `src/report.rs` (the kitchen). The activity file flattens those three stations into **one file** using inline `mod record { ... }` and `mod report { ... }` blocks: same names, same `pub` boundaries, single file. And one note on data: if `carinderia-sales.csv` (the real 90-row May notebook, from the course `datasets/` folder) sits next to `Cargo.toml`, LutoCLI reads it; if not, an embedded `SAMPLE_CSV` — 14 real rows including both quincenas and the rainy week — steps in with a polite notice. The tool never ships broken.

Open `act_1.rs` and work through the TODOs in order.

## Task 1: `parse_line` — the Prep Station

Implement `parse_line(line: &str) -> Result<SaleRecord, String>`: split the line on commas, reject any row that doesn't have exactly 7 fields with a friendly sentence that quotes the whole row, parse `quantity` and `revenue` with `.trim().parse()` plus `map_err` Tagalog sentences ("hindi mabasa ang quantity na '...' — dapat buong numero."), and build the `SaleRecord` (`is_payday` is `fields[5] == "True"`; trim the weather). Then remove the `#[ignore]` from `payday_row_parses` and fill in the body of `written_out_number_is_rejected_politely`. Run `cargo test` — both must pass.

## Task 2: The Kitchen — Four Reports

Implement the four functions in `mod report`, each over a borrowed `&[SaleRecord]`:

- `summary` — row count, total kita, average per row (guard the zero-row case), and the strongest day via a `HashMap<&str, u32>` tally + `.max_by_key`.
- `top_dishes` — servings per item with `entry().or_insert(0)`, collected into a `Vec`, sorted most-servings-first (tie: alphabetical), top 3 printed.
- `payday_compare` — quincena vs ordinary rows: totals, counts, averages, and the verdict line when payday wins.
- `weather_report` — revenue buckets per weather, sorted descending.

## Task 3: The Counter — Complete the Dispatch

`run` already matches on `args.get(1).map(|s| s.as_str())` — Option, a closure, string slices, and an exhaustive `match` in one line. The `summary` and `top` arms are done; add the `payday` and `weather` arms. The `Some(other)` and `None` arms (friendly unknown-command message + bilingual usage help) are the failure paths Tita Malou will actually hit — they're already wired, so keep them working.

## Task 4: Run It Like Tita Malou

```powershell
cargo run -- summary
cargo run -- top
cargo run -- payday
cargo run -- weather
cargo run -- summery        # unknown command -> usage help, walang crash
cargo run -- summary sales.cvs   # missing file -> one friendly sentence, exit code 1
```

Remember: everything after `--` goes to your program, not to cargo.

## Task 5: Ship It

```powershell
cargo build --release
```

The optimized binary lands at `target\release\lutocli.exe` (Windows) or `target/release/lutocli` (Linux/macOS), about 1.2 MB. Copy it (plus the CSV, if you have it) into one folder — that's the entire installation.

## Sample Output

Verified output from the **embedded SAMPLE_CSV fallback** (no `carinderia-sales.csv` next to `Cargo.toml`). `cargo run -- summary`:

```
(Walang 'carinderia-sales.csv' sa folder — ginagamit ang built-in sample data.)

=== LutoCLI: Buod ng Benta ===
Rows sa notebook:  14
Kabuuang kita:     P14045
Average kada row:  P1003
Pinakamalakas:     Saturday (P4640 sa buong buwan)
```

`cargo run -- payday`:

```
(Walang 'carinderia-sales.csv' sa folder — ginagamit ang built-in sample data.)

=== LutoCLI: Quincena vs Ordinaryong Araw ===
Payday rows:    4 | kita P 4665 | avg P1166/row
Ordinary rows: 10 | kita P 9380 | avg P 938/row
Quincena effect: TOTOO. Mas malakas ang benta tuwing sweldo.
```

The spike is visible even in 14 rows: P1166 average per payday row against P938 ordinary. With the **full 90-row dataset** beside `Cargo.toml`, the notice line disappears and you get the numbers from Dan's story (verified): `summary` shows 90 rows, P75165 total, P835 average, Saturday strongest at P14645; `payday` shows 6 payday rows at avg P1106/row vs 84 ordinary rows at avg P815/row. And `cargo run -- summary sales.cvs` with the real CSV present earns the sentence from the story: `Hindi mahanap ang file na 'sales.cvs'. Baka ang ibig mo sabihin ay 'carinderia-sales.csv'?`

## Reflection Questions

1. The dispatch line uses `args.get(1)`, not `args[1]`. What exactly did the compiler force you to write that `args[1]` would have let you skip — and who would have paid for that skip?
2. There is not a single `unwrap()` or `expect()` in the finished program; every failure rides `Result` up to one funnel in `main`. Why does that policy matter more for Tita Malou than it ever did for you during development?
3. When *you* name a file explicitly (`lutocli summary sales.cvs`), a missing file is an error — but when the *default* CSV is missing, LutoCLI quietly falls back to the embedded sample, with a printed notice. Why is that asymmetry (and the notice itself) honest error design?

## Challenge: LutoCLI v1.1

Tita Malou already has requests. Of course she does — that's what happens when software works.

**Challenge A — the `day` subcommand.** `lutocli day Friday` should filter by `day_of_week` and print that day's row count, total, and average. The subcommand's *own* argument lives at `args.get(2)` — note that this conflicts with the optional-filename slot, so for this arm read the day from `args.get(2)` instead:

```rust
Some("day") => match args.get(2) {
    Some(day) => report::day_report(&load_records(None)?, day),
    None => println!("Aling araw? Halimbawa: lutocli day Friday"),
},
```

Writing `day_report` is your job — an iterator, a `filter`, a sum. Check yourself against the full dataset: **Friday should give 15 rows, P12045 total, P803 average.** Notice what the compiler made you do: `args.get(2)` forced you to decide, at compile time, what happens when she types `lutocli day` and nothing else.

**Challenge B — the `export` subcommand, and one more proof.** Add `export`, which writes the full report (summary + top + payday + weather) to `luto-report.txt` so Tita Malou can hand a printout to the bookkeeper. Your report functions `println!` directly, so write sibling functions that *build* the text instead (`format!` and `push_str` are your friends), then `fs::write("luto-report.txt", text).map_err(|_| String::from("Hindi maisulat ang luto-report.txt. Puno ba ang disk?"))?` — friendly sentence on the error path, house rules. Then add **one new test** proving `parse_line` rejects a row with only **6 fields** (drop the weather column from a good row, assert `is_err()`). A truncated row near money should never parse quietly. Prove it never will.

## What You've Learned

- The whole course converges in one binary: structs (13), `Result` + `?` + `map_err` (16), collections (17), modules (18), tests (23), file I/O (24), and `env::args` (25) — each subcommand is an old lesson earning its keep
- One error funnel in `main`, zero `unwrap()`/`expect()`: every failure path is a sentence a tindera can read, and the error messages are part of the user interface
- A parser that guards money gets tests — including a test that *proves* bad input is rejected, not just hoped away
- `cargo build --release` turns twenty-five lessons into one self-contained 1.2 MB file: copy, run, ship
