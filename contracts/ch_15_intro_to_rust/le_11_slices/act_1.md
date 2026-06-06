# Slice the Menu Board

One program, three kinds of windows: short chalkboard labels cut from full dish names, weekday and weekend views cut from one seven-day revenue array, and a single `total()` that serves every view. Open `act_1.rs` and work through the TODOs in order.

## Task 1: `first_word` — Cut the Chalkboard Label

The signature is given — `fn first_word(s: &str) -> &str` — and `.find(' ')` already locates the space. Finish the `Some(space_at)` arm: return the window from the start of the string up to (NOT including) the space. "Sinigang na Baboy" must yield "Sinigang"; "Adobo" (no space) already returns itself. The full names in `dishes` never move and never get copied — every label is only ever a view into them. Note that the loop hands `first_word` a `&String` and it's accepted as `&str` without complaint: deref coercion at work.

## Task 2: Weekday and Weekend Windows

The seven-day `revenues` array runs Mon..Sun. Replace the two empty placeholder windows: `weekdays` must view Mon-Fri (indices 0-4) and `weekend` must view Sat-Sun (indices 5-6). Ranges are half-open — the end index is excluded — and the shorthands from the lesson (`..n`, `n..`) both work here. No copies: both names are views into the same untouched array.

## Task 3: One `total()` for Every View

`total(days: &[u32])` is already written — and that's the point of its signature. It already accepts `weekdays` (5 elements) and `weekend` (2 elements); finish TODO 4 by passing it the WHOLE array for the week total. `[u32; 7]` coerces to `&[u32]`, so the same function serves all three callers — no third function, no copy. While you're there: the commented `broken` line cuts `&price_tag[0..1]` through the middle of the three-byte `₱`. Uncomment it, run, read the panic message carefully, then re-comment it and confirm green.

## Sample Output

```
=== Tita Malou's Menu Board ===

-- Chalkboard (short) vs records (full) --
  Sinigang   <- Sinigang na Baboy
  Lechon     <- Lechon Kawali
  Adobo      <- Adobo

-- Price tag surgery --
  "₱95" is 5 bytes long, not 3
  sign = "₱", digits = "95"

-- Revenue views --
  Weekday total: P26555
  Weekend total: P14230
  Whole week:    P40785
```

The weekend really does earn P14,230 against the weekdays' P26,555 — the numbers Tita Malou asked for before promising the helper a sweldo, with zero arrays copied.

## Reflection Questions

1. `first_word` returns `&str` — a window into the caller's string. What would change if it returned a fresh `String` instead? Think allocations, and think about Tita Malou's "ayokong may dalawang spelling" rule.
2. Why does `total()` take `&[u32]` and not `[u32; 7]`? List the callers in this program that a `[u32; 7]` parameter would reject.
3. The `broken` line compiles but panics at runtime. Why can't the compiler catch this one bug class at compile time, when it catches everything else before the program runs?

## Challenge: The Midweek Average

Tita Malou suspects Tuesday-to-Thursday is her "true" baseline — Monday is payday-hangover slow, Friday is payday-rush fast. Write:

```rust
fn midweek_average(week: &[u32]) -> u32 {
    // TODO: window out Tue..Thu with &week[1..4], total it
    // (reuse your total() — it takes any &[u32]!), divide by 3.
    // TODO: in a comment, explain why this signature takes &[u32]
    // and NOT [u32; 7]: callers can pass a window of any length,
    // cut from an array, a Vec, or another slice — and nothing
    // gets copied or moved on the way in.
}
```

With the lesson's `revenues`, `midweek_average(&revenues)` must return `5201` — that's `(5200 + 4975 + 5430) / 3` in honest `u32` division, whole pesos as always, fractions dropped on the floor where they belong.

## What You've Learned

- A slice is a borrowed view — a pointer plus a length — into data someone else owns: `&str` for strings, `&[u32]` for arrays
- Half-open range syntax and its shorthands: `[0..5]`, `[..5]`, `[5..]`, `[..]`
- String slices count BYTES, so indices must come from boundary-finding methods like `.find(' ')` — and why `&str`/`&[u32]` parameters serve every caller through deref coercion
