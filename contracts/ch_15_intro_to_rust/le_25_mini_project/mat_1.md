## Dan's Story: Ship Day

Saturday, six in the morning. Dan had been awake since five — not because something was broken, but because for the first time in his programming life, *nothing was*. `cargo test`: three passed. `cargo build --release`: done in under a second. One file, `lutocli.exe`, 1.2 megabytes, sitting in `target\release\` like a packed lunch. He copied it to the USB stick — the same one that carried his first hello-world in Lesson 3 — put the sales CSV next to it, and walked to the ancient desktop by the counter. Two files into one folder. That was the entire installation. Then the part he'd planned all week: an index card, handwritten in his neatest print, taped to the monitor's bezel.

```text
L U T O C L I  —  PINDUTIN LANG:
  lutocli summary   ->  kita ng buwan
  lutocli top       ->  top 3 ulam
  lutocli payday    ->  quincena vs ordinaryo
  lutocli weather   ->  kita kada panahon
```

Tita Malou wiped her hands on her apron and sat down in front of a terminal for the first time in her life. One finger, reading off the tape, letter by letter: `l-u-t-o-c-l-i`, space, `s-u-m-m-a-r-y`. Enter.

```text
=== LutoCLI: Buod ng Benta ===
Rows sa notebook:  90
Kabuuang kita:     P75165
Average kada row:  P835
Pinakamalakas:     Saturday (P14645 sa buong buwan)
```

It appeared before her finger left the key — the old Python script took forty seconds just to wake up, when it woke up at all. She checked the total against the arithmetic in her notebook margin. It matched. Then she got ambitious and typed a filename herself: `lutocli summary sales.cvs`. Dan held his breath — pure reflex from that Python Sunday. *Here comes the traceback. Here come the forty lines of red.*

```text
Hindi mahanap ang file na 'sales.cvs'. Baka ang ibig mo sabihin ay 'carinderia-sales.csv'?
```

No traceback. No red wall. One sentence, suggesting the fix — like a certain compiler Dan knew.

> **Tita Malou:** Anak... it scolded me nicely.
>
> **Dan:** That's the whole point, Ma.

Mid-afternoon, Jasper caught Tita Malou running `lutocli top` herself — no Dan hovering, no internet, on a desktop older than their friendship. Dan demoed the typo'd-filename trick, twice, because Jasper made him do it twice.

> **Jasper:** Bro. It fails *on purpose*? Politely? My thesis tool prints a stack trace if you breathe near it. ...Teach me Rust pala.

That night Dan sent the demo video — Tita Malou's first `summary`, filmed over her shoulder — to the group chat. And then, last, the message he didn't know he'd been waiting for:

> **Ate Rina:** Saw the demo video. The compiler trained you well, bata.

Lesson 4, the compiler was an enemy. Lesson 9, a wall. Lesson 15, a bodyguard. Lesson 22, a mentor. Tonight it felt like a coworker who had stayed late with him every single night, whose name isn't on the cheat sheet — because coworkers don't need credit. They need the thing to ship. It shipped.

---

## The Concept: `std::env::args` — and Everything Else on One Plate

### The Last New Tool: Reading Command-Line Arguments

Twenty-five lessons, and here is the final new item — small on purpose:

```rust
let args: Vec<String> = env::args().collect(); // after `use std::env;`
```

`env::args()` is an iterator over every word the user typed; `.collect()` gathers them into a `Vec<String>`. Two details: **`args[0]` is the program itself** (its path), so the subcommand Tita Malou types is `args[1]`. And during development you run `cargo run -- summary` — everything **after the `--`** goes to *your program*, not to cargo. The shipped binary drops the ceremony: just `lutocli summary`.

### The Dispatch Line — Four Lessons in One Line of Code

```rust
match args.get(1).map(|s| s.as_str()) {
    Some("summary") => { /* ... */ }
    Some(other)     => { /* friendly "unknown command" + usage */ }
    None            => { /* usage help */ }
}
```

Slow down here, because this is the course folded into itself. `.get(1)` returns **`Option<&String>`** — Lesson 14; indexing with `args[1]` would *panic* on an empty keyboard, while `.get` hands you the "wala" case as a value. `.map(|s| s.as_str())` transforms the inside of the Option with a closure — the same move as Lesson 16's `map_err` — into a **`&str` slice** (Lessons 11-12) we can match against literals. Then `match` forces us to handle **every** case — Lesson 15 — including `Some(other)` and `None`. Option, closures, slices, exhaustive matching: one line. When people say Rust features *compose*, this is what they mean.

### Three Kitchen Stations (Lesson 18, Applied)

| File | Station | Job |
|---|---|---|
| `src/main.rs` | The counter | Read args, dispatch, turn every failure into one friendly sentence |
| `src/record.rs` | The prep station | `SaleRecord` struct + `parse_line` — raw CSV row in, honest record (or clear complaint) out |
| `src/report.rs` | The kitchen | Pure aggregation: Vec, HashMap, sort — over borrowed `&[SaleRecord]` views |

That is the real shipped layout. In this lesson's activity file, the same three stations live in **one file** as inline `mod record { ... }` and `mod report { ... }` blocks — identical names, identical `pub` boundaries, just flattened so a single file carries the whole tool.

### The `Result` Rail — Zero Unwrap, End to End

Every failure rides one rail, from the disk to Tita Malou's eyes:

```text
fs::read_to_string(path)  --Err?-->  "Hindi mahanap ang file na '...'"
parse_line(line)          --Err?-->  "Problema sa row 14 ...: hindi mabasa ang quantity..."
report functions          (pure math on clean records — cannot fail)
```

Each `?` passes the problem up; `main` catches it in exactly one place, prints the sentence, exits with code 1. Count the `unwrap()` calls in the finished program: **zero**. The `expect()` calls: **zero**. Lesson 16's policy — *panics are for bugs, errors are for sentences* — kept, in shipped code, on the program that computes a family's money.

### Tests on the Money Path

Because it *is* her money, the parser gets a `#[cfg(test)]` module (Lesson 23) with one last trick inside: a `#[test]` function can return `Result`, so even your proofs get to use `?` — no unwrap needed, not even there. Three tests guard `parse_line`: a payday row parses, an ordinary row is not payday, and a written-out number (`"sixteen"`) is rejected with a sentence instead of a crash.

### `cargo build --release` — Where the Binary Lands

The optimized binary appears at **`target\release\lutocli.exe`** on Windows, **`target/release/lutocli`** on Linux and macOS. One caveat Dan files away: a binary runs on the OS family it was built for. He builds on Windows, the carinderia desktop is Windows — done. Building *across* OSes is cross-compilation, a story past the end of this book.

### The Whole Course on One Menu Board

| Subcommand | What it computes | Lessons doing the work |
|---|---|---|
| `summary` | Rows, total kita, average, best day | 5 (u32 money), 8 (iterate + sum), 14 (`if let`), 17 (HashMap) |
| `top` | Top-3 ulam by servings | 17 (`entry().or_insert(0)`, Vec + sort), 11 (`&str` keys, borrowed) |
| `payday` | Quincena vs ordinary rows | 5 (booleans), 7 (branches), 13 (struct fields) |
| `weather` | Kita per weather bucket | 17 (HashMap buckets), 10 (borrowed views) |
| *(plumbing)* | Dispatch + file -> records, or a kind sentence | 11-15 + 25's `env::args`; 13 (struct), 16 (`Result`, `?`, `map_err`), 18 (modules), 23 (tests), 24 (I/O) |

---

## Key Takeaways

- **`std::env::args()` reads the command line** — collect into a `Vec<String>`; `args[0]` is the program, `args[1]` onward are the user's words. `cargo run -- summary` passes everything after `--` to your program.
- **`match args.get(1).map(|s| s.as_str())` is four lessons in one line** — Option instead of a panic, a closure transform, a string slice, an exhaustive match. Rust features are built to stack.
- **Modules are the shipping layout** — counter (`main.rs`), prep station (`record.rs`), kitchen (`report.rs`). Each station testable, readable, replaceable.
- **The `Result` rail runs end to end** — file read, every parsed row, one error funnel in `main`. Zero `unwrap()`, zero `expect()`: panics are for bugs, errors are for sentences — and tests guard the money path, returning `Result` so even proofs get `?`.
- **Errors are part of the user interface.** "Baka ang ibig mo sabihin ay...?" did more for Tita Malou's trust than any feature. Write error messages for the person who will actually read them.
- **`cargo build --release` produces one self-contained binary** — USB, copy, run. The promise from Lesson 1, kept in full.

---

## What's Next?

There is no Lesson 26. This is the end of Dan's Rust story — so let's say it properly. Three tools now share one name: Luto v1 answered questions with rules, Luto v2 predicted best-sellers with a model, and LutoCLI — the smallest and least glamorous of the three — is the one running right now, unattended, on a desktop with no internet, computing a real family's real money, driven by Tita Malou herself. Sometimes the most advanced thing you can build is the thing that refuses to break.

And you — you finished a course where the language fought you in Lesson 9 and you stayed. So here is the final assignment, and it isn't optional the way the others were: **find your community's carinderia problem.** The sari-sari store tracking utang in a notebook. The barangay office retyping the same spreadsheet every Monday. Build the small, sturdy, polite tool — parse the real data, handle every case, test the money path, `cargo build --release`, put it on a USB. Ship it to someone who will never know what a borrow checker is, and make sure they never need to.

Dan's Rust story ends here, at a carinderia counter in Marikina, with a 1.2 MB binary and a hand-written cheat sheet taped to a monitor. Yours is one `cargo new` away.

*— END NG KURSO. Salamat sa pagsama kay Dan. Ngayon, luto mo na.*
