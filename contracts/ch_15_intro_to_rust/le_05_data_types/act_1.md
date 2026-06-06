# Type the Sale, Compute the Sukli

Ring up the carinderia's signature transaction with every scalar type on duty — and meet the compiler error that protects the drawer.

---

## Task 1: Declare the Sale, Fully Annotated

Open `act_1.rs`. Replace the placeholder values with the real morning, keeping every type annotation:

- `quantity: u32` — three orders of sinigang; `price: u32` — ₱95 each (pesos are `u32` in this course, JM's rule)
- `is_payday: bool` — it's the 15th; `peso_symbol: char` — `'₱'`, one char, a 4-byte Unicode scalar
- `avg_rating: f64` — 4.6 stars; floats are for NOT-money numbers

---

## Task 2: Compute the Total and the Sukli

The customer hands over a ₱500 bill. `bill` is unannotated on purpose — the subtraction you write pins it to `u32`, not the `i32` default. Compute `total` as `quantity * price` (u32 in, u32 out) and `sukli` as `bill - total` — 500 − 285 = 215.

---

## Task 3: Fix the Mismatch with `as`

At the bottom of `main`, a suki's question waits, commented out: her GCash balance shows **₱358.25**, typed as `f64`, compared against the `u32` total. Uncomment the block, run `cargo check`, and read `error[E0308]: mismatched types` in full. Then make it compile with an explicit `as` cast — deciding *which side* of the `>=` gets converted before you write it.

---

## Sample Output

```text
=================================
   CARINDERIA NI ALING MALOU
=================================
payday today?       true
average rating:     4.6 stars
3 x sinigang  @  ₱95 each
total:              ₱285
cash received:      ₱500
sukli:              ₱215

0.1 + 0.2         = 0.30000000000000004
0.1 + 0.2 == 0.3? false

'₱' and 'ñ' are one char each — 4 bytes in memory
Sapat ang balance mo, suki!
```

---

## Reflection Questions

1. In Task 3, why is `total as f64` the right fix and `gcash_balance as u32` the wrong one? What exactly would the wrong cast do to ₱358.25 — and whose money disappears?
2. `0.1 + 0.2 == 0.3` prints `false`. Explain the mechanism: what can't binary write exactly, and why does the error matter more after thousands of additions than after one?
3. `bill` has no type annotation, yet it ends up `u32` instead of the `i32` default. What line in *your* code forced that choice?

---

## Challenge: The Centavo Drawer

Kuya JM said centavos would still be integers. Prove it. Rewrite the sale with **all money as centavos in `u64`** — `9_500` for the price, `50_000` for the bill — floats banned entirely. Format the output back to peso-and-centavo form using only integer division and modulo (`{:02}` pads the remainder to two digits, so 5 centavos prints as `.05`, not `.5`):

```rust
println!("₱{}.{:02}", cents / 100, cents % 100);
```

```text
price: ₱95.00
total: ₱285.00
sukli: ₱215.00
```

Why `u64` now, when pesos were fine in `u32`? Multiplying everything by 100 eats two decimal digits of your range; `u64`'s ceiling makes the question permanently boring.

---

## What You've Learned

- How to pick an integer type with two questions — and why this course's money is `u32`, never a float
- How E0308 reads (the span that set the expectation vs. the span that broke it) and how `as` fixes it — casting the integer up, losslessly, never the float down
- That `'₱'` is a single 4-byte `char`, and that integer division plus modulo can format centavos without a float in sight
