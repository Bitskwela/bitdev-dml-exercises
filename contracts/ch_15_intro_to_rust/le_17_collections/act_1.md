# Tally the Lunch Rush

Hold an entire lunch rush in memory and produce the first real LutoCLI output: a tally board with a top seller. The `Vec` is the order spike; the `HashMap` is the chalk tally board.

---

## Task 1: Ask, Don't Panic

Open `act_1.rs`. The order spike is given: a `Vec<String>` of 14 sales plus one last-minute `.push()` — 15 total. `sales[100]` would panic with "index out of bounds." Ask politely instead: `match sales.get(100)` with BOTH arms — `Some(dish)` prints the order, `None` prints `Order #101: wala — the rush was not THAT good.`

## Task 2: The Tally Idiom

Fill in THE line inside the `for dish in &sales` loop:

```rust
*tally.entry( ??? ).or_insert( ??? ) += 1;
```

`dish` is only *borrowed* from the Vec, and the map demands ownership of its keys — that's what the `.clone()` is for.

## Task 3: Safe Lookups

For `"Adobo"` and `"Kare-Kare"`, look each one up with `tally.get(lookup)` and match both arms. Adobo answers with `{lookup}: {count} sold`; Kare-Kare is not on today's menu and gets `{lookup}: wala sa menu ngayon, suki.` — a handled `None`, not a crash.

## Task 4: The Leaderboard

HashMaps are unordered — print one directly and the order shuffles every run. Collect `tally.iter()` into a `Vec<(&String, &u32)>`, sort DESCENDING with `.sort_by(|a, b| b.1.cmp(a.1))`, and print the `--- TALLY NG TANGHALIAN ---` board, one line per dish: `{count:>2}x  {dish}`. Then the top seller: `.first()` on the sorted leaderboard returns an `Option` (even a sorted Vec refuses to promise it isn't empty) — use `if let Some((top_dish, top_count)) = ...` for the final line.

---

## Sample Output

```
=== LutoCLI prototype: Lunch Rush Tally ===

Sales on the spike: 15
First order of the rush: Adobo
Order #101: wala — the rush was not THAT good.

Adobo: 5 sold
Kare-Kare: wala sa menu ngayon, suki.

--- TALLY NG TANGHALIAN ---
 5x  Adobo
 4x  Sinigang na Baboy
 3x  Lechon Kawali
 2x  Tinola
 1x  Halo-Halo

Top seller: Adobo — 5 plates. Tita Malou called it.
```

---

## Reflection Questions

1. The tally loop iterates over `&sales`, not `sales`. What exactly would go wrong with the bare form — and at which line would the compiler stop you?
2. `Option` shows up three times in this program: order #101, the Kare-Kare lookup, and `.first()` on the leaderboard. What single idea do all three share?
3. Why must the display step copy the tally into a `Vec` before sorting — why can't you just sort the `HashMap` in place?

---

## Challenge: Top Seller, No Sorting Allowed

Sorting the whole board just to find #1 is overkill. Iterators can find a maximum directly:

```rust
let top = tally.iter().max_by_key(|(_, count)| **count);
// TODO: `top` is an Option<(&String, &u32)> — match both arms.
// TODO: in a comment, answer: what does max_by_key return when
// the map is EMPTY, and why is that the same lesson as .get()?
```

About that `**count`: `.iter()` yields `(&String, &u32)` pairs, and `max_by_key` hands your closure a *reference* to each pair — so `count` arrives double-wrapped as `&&u32`. Two stars peel it down to the plain `u32` the comparison needs. And on an empty map there is no maximum, so you get `None` — not a crash, not a garbage answer. The empty lunch rush (typhoon day, no customers) is a *handled case*. Option, everywhere, always.

---

## What You've Learned

- `Vec<String>` as the ordered, growable record of a lunch rush — `vec![]`, `.push()` (needs `mut`), `.len()`, iteration by `&`
- `*tally.entry(key).or_insert(0) += 1;` — THE LutoCLI tally idiom: slot, default-if-vacant, bump through the `&mut`
- Safe lookups everywhere: `.get(i)`, `.get(&key)`, and `.first()` all return `Option` instead of panicking
- HashMaps are unordered, on purpose — tally in the map, display from a sorted Vec
