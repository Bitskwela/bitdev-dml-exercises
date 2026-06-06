## Dan's Story: The Recipe You Cannot Edit

Six-thirty in the morning, carinderia kitchen. Two rice cookers already steaming, Tita Malou portioning pork for the adobo, and Dan wedged into the corner table with his laptop. His second-ever Rust program had one job: track rice through the lunch rush — start with the morning's fifty cups, subtract every batch served. He typed it the way Python Dan would have: `let cups_of_rice = 50;` and then, a few lines later, `cups_of_rice = cups_of_rice - 4;`.

`cargo check`. And then, for the first time in his life, a compiler told Dan Santos *no*: `cannot assign twice to immutable variable`. He screenshotted the error and sent it to Kuya JM with three crying emojis.

> **Dan:** Kuya, the compiler is yelling at me. I changed a variable. CHANGED. A. VARIABLE. Apparently that's illegal now?
>
> **Kuya JM:** Sa Rust, lahat ng bagay final by default — like Tita Malou's recipes. Fifteen years, walang nagbabago sa adobo niya. Gusto mo baguhin? Sabihin mo nang malakas: `mut`.
>
> **Dan:** But why make me ask? Python never made me ask.
>
> **Kuya JM:** And remember what that cost you — the dataframe you overwrote mid-notebook, the whole night chasing numbers na mali pala from cell 12. Python let that bug in without a sound. Rust makes the silent overwrite a compile error. Now look at the bottom of the error. The `help:` line. The compiler literally typed the fix for you.

Dan read the error again, slower this time. It wasn't a rejection letter — it was a correction with the answer attached. He added three letters, `cargo check` went green, and he felt, weirdly, like he'd just signed his name on something. *Everything is final unless I say otherwise — out loud, in the code, where everyone can see it.*

---

## The Concept: Immutable by Default

### `let` Bindings

In Rust you create a variable with `let`. The official word is **binding** — you bind a name to a value:

```rust
let cups_of_rice = 50;
```

### Immutable by Default — and Why

By default, that binding is **immutable**: the name and the value are a sealed pair. Try to reassign and you get this, at *compile time*, before the program ever runs:

```text
error[E0384]: cannot assign twice to immutable variable `cups_of_rice`
 --> src/main.rs:6:5
  |
2 |     let cups_of_rice = 50;
  |         ------------ first assignment to `cups_of_rice`
...
6 |     cups_of_rice = cups_of_rice - 4;
  |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ cannot assign twice to immutable variable
  |
help: consider making this binding mutable
  |
2 |     let mut cups_of_rice = 50;
  |         +++
```

Why design a language this way? In Python, any line, anywhere, can quietly overwrite any variable — and that bug class, *accidental change*, costs real debugging nights. Rust's position: **change is the dangerous case, so change is the case that must be declared.** A plain `let` is a guarantee the value never changes for its whole life; you only need to watch the variables marked `mut`. In a 50-line program that's a nicety. In a 50,000-line payment service, it's the difference between auditing every variable and auditing five.

E0384 is also your first compiler error, and there will be others — so learn the **error-reading ritual**, calmly, in this order:

1. **The error code.** `error[E0384]` — every Rust error has a number. Run `rustc --explain E0384` for a full essay with examples. You are never the first person to hit it.
2. **The `help:` line.** Skip to the bottom. Rust errors very often end with a literal patch — here it wrote `let mut cups_of_rice = 50;` and even marked where the three new characters go (`+++`).
3. **The span arrows.** The `------` underlines where the binding was born; the `^^^^^` underlines the crime scene. Two arrows, full story: what you did at line 2 made line 6 illegal.

Panic reads errors top to bottom as one angry wall. The ritual reads them as three labeled parts.

### `mut` — the Explicit Opt-In

Three letters turn the rejection into a permission slip:

```rust
let mut cups_of_rice = 50;
cups_of_rice = cups_of_rice - 4;  // legal now
cups_of_rice -= 9;                // shorthand for the same thing
```

`mut` is not an apology — it's documentation. It tells every future reader, including future you: *this value moves; watch it.* One catch: `mut` lets the **value** change, never the **type**. A `mut` u32 stays a u32 forever.

### Shadowing Can Change the Type

You can declare a *new* variable with the *same name* as an old one:

```rust
let price = 70;                              // binding #1: u32
let price = price + 10;                      // binding #2: a NEW u32, built from #1
let price = format!("P{} (payday)", price);  // binding #3: a String!
```

This is **shadowing**, and it is not mutation. Each `let` creates a brand-new binding; the old one is simply covered up, like a new price card taped over yesterday's on the menu board. Because each binding is new, the **type can change** — u32 to String is fine. `mut` could never do that. Shadow when a value goes through *stages* — raw, then parsed, then formatted — and inventing three names (`price_raw`, `price_final`, `price_display`) would just clutter the kitchen.

### `const` — the House Rules

For values fixed for the entire program — house rules, not ingredients:

```rust
const SENIOR_DISCOUNT_PCT: u32 = 20;
```

Three things separate a `const` from a `let`: the **type annotation is required** (no inference), the name is **SCREAMING_SNAKE_CASE** by convention so constants are visible from across the room, and the **value must be known at compile time** and can never change. No `mut const`. Ever. The senior citizen discount is the law of the land — 20%, not negotiable during the lunch rush. That's a `const`.

### The Four, Side by Side

| Technique | Syntax | Value can change? | Type can change? | Use it for |
|---|---|---|---|---|
| Plain binding | `let x = 50;` | No | No | The default. Most variables. |
| Mutable binding | `let mut x = 50;` | Yes | No | Counters, accumulators, running totals |
| Shadowing | `let x = 50;` then `let x = ...;` | New binding each time | **Yes** | Transforming a value through stages |
| Constant | `const MAX: u32 = 100;` | Never | Never | Program-wide fixed rules |

---

## Key Takeaways

- **`let` bindings are immutable by default.** A plain `let` is a promise the value never changes — and the compiler enforces it with E0384.
- **Immutability-by-default kills the accidental-overwrite bug class** — the silent variable stomp Python allows, which costs real debugging nights.
- **`mut` is an explicit, visible opt-in.** It changes the value but never the type. Reading code, `mut` is a "watch this one" flag.
- **Shadowing creates a new binding under an old name** — and because the binding is new, the type CAN change. Use it for values that transform through stages.
- **`const` is for program-wide fixed rules:** type annotation required, SCREAMING_SNAKE_CASE, compile-time value, never changeable.
- **Read errors as three labeled parts:** the error code (`rustc --explain`), the `help:` line (often a literal fix), and the span arrows.

---

## What's Next?

Dan's rice tracker survived its first morning, and `mut` and shadowing are now tools instead of error messages. But notice what Dan quietly avoided: every peso today was a `u32` — whole pesos, integer math, no decimals in sight. Tomorrow that choice gets stress-tested at the counter during GCash-and-cash hour, when Dan asks the question every beginner asks — *"money has centavos, so... shouldn't I just use a float?"* — and Kuya JM answers with a war story from a payment-reconciliation rewrite that still makes him wince.

**Next Lesson: Data Types** — integers signed and unsigned, floats and where they betray you, booleans, chars, and the day money at the carinderia officially becomes a `u32`.
