# Sort Every Coin into Its Tray

Lesson 14 locked the GCash reference number inside `Payment::GCash(String)`. Tonight you take it out — and sort every payment into exactly one tray, with the compiler counting trays behind you. Open `act_1.rs` and work through the TODOs in order.

## Task 1: `describe` — Free the Prisoner

`describe(p: &Payment) -> String` resolves the Lesson 14 cliffhanger. The `Cash` and `GCash` arms are written; the `Maya` and `Utang` arms are `todo!()` placeholders (they compile, but they panic the moment an order reaches them — the Utang order at the counter WILL find out). Replace both: mirror the GCash arm for Maya — `Payment::Maya(ref_no)` binds the reference number — and give `Utang` the string `"Utang (nasa lista)"`. Note that the input is a `&Payment`, so `ref_no` arrives as a `&String`; `format!` reads it happily. The whole function body is one `match` with no `return` — because `match` is an expression.

## Task 2: The Closing Tally — No `_` Allowed

Inside the `for` loop, write a `match &order.payment` that sorts each order into its counter: `cash_count`, `gcash_count`, `maya_count`, `utang_count`. Use `_` INSIDE a variant when you don't need the ref number — `Payment::GCash(_)` — but NO bare `_` catch-all arm. On purpose: the day a fifth payment method appears, we WANT this match to break the build. (Forget an arm and you'll meet `error[E0004]` yourself — read the `help:` line; it writes the missing arm for you.)

## Task 3: The Tip Line — `if let`

Only one pattern matters here: `Some(tip)`. `None` means print nothing, and a full `match` with an empty `None => {}` arm would be pure ceremony. Write `if let Some(tip) = order.tip { ... }` that prints the tip line from the TODO. "match when you care about every case; if let when you care about one."

## Sample Output

```text
=== Tita Malou's Payment Sorter ===
(money in whole pesos)

P 80 — Cash
P150 — GCash ref GC-7741
       tip: P20 (salamat, suki!)
P 95 — Utang (nasa lista)
P210 — Maya ref MY-5529
P 80 — GCash ref GC-1138
       tip: P10 (salamat, suki!)
P165 — Cash

=== Closing trays ===
Cash : 2 order(s)
GCash: 2 order(s)
Maya : 1 order(s)
Utang: 1 order(s)
Total sales: P780
```

## Reflection Questions

1. `Payment::GCash(ref_no)` does two jobs in a single pattern. What are they — and where is `ref_no` usable?
2. The tally match deliberately has no `_` arm. Why can a `_` catch-all on an enum you own be a trap? What happens, and what *doesn't* happen, the day `Card` gets added?
3. `describe` returns a `String` but contains no `return` statement. What property of `match` makes that work, and what must every arm agree on?

## Challenge: The Card Reader Arrives

Tita Malou said yes to the bank. The card reader lands Monday, and every card payment carries an approval code.

1. Add `Card(String)` to the `Payment` enum — the `String` is the approval code.
2. Run `cargo check`. **Don't fix anything yet.** Read the output top to bottom and notice it's a checklist: every `match` that needs a new tray, with line numbers.
3. Visit each listed location. In `describe`, bind the approval code and include it in the output (mirror the GCash arm). In the tally, count it — you'll need a `card_count` counter and a line in the closing report too. (Notice: the compiler catches the *matches* for you; the counter and the println are on you. Exhaustiveness guards every tray, not every feature.)
4. Add at least one `Card` order to the array so the new tray actually gets used.
5. When everything is green, write a comment at the top counting how many distinct places the compiler caught for you.

This is the exact experience Dan had at closing time, and it's the muscle to build: **add the variant first, then follow the red until it's green.** The compiler does the remembering.

## What You've Learned

- Patterns check the variant AND bind the data inside — `Payment::GCash(ref_no)` is how data gets *out* of an enum
- Exhaustiveness turns a forgotten case into tonight's compile error, and a new variant into a line-numbered TODO list
- `_` satisfies exhaustiveness forever — honest on unlistable types, a trap on enums you own
- `if let` handles the one-pattern case: brevity traded for exhaustiveness, on purpose
