# Lend the Order, Don't Lose It

Last night's order board worked, but it worked the way a dish works when you've used five kalderos. Tonight's goal is simple and merciless: same behavior, **zero** calls to `clone()`. Open `act_1.rs` and work through the TODOs in order.

## Task 1: Shared Borrows — Many Readers, Walang Gulo

`print_order(order: &String)` is done for you — the one-ampersand fix. Your half is in `main`: lend `order1` a SECOND time (no clone), then bind two simultaneous readers — `counter_copy` and `kitchen_copy` — and print both. That's four readers of one String, and the owner still prints it at the end: the exact line that demanded a `clone()` in Lesson 9. Search the whole file for `clone`: zero matches.

## Task 2: The Exclusive Borrow — One Hand Writes

Finish `add_note(order: &mut String)`: append `" — extra rice"` with `push_str`. Method calls reach through references on their own — no star needed. Notice `mut` signed in all three places: `let mut order2` (the owner), `&mut order2` (the lender), and `&mut String` (the signature). The note must land on the *real* order — the bug that survived all of Lesson 9, dead in one line.

## Task 3: The Scheduled Accident

Part 3 of `main` holds three commented-out lines. Uncomment them, run `cargo check`, and meet `error[E0502]: cannot borrow order2 as mutable because it is also borrowed as immutable`. Read the three arrows calmly: where the reader was born, where the `&mut` barged in (hiding inside the `add_note` call — the rule applies no matter who holds the pen), and where the reader is *still used afterward*. Re-comment the lines and confirm green before moving on.

## Task 4: The Running Tab — `add_utang` × 3

Tita Malou's suki puts breakfast, lunch, and merienda on the tab — three writes to one balance. Finish `add_utang(balance: &mut u32, amount: u32)`: plain arithmetic does NOT reach through a reference on its own, so dereference with the star — `*balance += amount;`. The breakfast call is done for you; add lunch (95) and merienda (60), printing the running tab after EACH call. (Why is `amount` not also a reference? It's `u32` — Copy. Lending a photocopy machine a photocopy is just extra paperwork.)

## Sample Output

```
=== Tita Malou's Order Board v2 ===
(borrow-first edition — zero clones)

ORDER UP: Sinigang na Baboy + rice
ORDER UP: Sinigang na Baboy + rice
Counter reads: Sinigang na Baboy + rice
Kitchen reads: Sinigang na Baboy + rice
Owner still has: Sinigang na Baboy + rice

Before the note: Adobo + rice
After the note:  Adobo + rice — extra rice
ORDER UP: Adobo + rice — extra rice

Suki's tab: P85
Suki's tab: P180
Suki's tab: P240
```

## Reflection Questions

1. Four readers of `order1` were alive at the same moment in Task 1 and the compiler didn't blink — yet two `&mut` borrows of one value is instantly rejected. What can readers never do that makes any number of them harmless?
2. `add_note` wrote through its reference with `order.push_str(...)` — no star — but `add_utang` needed `*balance += amount`. What's different between the two writes?
3. In Task 3's broken code, deleting the final `println!("{}", reader)` makes everything compile, even though the shared borrow and the `&mut` write are both still there. Why does a borrow's lifetime depend on a line *below* the error?

## Challenge: Two Pens, One Notebook

Now break the *other* rule on purpose — two writers, same value, overlapping:

```rust
fn main() {
    let mut tab = String::from("Suki tab: P85");

    let first = &mut tab;  // writer #1 picks up the pen...
    let second = &mut tab; // ...writer #2 grabs it too: DENIED
    first.push_str(" + P95");
    second.push_str(" + P60");

    println!("{}", tab);
}
```

`cargo check` delivers the verdict:

```text
error[E0499]: cannot borrow `tab` as mutable more than once at a time
 --> src\main.rs:5:18
  |
4 |     let first = &mut tab;  // writer #1 picks up the pen...
  |                 -------- first mutable borrow occurs here
5 |     let second = &mut tab; // ...writer #2 grabs it too: DENIED
  |                  ^^^^^^^^ second mutable borrow occurs here
6 |     first.push_str(" + P95");
  |     ----- first borrow later used here
```

E0499 is E0502's sibling — not reader-vs-writer this time, but writer-vs-writer: dalawang kamay sa isang notebook. Now fix it **without deleting any writes**, using scope braces — wrap writer #1 in a `{ }` block so its borrow provably ends, pen down at the closing brace, before writer #2 begins:

```rust
{
    let first = &mut tab;
    // ...first's write goes here...
} // first's borrow ends HERE. The pen is back on the counter.
// ...now writer #2 may legally borrow...
```

Requirements: the final output must be exactly `Suki tab: P85 + P95 + P60`, and keep the broken version in your file as comments with the E0499 text pasted in a comment block next to it — your own museum of errors you can already read calmly. (Sharp eyes will notice line 6 is what doomed the broken version — borrows end at their last use, so swapping two lines would also fix it. The `{ }` block is the version that says so out loud.)

## What You've Learned

- The one-ampersand fix: `&` lends a value instead of moving it, so Lesson 9's E0382 — and every clone it forced — disappears
- `&T` allows any number of simultaneous readers; `&mut T` allows exactly one writer, with `mut` signed by the owner, the lender, and the signature
- How to read E0502 and E0499 by their three arrows — and that a borrow lives until its *last use*, so reordering lines or `{ }` scoping are both honest fixes
- Method calls reach through references automatically; plain arithmetic needs the explicit `*` dereference
