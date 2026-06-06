## Dan's Story: The Tray That Doesn't Exist

Nine-forty PM, carinderia, closing time. Tita Malou counts the cash drawer by feel, the way she has for fifteen years, while Dan opens the payment notebook to type it up. Same page, three entries:

```text
Tapsilog          95    GCash
Sinigang         120    gcash
Lechon Kawali    150    Gkash
```

Three spellings. One wallet. And one old wound: two weeks ago, Dan's tally script reported the GCash total P120 short. He recounted the drawer twice. He briefly suspected a customer. The drawer was never wrong — the script compared strings, and `"Gkash"` silently matched nothing.

> **Tita Malou:** Yung GCash, anak. Alas-sais ng umaga yon, malabo pa ang ilaw. Fifteen years, hindi pa nagkakamali ang drawer na 'to. Ayusin mo ang computer mo.
>
> **Kuya JM:** Strings can lie, Dan. Ito ang sagot ng Rust: `enum`. Isipin mo yung turo-turo trays sa harap ng carinderia niyo — a customer can only point at what actually EXISTS. Kahit gaano kagutom, walang "Gkash" tray. Declare mo ang four trays, at ang compiler na ang humahawak. And the GCash refs from the app? Ilagay mo *yung ref mismo* sa loob ng tray. A variant can carry its own data.

Dan typed the enum — then, because two weeks ago still stung, committed Tita Malou's typo *on purpose*: `Payment::Gkash(...)`. `cargo check` answered with **E0599**, span arrows under the typo, and a `help:` line that didn't just reject the spelling — it **proofread** it: *there is a variant with a similar name*, diff attached, suggesting `GCash`. The typo that once cost a recount, a false suspicion, and half an hour of panic now costs one `cargo check`, fix included.

---

## The Concept: Enums — Types That Cannot Lie

A `String` payment method can hold *anything*: `"GCash"`, `"gcash"`, `"Gkash"`, `""`. All of them compile, and the bug only shows up at runtime — silently, as a total that's P120 short. The type said "any text is fine"; the truth was "there are exactly four payment methods." Rust's fix is a type that *is* the truth.

### `enum Payment` — Variants That Carry Data

```rust
#[derive(Debug)]
enum Payment {
    Cash,          // no extra data needed
    GCash(String), // the reference number rides INSIDE the variant
    Maya(String),  // same idea, different wallet
    Utang,         // the notebook remembers
}
```

An `enum` lists **every possible value at the definition**. A `Payment` is exactly one of these four **variants** — never two at once, never zero, never `"Gkash"`. You name one through the type with `::`, like `Payment::Cash`; misspell it and E0599 arrives at compile time, often with the correct spelling attached.

The parentheses in `GCash(String)` mean the variant **carries data** — the data is glued on. You *cannot* construct a `GCash` without its String (`Payment::GCash` alone is just a constructor function, `fn(String) -> Payment`, still waiting for one), and `Cash` *cannot* smuggle a reference in. Rust's two big custom types answer opposite questions: a struct is an **AND** — "what does this HAVE?", all fields at once, a filled-out order slip — while an enum is an **OR** — "which one IS this?", exactly one variant at a time, one tray on the turo-turo line.

### Enums Get `impl` Blocks Too

```rust
impl Payment {
    fn gcash(reference: &str) -> Payment { Payment::GCash(String::from(reference)) }
}
```

Associated functions as tidy constructors — `Payment::gcash("REF-2384-001")` reads exactly like `MenuItem::new`. But today's `impl` is for putting things *in*. Methods that look *inside* the variants need tomorrow's tool.

### `Option<T>` — the Most Important Enum, and Why Rust Has No Null

Every program eventually asks: *what if the value isn't there?* No tip on this order. Most languages answer with `null` (Python's `None`): a non-value in a value's uniform that walks past every check and explodes when touched — its own inventor calls it the "billion-dollar mistake." Rust's answer: **there is no null.** Absence is a *type of its own*, an enum in the standard library built from the same parts as `Payment`:

```rust
enum Option<T> {
    Some(T), // there IS a value, and here it is, inside the variant
    None,    // there is no value — and the compiler knows you know
}
```

Read `Option<u32>` as "maybe a u32." Two things beat null here. First, **absence is visible in the type**: `tip: Option<u32>` announces "this might be missing," while a plain `u32` can *never* secretly be empty. Second, **an `Option<u32>` is not a `u32` in disguise** — you can't add it or print it as pesos; the compiler forces the "eh kung wala?" question at compile time. `Option`, `Some`, and `None` are pre-imported everywhere: write `Some(5)` and `None` bare, no prefix.

### Enums Inside Structs — Types All the Way Down

```rust
struct Order {
    dish: String,
    total: u32,        // whole pesos, as always
    payment: Payment,  // exactly one of the four trays
    tip: Option<u32>,  // maybe a tip, maybe none — absence is a TYPE
}
```

Read the guarantees this buys: every `Order` *must* have a payment, that payment *can only be* one of four real methods, a GCash payment *always* carries its reference, and the tip is *honestly* optional. Four business rules, enforced before the program ever runs.

### `unwrap_or` — the Gentle First Tool

```rust
let tip_pesos = order.tip.unwrap_or(0);
// Some(5) -> 5        None -> 0
```

`unwrap_or(default)` reads as: *if there's a value inside, take it; if it's `None`, use this default.* No crash possible — you supplied the fallback, and for tips, `None` honestly means zero pesos. There is also a blunt tool, `unwrap()`: it takes the value out and **panics** — crashes the whole program — on `None`. In a quick prototype it's tolerated, *with a confession label*:

```rust
let tip_pesos = order.tip.unwrap(); // PROTOTYPE: crashes on None — replace before Ma touches this
```

That label is house policy from here on. Every `unwrap()` is a debt; Lesson 16's error handling pays the debts properly. Tonight, `unwrap_or` is all you need — except for one wall. By eleven, Dan's drawer printed beautifully, reference numbers included. Then he tried `if lunch_payment == Payment::GCash` and hit **E0369**: `Payment::GCash` isn't a value, it's `fn(String) -> Payment` — *which* GCash, carrying *which* reference? The ref is RIGHT THERE — `{:?}` prints it — but Dan can't extract it in his own code. `==` has no way to open the tray and look inside. Kuya JM: "Bukas, `match`. Promise, worth the wait."

---

## Key Takeaways

- **An enum defines a type by listing every possible value — strings can lie; enums can't.** `"Gkash"` type-checks as a `String` and fails silently at runtime; against an enum it's an E0599 at compile time, with the correct spelling suggested.
- **Variants can carry data.** `GCash(String)` glues the reference to the variant: no GCash without a ref, no Cash smuggling one in. Struct = AND; enum = OR.
- **Enums get `impl` blocks too** — constructor helpers like `Payment::gcash("REF-...")`, exactly like `MenuItem::new`.
- **`Option<T>` is the most important enum in the standard library.** Rust has no null; absence is a type — `Some(T)` or `None` — visible in every struct definition and impossible to forget.
- **`unwrap_or(default)` is the gentle first Option tool.** `unwrap()` panics on `None` and is tolerated only in prototypes with a `// PROTOTYPE:` confession — debts that Lesson 16 pays off.
- **Data goes INTO a variant easily; getting it OUT needs pattern matching.** The compiler's `field is never read` warnings point at the locked trays — not a bug, a cliffhanger.

---

## What's Next?

The drawer is typed, the trays exist — but Dan ended the night staring at `GCash("REF-2384-001")` like a kid at a locked display case: the reference visible through the glass, unreachable. Tomorrow is coin-sorting hour, and Kuya JM has been saving Rust's favorite keyword for exactly that scene: `match`, the tool that opens every variant and takes the data out — with a superpower called **exhaustiveness**: forget to handle a variant, any variant, and the compiler lists every spot you missed, by name, before the program ever runs.

**Next Lesson: Pattern Matching** — `match`, arms, binding the data inside variants, `Option` handled the grown-up way, and the day forgetting a case stops being possible.
