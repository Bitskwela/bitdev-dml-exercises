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

### Rows and Columns: `.lines().skip(1)` + `split(',')`

```rust
for line in contents.lines().skip(1) {
    let fields: Vec<&str> = line.split(',').collect();
    // date,item,quantity,revenue,day_of_week,is_payday,weather
    //  [0]  [1]    [2]      [3]      [4]        [5]      [6]
}
```

`.lines()` is an iterator of `&str` slices into the original `String` — no copying, your Lesson 11 slices doing real work. `.skip(1)` jumps the header row, which is labels, not data — total without it and the word `"revenue"` hits your `parse::<u32>()` like a brick. `split(',')` yields the pieces between commas; `collect::<Vec<&str>>()` gathers them so you can index by column. `"Sinigang na Baboy"` is fine — spaces are just characters; commas are the only separator that matters.

**Honest note:** this works because our dataset is comma-free *by design*. Real-world CSVs allow quoted fields with commas inside (`"Adobo, extra spicy"`), escaped quotes, and other horrors — naive `split(',')` shreds those. The day you face a CSV you didn't design, reach for the `csv` crate. Today, std is enough — and you'll understand exactly what that crate does for you.

### Parsing Fields: Strict or Tolerant — Choose On Purpose

Every field arrives as `&str`. Turning text into numbers is a decision, not a reflex:

| Style | Code | On bad data | Use when |
|---|---|---|---|
| **Strict** | `fields[3].parse::<u32>()?` | Program stops with an error | The value being wrong is worse than stopping |
| **Tolerant** | `fields[2].parse::<u32>().unwrap_or(0)` | Quietly becomes `0`, row still counts | A default is genuinely acceptable |

For `revenue`, Dan chooses **strict** — here's the why, in pesos: with `unwrap_or(0)`, a corrupted revenue cell silently becomes ₱0, the total comes out wrong, and Tita Malou makes a real decision on a fake number. Nobody ever finds out. With `?`, the program stops and points at the problem. A loud crash you can fix beats a quiet lie you can't see — for money, *always* strict.

### The `True`/`False` Gotcha

```rust
let b = "True".parse::<bool>();      // Err(ParseBoolError) — Rust wants lowercase
let is_payday = fields[5] == "True"; // plain comparison: always works
```

Our CSV says `True`/`False` because Python wrote it, and Python capitalizes its booleans. The fix is to stop parsing and start comparing. Burn the general lesson in: **real data doesn't follow your language's conventions.** Data follows the conventions of whatever produced it — Python, Excel, a government portal, Tita Malou's pen. Your code adapts to the data, never the other way around.

### `fs::write` — the Whole File in One Call, Reversed

```rust
fs::write("daily-report.txt", report)?; // Result<(), io::Error>
```

The mirror image of `read_to_string`: contents in, file on disk out. It creates the file if missing and **overwrites it completely** if it exists — no appending, no merging. The pattern that follows: build the entire report as one `String` first (with `format!` and `push_str`), then write once. Disks can fail too, hence the `?`.

### The Working-Directory Gotcha

A relative path is resolved from the **current working directory** — the folder your terminal is standing in when the program starts. With `cargo run`, that's the project root: the folder with `Cargo.toml` in it. Not `src/`, and not `target/debug/` where the `.exe` actually lives. Data files for `cargo run` belong **next to `Cargo.toml`**. Get this wrong and you'll meet Dan's `Os { code: 2, kind: NotFound }` — it's not lying, it's just looking where *it* stands, not where *you're* looking.
