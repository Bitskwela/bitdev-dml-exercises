# Build the Payment Drawer

Rebuild Tita Malou's closing-time drawer as types that cannot lie: a `Payment` enum with data-carrying variants, an `Order` struct that holds it, and a tip jar tallied with `unwrap_or`. Open `act_1.rs` and work through the TODOs in order — the file compiles as shipped, and stays compiling after every TODO.

## Task 1: Declare the Trays (TODOs 1-2)

Add the two data-carrying variants to `Payment`: `GCash(String)` and `Maya(String)` — the app's reference number rides INSIDE the variant. Then give the enum an `impl` block with two constructor helpers, `gcash` and `maya`, that turn a `&str` into the owned String the variant wants — same move as `MenuItem::new`. Build the reflex while you're here: type `Payment::Gkash` once, read the E0599 calmly (code, arrows, the `help:` line that suggests the correct spelling), then delete it. There is no Gkash tray.

## Task 2: The Optional Tip (TODO 3)

Add `tip: Option<u32>` to the `Order` struct. Rust has no null — absence is a type, visible right on the struct: maybe a tip, maybe none, and the compiler will not let you forget which.

## Task 3: Three Orders, Three Ways to Pay (TODO 4)

Finish the three orders: breakfast paid in `Cash` with `tip: Some(5)` (the jeepney driver said "keep the change"), lunch via `Payment::gcash("REF-2384-001")` with `tip: None`, merienda as `Utang` with `tip: None`. Then un-comment the stray Maya payment — the Zumba instructor's halo-halo to-go. `{:?}` prints every layer at once: struct, enum inside it, Option beside it, reference number inside *that*.

## Task 4: The Tip Tally (TODO 5)

Replace the placeholder with the real tally: `breakfast.tip.unwrap_or(0) + lunch.tip.unwrap_or(0) + merienda.tip.unwrap_or(0)`. Reads as "if there's a tip inside, take it; if it's `None`, use 0." Two `None` tips become honest zeros instead of a crash or a silent wrong number. Expected: P5.

## Sample Output

```
=== Tita Malou's Payment Drawer ===
(money in whole pesos)

Order { dish: "Tapsilog", total: 95, payment: Cash, tip: Some(5) }
Order { dish: "Sinigang na Baboy", total: 120, payment: GCash("REF-2384-001"), tip: None }
Order { dish: "Lechon Kawali", total: 150, payment: Utang, tip: None }
Stray payment (halo-halo to-go): Maya("MAYA-7745-002")

Sales recorded:  P365
Tip jar tonight: P5

Sinigang na Baboy — paid via: GCash("REF-2384-001")
```

One more thing — scroll up in the compiler output. `cargo check` also warns `field 0 is never read`, twice: once for `GCash`, once for `Maya`. The compiler is pointing at the locked trays — you store those reference Strings and never *read* them, because you literally can't yet. Leave the warnings in; they vanish tomorrow, the moment `match` opens the trays.

## Reflection Questions

1. `"Gkash"` type-checks perfectly as a `String` but is a compile error as a `Payment`. What does that say about *where* you want this kind of bug to surface — and what did the string version cost Dan two weeks ago?
2. `lunch.tip` is `None`, and the program printed it, tallied it, and never crashed. Why can't a plain `u32` field ever represent "no tip honestly," and what does `Option<u32>` announce that `u32` can't?
3. Part 4 shows `lunch.payment` printing fine with `{:?}`, yet `if lunch.payment == Payment::GCash` won't compile (E0369). What is `Payment::GCash` *by itself*, and why can't `==` open the tray?

## Challenge: The Loyalty Card

Tita Malou wants to reward her longest-standing sukis with a peso discount. Add one field to `Order`:

```rust
loyalty_discount: Option<u32>, // Some(pesos off) for sukis, None for everyone else
```

The obvious payable-amount math is `order.total - order.loyalty_discount.unwrap_or(0)` — and it works, *until* it doesn't. Money is `u32`, and a `u32` cannot go below zero. Imagine Tita Malou, in a generous mood, granting Aling Nena a `Some(120)` discount on a P110 order: in a debug build that subtraction **panics** with `attempt to subtract with overflow`, and the drawer program dies at closing time.

1. Create two orders: a normal case (`Some(15)` off a P110 order) and the over-generous case (`Some(120)` off a P110 order).
2. Compute payables with the obvious subtraction, run it, and watch the second order panic. Read the message — that's a *runtime* crash the compiler couldn't prevent, because both numbers were legitimate `u32`s.
3. Fix it with the method built for exactly this — and keep the comment, because code that touches pesos should declare its business rule out loud:

```rust
let payable = order.total.saturating_sub(order.loyalty_discount.unwrap_or(0));
// u32 floor is 0: P120 off a P110 order means FREE, never negative pesos
```

## What You've Learned

- How to define an enum whose variants carry data — `GCash(String)` glues the reference to the tray, and the compiler rejects trays that don't exist
- That enums get `impl` blocks too: constructor helpers like `Payment::gcash("REF-...")`, same pattern as `MenuItem::new`
- How `Option<u32>` makes absence a visible, honest type — no null, no crash — and how `unwrap_or(0)` turns `None` into a safe default
- That data goes INTO a variant easily, but getting it OUT needs `match` — tomorrow's tool, today's `field is never read` warnings
