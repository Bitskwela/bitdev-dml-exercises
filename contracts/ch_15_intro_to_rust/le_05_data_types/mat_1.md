## Dan's Story: GCash-and-Cash Hour

The 15th. Quincena. By 11:30 the carinderia had two queues: the cash line, and the line of held-up phones glowing with GCash confirmation screens. The math itself was almost boring — three sinigang at ₱95 is ₱285, customer hands over a ₱500 bill, sukli ₱215, next. Dan ran that transaction maybe forty times before one o'clock, including one suki whose phone showed a balance of **₱358.25**. When the rush thinned, he opened the laptop to turn the morning into code and stalled on the very first line: the GCash receipts all said `₱95.00`. Decimals. So... `95.0`? He voice-noted Kuya JM and got a war story back.

> **Dan:** Kuya, yung GCash receipt nagsasabi "₱95.00", may decimals. So sa Rust, `let price = 95.0`? Parang mas tama yun diba, pera eh.
>
> **Kuya JM:** Wag. Wag kang maglalagay ng decimal point sa pera. Yung lumang payment system na nire-rewrite namin — floats lahat ng amounts — every single day, off by exactly ONE centavo yung daily report. Ayaw pirmahan ng Finance. Dalawang araw kaming naghanap ng bug.
>
> **Dan:** Tapos? May nag-typo lang ba?
>
> **Kuya JM:** Walang typo. Yung *number mismo* ang bug. Pinatype lang kami sa calculator: `0.1 + 0.2`. Sagot: `0.30000000000000004`. Pera ay integers, walang exception. Ikaw — simulan mo sa **pesos as `u32`**. Unsigned, kasi hindi nagne-negative ang cash drawer, at ang ceiling ay mahigit apat na bilyon.

Dan looked at the cash drawer — physical pesos, physical coins, not a fraction in sight — and deleted the `.0` before it could do to him what it did to JM's old team. *Money is a count, not a measurement,* he wrote. *Counts are integers. The drawer agrees.*

---

## The Concept: Scalar Types — Integers, Floats, bool, char

Rust is **statically typed**: every value has exactly one type, known at compile time, forever. Today's cast is the four **scalar** types — single values, no structure.

### The Integer Family

Twelve types. Two questions pick the right one: *can it be negative?* (signed `i` vs unsigned `u`) and *how big can it get?* (the number is the bit width).

| Size | Signed | Unsigned | Unsigned range |
|---|---|---|---|
| 8-bit | `i8` | `u8` | 0 to 255 |
| 16-bit | `i16` | `u16` | 0 to 65,535 |
| 32-bit | `i32` | `u32` | 0 to 4,294,967,295 |
| 64-bit | `i64` | `u64` | 0 to ~1.8 × 10¹⁹ |
| 128-bit | `i128` | `u128` | 0 to ~3.4 × 10³⁸ |
| pointer-sized | `isize` | `usize` | machine-dependent (64-bit on Dan's laptop) |

- **`i32` is the default.** Write `let x = 42;` with nothing forcing a choice and the compiler infers `i32`.
- **`usize` is for indexing and lengths** — collections measure themselves in it.
- **Course convention: pesos are `u32`.** The drawer never goes negative, and the ~₱4.29 billion ceiling is not a real constraint for a carinderia.

One honesty note on overflow: 255 + 1 in a `u8` **panics in a debug build** (`attempt to add with overflow`) and silently wraps to 0 in release — so never rely on wrapping unless you ask for it by name (`wrapping_add`).

### Floats — and Why Money Avoids Them

`f32` and `f64`; bare decimal literals like `4.6` default to `f64`. Floats are the right tool for measurements — ratings, temperatures, percentages — anything where "close enough" is genuinely enough. They are the wrong tool for money, and the mechanism matters more than the rule: binary cannot represent 0.1 exactly (the same way decimal cannot finish writing 1/3), so every float that *looks* like clean centavos is a microscopic lie, and thousands of additions compound the lie into a visible, Finance-rejecting centavo. `0.1 + 0.2 == 0.3` is `false` — in Rust, in Python, in JavaScript. Rust didn't cause this; Rust just refuses to let you pretend it isn't happening.

### `bool` — true or false, Nothing Else

`let is_payday: bool = true;` One byte, two values. The practical difference from Python: an `if` condition must be an actual `bool`. There is no "truthy" — `if quantity { ... }` does not compile, no matter how nonzero `quantity` is. You write `if quantity > 0` and everyone reading knows exactly what was asked.

### `char` — One Character, Four Bytes

Single quotes make a `char`; double quotes make a string. And here's the beat most tutorials skip: a Rust `char` is **not** one byte. It's a 4-byte **Unicode scalar value**, which is why `'₱'` and `'ñ'` each fit in a single `char` without drama — no mojibake, no two-byte hacks. (Strings are a different, messier story — UTF-8 bytes — for a later lesson.)

### Rust Never Mixes Types Silently

This is the lesson's spine. In Python, `3 + 4.5` quietly promotes the integer and hands you `7.5`. Rust refuses — *all* mixing is spelled out or rejected. *Add* a `u32` to an `f64`:

```rust
let mixed = total + avg_rating;   // u32 + f64
```

```text
error[E0277]: cannot add `f64` to `u32`
```

— with the blunt annotation `` no implementation for `u32 + f64` `` pointing at the `+`. *Compare* a `u32` with an `f64` instead — Dan typing the suki's ₱358.25 balance as `f64` and checking it against the `u32` total — and you get a different error, the genuine `error[E0308]: mismatched types`:

```text
error[E0308]: mismatched types
  --> src\main.rs:57:25
   |
57 |     if gcash_balance >= total {
   |        -------------    ^^^^^ expected `f64`, found `u32`
   |        |
   |        expected because this is `f64`
   |
help: you can convert a `u32` to an `f64`, producing the floating point representation of the integer
```

Same disease, two symptoms: **arithmetic** mixing raises **E0277** (no implementation for this operator between these types), while **comparison** mixing raises **E0308** (mismatched types). The span arrows tell the full story — `-------------` marks the `f64` that set the expectation, `^^^^^` marks the `u32` that broke it — and the `help:` line even offers a conversion.

### Explicit Casts with `as`

The fix for both errors is an **explicit cast with `as`**:

- `total as f64` — exact: every `u32` fits in an `f64` with nothing lost.
- `avg_rating as u32` — turns `4.6` into `4`. That is **truncation, not rounding** — the decimals are simply cut off.

`as` is Rust's way of making you sign for the conversion: if information gets lost, it's lost because *you*, visibly, on this line, said so.

---

## Key Takeaways

- **Twelve integer types**, picked by two questions: negative possible? how big? — and this course's standing convention: **pesos are `u32`**.
- **Money is never a float.** Binary cannot write 0.1 exactly, so float centavos compound into real discrepancies — `0.1 + 0.2 == 0.3` is `false`. Counts are integers; floats are for measurements.
- **`bool` means `bool`** — `if` takes a real boolean, never a "truthy" number — and **a `char` is a 4-byte Unicode scalar value**, so `'₱'` is one `char`, single quotes only.
- **Rust never converts types silently.** Mixing `u32` with `f64` is a hard compile error — **E0277** in arithmetic, **E0308** in comparison — and the only way through is an explicit `as` cast: lossy only when *you* choose, visibly, to make it lossy.
- **Overflow is not free real estate:** debug builds panic on it, release builds wrap silently.

---

## What's Next?

The sukli math — `quantity * price`, then `bill - total` — is about to get typed three separate times across today's exercise and challenge. Three copies of the same logic means three places for a bug to hide. Kuya JM has a rule about exactly this: *"Kapag inulit mo ng tatlong beses, function na 'yan."*

**Next Lesson: Functions** — where the sukli math finally gets a name, `fn` enters the kitchen, and the type annotations you practiced today stop being optional: on function parameters, Rust makes them mandatory.
