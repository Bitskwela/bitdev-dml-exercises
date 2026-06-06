# Lesson 24 Quiz: File I/O

---
# Quiz 1
## Scenario: The Notebook Comes Home

Sunday morning. Dan exports May 2026 from his old pandas notebook into `carinderia-sales.csv` — 90 rows, the same data that powered Luto v1 and v2 — and teaches LutoCLI to read it.

**Question 1:** What does `fs::read_to_string("carinderia-sales.csv")` actually return?
A. A bare `String` — reading a file always works
B. `Result<String, io::Error>` — the whole file as a `String`, or the reason it couldn't be read; files are the textbook recoverable failure (missing, locked, on a yanked USB stick), so the failure case lives in the type
C. `Option<String>` — `None` if the file is empty
D. An iterator of lines, one at a time

**Answer:** B
**Explanation:** One call: path in, the entire file out as a `String` — but only after you've acknowledged, in the type system, that you might get an `io::Error` instead. Hope is not a strategy; `Result` is.

---

**Question 2:** Why does Dan write `fn main() -> Result<(), Box<dyn std::error::Error>>` instead of a plain `fn main()`?
A. It makes the program run faster
B. Rust requires it whenever you `use std::fs`
C. `?` early-returns the `Err` to the caller, so its enclosing function must return a `Result` — this signature makes `?` legal in `main`, and `Box<dyn Error>` is "any kind of error, boxed": one container for an `io::Error` from the file AND a `ParseIntError` from the numbers
D. `Box<dyn Error>` is needed to allocate the file on the heap

**Answer:** C
**Explanation:** Two different error types flow through this `main`. `Box<dyn Error>` accepts whatever `?` throws at it; if `main` returns an `Err`, the program prints the error and exits with a failure code.

---

**Question 3:** Dan drops the CSV into `src/`, next to `main.rs` — where the code lives, diba? — and `cargo run` dies with `Os { code: 2, kind: NotFound }` even though he can SEE the file in the explorer. What happened?
A. The file is corrupted and Rust refuses to open it
B. Relative paths resolve from the current working directory — with `cargo run` that's the project root, the folder with `Cargo.toml` — not from `src/` and not from `target/debug/` where the `.exe` sits; the file belongs next to `Cargo.toml`
C. `fs::read_to_string` only accepts absolute paths
D. CSV files must be declared in `Cargo.toml` first

**Answer:** B
**Explanation:** The error isn't lying — it's looking where *it* stands, not where *you're* looking. `NotFound` on a file you can see almost always means "right file, wrong folder."

---

**Question 4:** The lesson parses rows with `line.split(',').collect::<Vec<&str>>()` — and openly calls this an honest shortcut. When does this approach break, and what's the honest fix?
A. It breaks on fields containing spaces like `Sinigang na Baboy`; fix: replace spaces with underscores
B. It never breaks; the `csv` crate is purely for speed
C. It breaks on files larger than memory; fix: buy more RAM
D. It breaks on real-world CSVs with quoted fields containing commas (`"Adobo, extra spicy"`), escaped quotes, and similar horrors; fix: reach for the `csv` crate the day you face a CSV you didn't design

**Answer:** D
**Explanation:** Naive `split(',')` works here because our dataset is comma-free *by design* — spaces are just characters, commas are the only separator that matters. Quoted commas would be shredded; that's exactly the parsing work the `csv` crate does for you.

---

# Quiz 2
## Scenario: Parsing the Payday Column

Halfway through the file, Dan's obvious-looking `fields[5].parse::<bool>()?` kills the program with `ParseBoolError`. He opens the CSV: the column says `True` and `False`, capital first letters.

**Question 5:** Why did the parse fail, and what's the right fix?
A. Rust's `parse::<bool>()` accepts only lowercase `"true"`/`"false"` — and this file says `True` because Python wrote it and Python capitalizes its booleans; the fix is to stop parsing and compare the raw text: `let is_payday = fields[5] == "True";`
B. `bool` can't be parsed from text at all in Rust; booleans must be stored as 0 and 1
C. The `?` operator doesn't work on `ParseBoolError`; switching to `.unwrap()` fixes it
D. The CSV is corrupted; Dan should re-export it until it says `true`

**Answer:** A
**Explanation:** Real data doesn't follow your language's conventions — it follows the conventions of whatever produced it: Python, Excel, a government portal, Tita Malou's pen. One `==` comparison sidesteps the whole problem. Your code adapts to the data, never the other way around.

---

**Question 6:** For the `revenue` column Dan writes `fields[3].parse::<u32>()?` (strict), but a tolerant `parse::<u32>().unwrap_or(0)` would never crash. Why is strict the right choice for money?
A. `unwrap_or(0)` is slower than `?` at runtime
B. With `unwrap_or(0)`, a corrupted revenue cell silently becomes ₱0 inside the total — the report comes out wrong, Tita Malou decides on a fake number, and nobody ever finds out; with `?` the program stops and points at the problem: a loud crash you can fix beats a quiet lie you can't see
C. Strict parsing rounds the centavos correctly
D. Tolerant parsing is forbidden everywhere in Rust

**Answer:** B
**Explanation:** Strict or tolerant is a decision, not a reflex. Tolerant is honest when a default genuinely makes sense (a missing dataset falling back to the embedded sample); for money, the value being wrong is worse than the program stopping — always strict.

---

**Question 7:** Dan ends the night with `fs::write("daily-report.txt", report)?`. Which statement about `fs::write` is true?
A. It appends to the file if it already exists, so old reports are preserved
B. It returns the number of bytes written as a plain `usize`
C. It creates the file if missing and **completely overwrites** it if it exists — no appending, no merging — and returns `Result<(), io::Error>` because disks can fail too; that's why you build the entire report as one `String` first and write once
D. It can only write to files inside `src/`

**Answer:** C
**Explanation:** `fs::write` is `read_to_string` reversed: contents in, file on disk out, whole thing in one call. Build the complete `String` with `format!` and `push_str`, write once, handle the `Result` — and the report lands next to `Cargo.toml`, readable by Notepad with zero Dans present.

---
**Next:** Proceed to Lesson 24 exercises.
