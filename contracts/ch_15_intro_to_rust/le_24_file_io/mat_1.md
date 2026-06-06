## Dan's Story: The Notebook Comes Home

Sunday morning, six forty-five — the carinderia an hour before the church crowd. Steam off the first rice cooker, Tita Malou slicing kangkong for the sinigang, and on the counter, between the vinegar and the tip jar: *the* notebook. Spiral-bound, grease-spotted, fifteen years of sales in her handwriting. Dan set his laptop next to it like he was introducing two old friends. Because he was. Back in the AI course he typed this notebook in cell by cell, and Luto v1 gave the data meaning — *why* sinigang sells, in plain sentences. In the ML course the same data trained Luto v2 to predict tomorrow's best-seller. Last night Dan exported May from the old pandas notebook into one file: `carinderia-sales.csv`. Ninety rows. Same data, third life — and this course's job is the last one: make it run *anywhere*.

> **Tita Malou:** Basahin? Eh kung mabasa niya, sabihin niya sa akin magkano kinita ko nung Mayo. Yan ang test.

Challenge accepted. Dan dropped the CSV into `src/`, next to `main.rs` — where the code lives, diba? — wrote ten lines, and ran it:

```text
Error: Os { code: 2, kind: NotFound, message: "The system cannot find the file specified." }
```

The file was *right there* in the explorer. Then it clicked: `cargo run` resolves relative paths from the **project root** — the folder with `Cargo.toml` — not from `src/`, and not from wherever the `.exe` sits. He moved the CSV up one level, next to `Cargo.toml`. Green. Second attempt, parsing the payday column the obvious way — `fields[5].parse::<bool>()?` — died mid-file with `ParseBoolError`. Dan opened the CSV. There it was: `True`. Capital T. *He* had exported this file from pandas, and Python capitalizes its booleans. His own Python past, sabotaging his Rust present. He swapped the parse for a plain comparison — `fields[5] == "True"` — and ran it one more time:

```text
Total revenue:   P75165
```

> **Tita Malou:** Pitumpu't limang libo, one hundred sixty-five. *(she didn't even look up from the kangkong)* Tama. Alam ko ang buwan ko, anak. Sige nga — kung marunong na siyang bumasa, marunong din ba siyang magsulat?

So Dan wrote his first file: four lines of `format!`, one call to `fs::write`, and a `daily-report.txt` appeared next to `Cargo.toml` — a file Tita Malou could double-click on the ancient desktop and read in Notepad, no Dan required. He looked at the three of them on the counter: the notebook, the laptop, the report. *Luto v1 gave this data a voice. Luto v2 gave it foresight. This one makes it run anywhere.* Same notebook, full circle.

---

## The Concept: Reading and Writing Files with `std::fs`

### `fs::read_to_string` Returns `Result` — Lesson 16 Pays Off

```rust
use std::fs;

let contents = fs::read_to_string("carinderia-sales.csv")?;
```

One function: path in, the **entire file** out as a `String`. Its return type is `Result<String, io::Error>` — files are the textbook case of *recoverable* failure. The file might not exist, might be locked by another program, might be on a USB stick somebody yanked out. Rust refuses to hand you the `String` until you've acknowledged, in the type system, that you might get an `io::Error` instead. Hope is not a strategy; `Result` is. (For files too big to slurp into memory there are streaming readers, but a 90-row CSV — even a 90,000-row one — fits in a `String` just fine.)

### `main` Can Return a `Result`

The `?` operator early-returns the `Err` to the caller — so the function it lives in must itself return a `Result`. `main` is allowed to be that function:

```rust
fn main() -> Result<(), Box<dyn std::error::Error>> {
    let contents = fs::read_to_string("carinderia-sales.csv")?; // ? now legal in main
    // ...
    Ok(()) // the success value: () — "nothing to report"
}
```

`Box<dyn std::error::Error>` means "any kind of error, boxed up" — one container that accepts an `io::Error` from the file *and* a `ParseIntError` from the numbers, even though those are different types. The full trait-object story behind `dyn` is beyond this course; for now, read it as "main accepts whatever error `?` throws at it." If `main` returns an `Err`, the program prints the error and exits with a failure code — that's exactly Dan's `Error: Os { code: 2, ... }` line.
