# Print the Receipt

Mid-morning at the carinderia, and the office's catering order needs a real receipt — clean columns, a correct total, and the actual ₱ that Tita Malou asked for. Open `act_1.rs`: the pot is bought (`receipt`, an owned `String`) and the Adobo line is already cooked. Work the TODOs in order, with the rule from the video call in force: `format!` cooks, `push_str` assembles, `+` is retired.

## Task 1: Cook the Lines, Assemble the Pot

The Adobo line shows the whole pattern: `format!("{:<18} ₱{:>3}\n", dish1, 75)` borrows its arguments and hands back a brand-new `String`; `receipt.push_str(&line1)` stirs a borrowed view of it into your pot. Finish TODO 1: cook `line2` (Sinigang na Baboy, ₱95) and `line3` (Halo-Halo, ₱60) with the same template, `push_str` both, then close out the receipt — the dashed separator, a `TOTAL` line built with the same template (75 + 95 + 60), and ONE final `'\n'` appended with `.push()`. Single quotes on that last one: `push` takes a `char`, not a `&str`. Notice what never happens: `dish2` and `dish3` are still alive after every call, because `format!` only borrows. Nobody loses a pot.

While you're in the file, Part 3 holds the `+` that bit Dan this morning, commented out. Uncomment it, meet `error[E0382]: borrow of moved value: header` — `+` MOVES its left side — then re-comment it and let `+` stay retired.

## Task 2: Bytes vs Characters — Count Both

TODO 2 re-runs Kuya JM's demo. `halo` is `"Halo-Halo ₱95"` — count it with your eyes: thirteen characters. Now print `halo.len()` and `halo.chars().count()` and watch them disagree: 15 and 13. The two stowaways are the peso sign's extra bytes — `₱` is ONE character, THREE bytes, because Rust strings are UTF-8. `.len()` answers "how many bytes"; `.chars().count()` answers "how many characters." If your receipt-width math uses `.len()`, every line with a `₱` drifts.

## Task 3: Feed `first_word` a `&String`

TODO 3 is two commented lines — uncomment them, change nothing else. `first_word` was written in Lesson 11 for `&str`, yet you're handing it `&receipt`, a `&String`. It compiles because Rust coerces `&String` to `&str` at the call site. This is the course rule paying out: **functions take `&str`, structs own `String`** — a `&str` parameter welcomes literals, slices, and `&String`s alike. (Its answer, `**`, is not profound. The point is that it answered.)

## Sample Output

```
=== Receipt Printer — Lesson 12 ===

** Tita Malou's Carinderia **
Adobo              ₱ 75
Sinigang na Baboy  ₱ 95
Halo-Halo          ₱ 60
----------------------
TOTAL              ₱230


"Halo-Halo ₱95"
  .len()           = 15  <- BYTES
  .chars().count() = 13  <- CHARACTERS

First word of the receipt: **
```

## Reflection Questions

1. `format!` used `dish2` and `dish3` and both were still alive afterwards, yet `header + "..."` killed `header` for good. What do the two do differently with their arguments?
2. `"Halo-Halo ₱95"` is 15 bytes but 13 characters. Where exactly do the two extra bytes live, and which count should a column-alignment calculation use?
3. `first_word` was written a whole lesson before `receipt` existed, and never edited — yet `first_word(&receipt)` compiled. What did the `&str` parameter (plus one quiet coercion) buy you?

## Challenge: The Menu Board

Tita Malou wants the whole menu as ONE String, printed once, dish names shouting. Start from:

```rust
let dishes = ["Adobo", "Sinigang na Baboy", "Halo-Halo"];
let prices: [u32; 3] = [75, 95, 60];
```

Loop by index (`for i in 0..dishes.len()` — Lesson 8 skills), build each numbered line with `format!`, run the dish name through `.to_uppercase()`, and assemble with `push_str` into one `mut` board String. No `+` anywhere — it's retired, remember. Expected output:

```
1. ADOBO — ₱75
2. SINIGANG NA BABOY — ₱95
3. HALO-HALO — ₱60
```

## What You've Learned

- `String` is the pot you own — created with `String::from`, grown with `push_str` (a `&str`) and `push` (a single `char`); `&str` is a borrowed look into someone else's pot
- `format!` is the workhorse: `println!` syntax, borrows every argument, returns a new `String` — while `+` moves its left side and is retired from this course
- `.len()` counts BYTES and `.chars().count()` counts CHARACTERS — 15 vs 13 on `"Halo-Halo ₱95"` — and `&String` coerces to `&str`, which is why functions take `&str`
