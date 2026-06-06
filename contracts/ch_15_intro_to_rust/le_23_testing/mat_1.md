## Dan's Story: Receipts or It Didn't Happen

Nine forty-seven PM, Dan's room in Marikina. LutoCLI's money functions finally lived together in one project — `compute_change`, `senior_discount`, `parse_price` — and the receipt output looked so clean that Dan posted a screenshot in the data-nerds Discord, captioned *"Luto v1 predicted the menu. Luto v2 predicted the sales. LutoCLI computes the money. The trilogy is real."* Three minutes later, a DM. Ate Rina.

> **Ate Rina:** Nice screenshot. How do you know the numbers are right?
>
> **Dan:** I ran it. Tama lahat ng lumabas.
>
> **Ate Rina:** You looked at the output. Once. At night, pagod ka. That's the QA process for your mother's money? Bata, LutoCLI computes Tita Malou's money. *Prove* it works.
>
> **Ate Rina:** Prove it how? Not by running it a hundred times. Your code needs a checker that never sleeps. Rust ships one: write a function that calls your function and *asserts* the right answer, mark it `#[test]`, and `cargo test` runs every checker you've ever written, in seconds, every time. Tita Malou doesn't trust the drawer count because it "looks tama" — she counts it against the notebook. Write the notebook.

So Dan wrote the notebook: a `#[cfg(test)] mod tests` block at the bottom of the file. Exact payment returns zero sukli. `senior_discount(80)` returns P64. `parse_price` accepts `" 120 "` and rejects garbage. All friendly numbers — and Ate Rina caught it: *"100, 500, 80. Round, divisible. Easy numbers are where bugs go to hide. Open the actual ledger and find an awkward one."* There: Lola Cion, last Tuesday. Total P99, senior. Tita Malou's pencil math in the margin: *20% of 99... P19 off... P80.* Dan added one more test — `senior_discount(99)` should be `80` — and ran the suite. Six passed. One did not:

```text
thread 'tests::test_senior_discount_99' (90832) panicked at src/main.rs:92:9:
assertion `left == right` failed: Lola Cion's P99 order: dapat P80
  left: 79
 right: 80
```

Left: 79. Right: 80. The machine claimed his function priced Lola Cion's order at seventy-*nine* pesos. Two weeks ago, tidying the code, Dan had "simplified" `total - total * 20 / 100` into `total * 80 / 100`. Algebra is algebra — but not in `u32`. Integer division throws away the remainder, so *where* you divide decides *what* gets thrown away. `99 * 20 / 100` is `19` — P19 discount, P80 to pay, exactly the pencil math. But `99 * 80 / 100` is `7920 / 100` — `79`. The "simplification" truncated the **price** instead of the **discount**, quietly handing out an extra peso on every senior order that isn't a multiple of five. And the friendly test — `senior_discount(80)` — had passed under *both* formulas, vouching for a buggy function the whole time. Dan restored the original line, watched seven green `ok`s scroll past, and typed: *"It would have shipped, Ate. One peso off on odd orders, forever — and the first time Tita Malou checks the screen against her notebook, she stops trusting the whole tool."*

> **Ate Rina:** And now it can never ship. That one-line test guards the formula forever — the day somebody "simplifies" it again, the test screams before your mother ever sees it. That's what tests are, bata. Bayanihan with future-Dan: past-you carries the house so future-you doesn't drop it. ...Finally, a computer as strict as me.

## The Concept: Tests — Bayanihan with Future-Dan

A test is the cheapest insurance in software: a function that calls your function with known inputs and *asserts* the known answer. Write it once, and every `cargo test` from now until forever re-checks that promise — after every refactor, every "harmless cleanup," every 2 AM idea. You are not writing tests for today-you, who just watched the code work. You are writing them for future-you, who will change something six weeks from now and needs a hundred neighbors to yell if the house slips.

### `#[test]` — a Function Whose Job Is to Check a Function

Mark any function with the `#[test]` attribute and `cargo test` will find it, run it, and report. A test passes if it runs to the end without panicking; it fails if anything inside panics — and the `assert!` family exists precisely to panic with a *useful report* when reality doesn't match expectation:

```rust
#[test]
fn test_compute_change_exact_payment() {
    assert_eq!(compute_change(100, 100), 0);
}
```

### The `assert!` Family

| Macro | Checks | On failure, prints | Reach for it when |
|---|---|---|---|
| `assert!(cond)` | `cond` is `true` | the condition's source text | yes/no facts: `is_err()`, `>=`, `contains` |
| `assert_eq!(a, b)` | `a == b` | **both values**, as `left` and `right` | "the answer must be exactly X" — most tests |
| `assert_ne!(a, b)` | `a != b` | both values | "whatever it is, it must NOT be this" |

All three accept an optional custom message with `format!`-style arguments: `assert_eq!(compute_change(500, 387), expected, "sukli dapat {}", expected)`. And adopt this convention today: put the **call** first, the **expected value** second — then `left` is always what the code did, `right` is what it should have done, and you can read any failure at a glance.

### `#[cfg(test)] mod tests` — the Proof Stays in the Kitchen

```rust
#[cfg(test)]
mod tests {
    use super::*; // pull in every function from the parent module
}
```

Two pieces, two jobs. `use super::*;` imports everything from the enclosing file, so tests can call `compute_change` without ceremony. And `#[cfg(test)]` is **conditional compilation**: this entire module exists only when you run `cargo test`. When you run `cargo build --release` — the build that goes on the USB stick — the tests are not skipped, not disabled, but *never compiled at all*. Zero bytes of checker code in Tita Malou's binary. The proof stays in the kitchen; only the dish goes out.

### `cargo test` — a Hundred Checkers in Parallel

`cargo test` compiles a special test build and runs every `#[test]` it finds — **in parallel, on separate threads**. That's why the output order shuffles between runs, and why tests must be independent: no test may rely on another running first or on shared mutable state. Each checker counts its own drawer. You can also run a subset — `cargo test discount` runs every test whose *name contains* `discount` — and the summary reports the rest as `filtered out`, not skipped in shame. This is how you iterate on one bug without re-running the world.

### Reading a Failure: Left and Right

1. **The thread name** tells you *which test* (parallel runs, one thread each); **the custom message** tells you *what was at stake* — this is why you write them.
2. **`left` vs `right`** is *the disagreement itself*: code said 79, truth says 80. The size and direction of the gap often points straight at the bug — "off by exactly one peso" practically shouted *truncation* at Dan.
3. **`src/main.rs:92`** is where the assert lives, so you can go see the inputs. And remember which test caught the bug: not the friendly `80`, the ugly `99`. Test boundaries, odd totals, real ledger entries — not the examples you invented because they're easy to verify in your head.

### `#[should_panic]` and Tests That Return `Result`

Some functions are *supposed* to panic — that's their contract, and you test the contract:

```rust
#[test]
#[should_panic(expected = "kulang ang bayad")]
fn test_compute_change_kulang_panics() {
    compute_change(50, 387); // P50 for a P387 order: must panic
}
```

This passes only if the code panics **and** the panic message *contains* the `expected` substring. Always supply `expected` — a bare `#[should_panic]` is satisfied by *any* panic, including a brand-new bug panicking for the wrong reason two lines earlier.

```rust
// And at the other end: a test may itself RETURN a Result,
// which unlocks the `?` operator from Lesson 16.
#[test]
fn test_parse_price_trims_spaces() -> Result<(), String> {
    let price = parse_price(" 120 ").map_err(|e| e.to_string())?;
    assert_eq!(price, 120);
    Ok(())
}
```

`Ok(())` at the end means pass; any `Err` propagated by `?` means fail, with the error printed. Same plumbing you already know, now keeping your tests as clean as your functions — no `unwrap()` clutter.

## Key Takeaways

- **A test is a function marked `#[test]` that calls your code and asserts the answer — bayanihan with future-Dan.** It passes by finishing, fails by panicking; `cargo test` runs every one, in parallel, in seconds (filter with `cargo test <name>`). Every assertion is past-you carrying the house so the next refactor can't silently drop it.
- **`#[cfg(test)] mod tests { use super::*; }` is the convention** — tests live beside the code they check, but the module is only compiled for `cargo test`. The release binary on the USB stick ships zero test code.
- **`assert_eq!` failures print `left` and `right`.** Keep the convention: left is what the code did, right is what it should have done. Custom messages (`"sukli dapat {}", expected`) tell future-you what was at stake.
- **Friendly inputs hide bugs; ugly inputs and boundaries expose them.** `senior_discount(80)` vouched for a broken function; `senior_discount(99)` convicted it. With integer math, *where* you truncate is part of the spec — truncate the discount, never the price.
- **`#[should_panic(expected = "...")]` tests a panic contract** — the `expected` substring keeps a wrong panic from passing as the right one — and **tests can return `Result<(), String>`**, which unlocks `?` inside them.

## What's Next?

Seven green checkers now stand guard over LutoCLI's money math, and Ate Rina has signed off — her highest compliment on record ("Counts."). But everything LutoCLI computes still comes from values typed into the source code. Tita Malou's real numbers don't live in `main()`; they live in a file. Tomorrow, the dataset comes home: the *same* sales CSV Dan cleaned and fed to Luto v2 back in the ML course gets opened by Rust for the first time — and every way a file can fail (missing file, yanked USB stick, one blank cell with a history) will be a `Result` Dan handles on purpose, with tests to prove it.

**Next Lesson: File I/O** — `std::fs`, reading and writing files, paths, and the day LutoCLI meets the carinderia's real sales data.
