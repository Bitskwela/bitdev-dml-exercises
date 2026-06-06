# Lesson 25 Quiz: Mini Project — LutoCLI

---
# Quiz 1
## Scenario: Ship Day

Dan builds `lutocli.exe` with `cargo build --release`, copies it and the CSV onto the carinderia desktop, and tapes a handwritten cheat sheet to the monitor. Tita Malou types the commands herself.

**Question 1:** LutoCLI starts with `let args: Vec<String> = env::args().collect();`. Tita Malou types `lutocli summary`. What is in the vector — and during development, why does Dan type `cargo run -- summary`?
A. `args[0]` is `"summary"`; the `--` is just decoration cargo ignores
B. `args[0]` is the program itself (its path) and `args[1]` is `"summary"`; everything after the `--` goes to Dan's program instead of to cargo
C. `env::args()` only captures words that start with a dash, so the vector is empty
D. The vector holds one merged string, `"lutocli summary"`, that must be split manually

**Answer:** B
**Explanation:** `env::args()` iterates over every word the user typed, with the program's own path first — so the user's subcommand is `args[1]`. The `--` is the boundary: arguments before it belong to cargo, arguments after it belong to your program. The shipped binary drops the ceremony entirely.

---

**Question 2:** The dispatch is `match args.get(1).map(|s| s.as_str()) { ... }`. Why `.get(1)` instead of indexing with `args[1]`?
A. `.get(1)` is faster than indexing
B. `args[1]` returns a `String`, which can never be matched against literals
C. `args[1]` would *panic* if Tita Malou presses Enter with no subcommand; `.get(1)` returns `Option<&String>`, so the empty keyboard becomes a `None` arm the exhaustive `match` forces Dan to handle
D. `.get(1)` automatically skips the program name; `args[1]` does not

**Answer:** C
**Explanation:** This one line is four lessons composed: `Option` instead of a panic (Lesson 14), a closure transform with `.map` (Lesson 16's `map_err` move), `&str` slices to match against literals (Lessons 11-12), and `match` exhaustiveness (Lesson 15). The compiler will not let LutoCLI forget the empty keyboard.

---

**Question 3:** Where does `cargo build --release` put the binary, and what makes it shippable to the carinderia's offline desktop?
A. In `src/`, next to `main.rs` — but the desktop needs Rust installed to run it
B. At `target\release\lutocli.exe` on Windows (`target/release/lutocli` on Linux/macOS) — one optimized, self-contained file: copy it into a folder and run it, nothing to install, though it only runs on the OS family it was built for
C. In the system PATH automatically, so it runs from anywhere immediately
D. At `target\debug\lutocli.exe` — release and debug builds land in the same place

**Answer:** B
**Explanation:** `--release` builds the optimized binary into `target\release\`. It is fully self-contained — USB, copy, run — which is the Lesson 1 promise kept. The one caveat: a binary runs on the OS family it was built for; crossing OSes is cross-compilation, beyond this course.

---

**Question 4:** Which pairing of subcommand to "lessons doing the work" is correct?
A. `top` — a `HashMap` tally with `entry().or_insert(0)` over borrowed `&str` keys (Lessons 17 and 11), collected into a `Vec` and sorted
B. `payday` — `fs::write` and cross-compilation (Lessons 24 and 25)
C. `summary` — trait objects and lifetimes (not covered in this course)
D. `weather` — `unsafe` blocks for fast bucket math (Lesson 9)

**Answer:** A
**Explanation:** The capstone is convergence, not new machinery: `top` is Lesson 17's lunch-rush tally earning its keep over Lesson 11's borrowed string slices. `summary` adds Lesson 14's `if let`; `payday` is booleans, branches, and struct fields (5, 7, 13); `weather` is HashMap buckets over borrowed views (17, 10).

---
# Quiz 2
## Scenario: Zero Unwraps at the Counter

Tita Malou, feeling ambitious, types `lutocli summary sales.cvs` — a typo'd filename. She gets back exactly one sentence: `Hindi mahanap ang file na 'sales.cvs'. Baka ang ibig mo sabihin ay 'carinderia-sales.csv'?` No traceback, no red wall.

**Question 5:** Trace the failure path. What design makes this one polite sentence possible — and why is it the right design for a tool whose user is not a programmer?
A. A `try/catch` around `main` that swallows all errors silently
B. `fs::read_to_string` panics, but release mode prints panics in Tagalog
C. The CLI scans for similar filenames before doing anything, so errors never occur
D. `fs::read_to_string` returns an `Err`, `map_err` rewrites it into a human sentence, `?` forwards it up, and `main`'s single `if let Err(message)` funnel prints it and exits with code 1 — zero `unwrap()`/`expect()` means no path exists where Tita Malou sees a panic instead of a sentence

**Answer:** D
**Explanation:** Every failure rides the `Result` rail from the disk to one funnel in `main`. Because the end user cannot read a traceback, the error message *is* the user interface — "Baka ang ibig mo sabihin ay...?" did more for her trust than any feature. An `unwrap()` anywhere on that rail would be a bet that input is clean, and Dan has watched that bet lose on a Sunday.

---

**Question 6:** A page of the notebook got smudged and one digitized row lost its weather column — 6 fields instead of 7, right next to the revenue numbers. `parse_line` checks `fields.len() != 7` *first* and returns `Err("may 6 field ang row pero 7 ang inaasahan. Buong row: '...'")`. Why is this the right design, rather than parsing whatever fields are present?
A. Checking the length first is the only way to avoid a borrow-checker error
B. A truncated row near money should never parse quietly: field positions can shift, so "parse what's there" risks silently recording wrong amounts, and indexing a missing column would panic — instead the row is rejected with a sentence that quotes it, so the encoder knows exactly what to fix. A test (`is_err()` on a 6-field row) proves it stays that way
C. Rust cannot index a `Vec` that has fewer than 7 elements
D. It is faster to fail early, and speed is the main concern here

**Answer:** B
**Explanation:** This is Lesson 16's policy applied to the money path: bad input is not a bug, so it gets a `Result` carrying the *reason*, quoting the full row. And because it is a family's money, the guarantee is pinned by a `#[cfg(test)]` proof — the challenge adds exactly that 6-field rejection test.

---

**Question 7:** Before calling LutoCLI "done," Dan checks: `cargo test` passes, all four subcommands' numbers match Tita Malou's notebook margin, every failure path (no argument, unknown command, missing file, broken row) prints a sentence a tindera can read, and the `--release` binary runs on the carinderia desktop with nothing installed. What mindset is this — and why are the *failure* paths on the ship list at all?
A. Premature optimization — failure paths are an edge case to handle after launch
B. Defensive paranoia — the compiler already guarantees the program cannot misbehave, so the checklist is redundant
C. Acceptance criteria — "works" is defined from the user's seat, not the developer's: for an end-user tool, what happens on bad input is part of the product, so the error paths must be designed, written in the user's language, and verified just like the features
D. Test-driven development — every checklist item must literally be a `#[test]`

**Answer:** C
**Explanation:** The compiler proves memory safety and exhaustiveness; it cannot prove the totals match the notebook or that an error message is kind. Dan ships only when the program is correct *and* polite under failure — because Tita Malou will hit the failure paths first ('sales.cvs'), and how the tool answers her is what earns the "Anak, it scolded me nicely."

---
**Next:** Proceed to Lesson 25 exercises. (End of course — congratulations.)
