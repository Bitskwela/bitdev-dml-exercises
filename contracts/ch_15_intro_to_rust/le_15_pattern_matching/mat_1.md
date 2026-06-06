## Dan's Story: Every Coin Gets a Tray

Saturday, 8:40 PM at the carinderia. Chairs up, teleserye on, and Tita Malou doing what she does every closing: tipping the coin can over and sorting — piso tray, five-peso tray, ten, twenty, hands moving without her eyes. Dan, laptop open by the vinegar caddy, had the Lesson 14 cliffhanger gnawing at him: the GCash reference number was stored INSIDE `Payment::GCash(String)`, and he had no way to get it out. In the box, key lost.

> **Kuya JM:** Sabi ko one keyword, diba. Look at your mom. `match` is Tita Malou sorting coins at closing — every coin has exactly ONE tray, and Rust checks na walang nakakalimutang tray. And the GCash arm can OPEN the variant and take the ref number out.

Dan typed his first `match` — one arm per payment, one tray per coin — and forgot `Utang`. `cargo check` refused to build: `error[E0004]: non-exhaustive patterns`. The forgotten case wasn't a bug waiting to explode three weeks later in front of a customer; it was a compile error tonight, habang mainit pa ang kape. He added the arm, hit green, and there it was on screen, free at last: `P150 — GCash ref GC-7741`. The Lesson 14 prisoner, walking out of the variant. Then Tita Malou, mid-sort: the bank was offering her a card reader. *Kaya ba yan ng programa mo, o magkakagulo na naman tayo?* In Luto v1, one new option meant grep-hunting every `if` chain and praying. Tonight Dan added a single line to the enum — `Card(String)` — and `cargo check` answered with two errors, two line numbers: the compiler had walked the ENTIRE program and listed every `match` that didn't have a tray for `Card` yet. Not a crash in production. Not a silent mis-sort. A checklist, with addresses. *I added a payment method,* Dan grinned, *and the compiler handed me a TODO list. It walked the route ahead of me and checked every door.*

> **Kuya JM:** Sa payment team namin, this is the entire reason we sleep at night. May bagong payment channel? Add the variant, then follow the red hanggang maging green. The compiler does the remembering — may bodyguard ka na.

---

## The Concept: One Tray for Every Case

### Match Arms

```rust
match payment {
    Payment::Cash => println!("cash tray"),
    Payment::GCash(ref_no) => println!("GCash tray, ref {}", ref_no),
    Payment::Maya(ref_no) => println!("Maya tray, ref {}", ref_no),
    Payment::Utang => println!("lista notebook"),
}
```

The value being matched is the coin in your hand. Each `pattern => expression,` line is an **arm** — a tray. Rust checks the arms top to bottom, runs the first one whose pattern fits, and skips the rest. Exactly one arm runs, always. And like `if` in Lesson 7, `match` is an **expression**: every arm must produce the same type, and the match evaluates to whichever arm ran — which is why `describe` in tonight's program is one `match` with no `return` statement at all.

### Binding Variant Data — the Jailbreak

A pattern does two jobs at once: it checks *which* variant it is, AND gives the data inside a name:

```rust
Payment::GCash(ref_no) => format!("GCash ref {}", ref_no),
```

If the payment is a `GCash`, the `String` riding inside gets bound to `ref_no` — usable in that arm's body, and only there. This is the answer to last lesson's cliffhanger: the data was never unreachable, it was just waiting for a pattern shaped like its variant. One practical note: when you match on a `&Payment` (a borrow — the caller still owns the order), the bindings come out as references too, so `ref_no` is a `&String`. Read it, print it, compare it — just don't try to *move* it out of a borrow.

### Exhaustiveness as a Feature

The rule that makes `match` more than a prettier `if`: **a `match` must cover every possible case, or it does not compile.** Miss one variant and you get the error from the story:

```text
error[E0004]: non-exhaustive patterns: `&Payment::Utang` not covered
  --> src/main.rs:36:11
   |
36 |     match p {
   |           ^ pattern `&Payment::Utang` not covered
   |
note: `Payment` defined here
  --> src/main.rs:12:6
   |
12 | enum Payment {
   |      ^^^^^^^
...
16 |     Utang,         // suki credit — nasa lista notebook
   |     ----- not covered
   = note: the matched value is of type `&Payment`
help: ensure that all possible cases are being handled by adding a match arm with a wildcard pattern or an explicit pattern as shown
   |
39 ~         Payment::Maya(ref_no) => format!("Maya ref {}", ref_no),
40 ~         &Payment::Utang => todo!(),
   |
```

This is a *feature*, and it works in both directions. **Writing a match:** the compiler counts your trays — forget the lista and the build fails tonight, not in production on a random Tuesday. **Changing the enum:** add a variant, and every `match` that doesn't handle it becomes a listed compile error — file, line number, suggested fix. A free refactoring checklist. In Python, a new payment type slips silently past every `if`/`elif` chain; in Rust, the change *cannot ship* until every sorting point has a tray for it.

### `_` — the Catch-All That Blindfolds the Bodyguard

The pattern `_` alone matches *anything*, so `_ => other_count += 1` (the "lahat ng iba" tray) satisfies exhaustiveness. It has honest uses — match on a `u32` and you physically cannot write four billion arms. But on an enum **you own**, `_` is a trap: it satisfies exhaustiveness *forever*. Add `Card` next month and the compiler says nothing — `Card` slides silently into the "other" tray, miscounted, unflagged. The bodyguard can't warn you about doors he's been told to ignore. Rule of thumb: on your own enums, spell out every arm; reach for `_` only when the type genuinely has more cases than you could ever list.

### Matching `Option<T>`

`Option<T>` is just an enum — `Some(T)` or `None` — so it sorts like any other coin:

```rust
match tip {
    Some(t) => println!("Tip received: P{}", t),
    None => println!("Walang tip today."),
}
```

Exhaustiveness applies here too: delete the `None` arm and E0004 stops you. The Sunday crash that started this whole course was Python letting Dan *forget the blank cell* — Rust's `match` makes forgetting the empty case a compile error. Same bug class, opposite default.

### `if let` — When Only One Tray Matters

Sometimes a full match is mostly ceremony: a `None => {}` arm exists only to say "do nothing." For the one-pattern case, Rust has `if let`:

```rust
if let Some(tip) = order.tip {
    println!("tip: P{}", tip);
}
```

Read it as: *if the value fits this pattern, bind and run the block; otherwise skip* (an `else` is allowed for the other side). Know the trade: `if let` gives up exhaustiveness checking *on purpose* — fine when ignoring the other cases is genuinely the plan, dangerous when it isn't. The rule, verbatim, take it to heart:

**"match when you care about every case; if let when you care about one."**

## Key Takeaways

- **`match` sorts a value into exactly one arm** — patterns checked top to bottom, first fit wins, one arm always runs. Every coin gets a tray.
- **Patterns bind the data inside variants.** `Payment::GCash(ref_no)` checks the variant AND names its contents — this is how data gets *out* of an enum. Matching on `&Payment` makes the bindings references; read, don't move.
- **Exhaustiveness is the bodyguard.** A missing variant is `error[E0004]` at compile time — and when you *add* a variant, the compiler lists every `match` that needs updating, with line numbers. Add the variant, follow the red until green.
- **`_` blindfolds the bodyguard.** A catch-all satisfies exhaustiveness forever, so new variants slide through silently. Use it for unlistable domains, never as a shortcut on enums you own.
- **"match when you care about every case; if let when you care about one."** `if let` trades exhaustiveness for brevity — a good trade only when skipping the other cases is truly the plan.
- **`match` is an expression** — assign it, return it, build a whole function body out of it, as long as every arm produces the same type.

## What's Next?

Dan's program sorts every payment into exactly one tray, the ref numbers are out of their boxes, and the compiler guards the trays better than he ever could. But tonight's data was all *clean* — every ref number well-formed, everything typed by Dan himself. Real data doesn't extend that courtesy. Remember the Sunday Python report that died over one blank cell? That crash finally gets its rematch — and Rust's answer is `Result<T, E>`, `Option`'s older sibling, where failure isn't a crash or a null but a *value* you can `match` on.

**Next Lesson: Error Handling** — `Result<T, E>`, recoverable versus unrecoverable errors, the `?` operator, and the day a bad input stops being a crash and becomes just another arm in the match.
