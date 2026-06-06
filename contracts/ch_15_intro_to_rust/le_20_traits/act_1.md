# One Sandok, Many Ulam

Three carinderia types, one identical need: print yourself as a one-line summary. Instead of one function per type forever, sign one contract and serve every signer through a single function — then earn the `{}` the menu board deserves. Open `act_1.rs` and work through the TODOs in order.

## Task 1: The Default Method — Libre

The `Summarize` contract is already declared with its required method, `summary`. Finish the **default method**: make `short_label` return `format!("[REPORT] {}", self.summary())`. Notice what you just wrote — a default body calling a *required* method the trait itself never defines. Implement one small required method, inherit an API built on top of it: every signer gets `short_label` for free, without writing a line.

## Task 2: Sign the Contract Twice

Fill in the two `impl Summarize for ...` blocks. `MenuItem` summarizes as `{name} — ₱{price}`; `DailySales` as `{date}: ₱{total} kita, top dish: {top_dish}`. Same trait, two different bodies — the behavior is shared in *name and shape*, not implementation. Skip one and the compiler hands you E0046: not all trait items implemented. The contract is enforced, not suggested.

## Task 3: One Function, Any Signer

Implement `print_summary(item: &impl Summarize)`: print the bullet line `• {}` with `item.summary()`. Then, in `main`, uncomment `print_summary(&tuesday);` so the daily report goes through the SAME function as the dish. Inside `print_summary`, only the contract exists — `item.summary()` compiles, `item.price` would not, even when the caller passed a `MenuItem`. The function knows the sandok, not the ulam.

## Task 4: Earn the `{}` — `impl fmt::Display`

Fill in `fmt`: a single `write!(f, "{} — ₱{}", self.name, self.price)` as the last expression — no semicolon, so it produces the `fmt::Result` the signature demands. Once it compiles, the plain `{}` in Part 4 of `main` just works, and so would `format!("{adobo}")` and a free `.to_string()`.

## Sample Output

```
=== Isang Sandok: one trait, many types ===

• Adobo — ₱75
• 2026-06-02: ₱4870 kita, top dish: Sinigang na Baboy

[REPORT] Adobo — ₱75
[REPORT] 2026-06-02: ₱4870 kita, top dish: Sinigang na Baboy

Debug view:  MenuItem { name: "Adobo", price: 75 }
Same dish?   true

Menu board:  Adobo — ₱75
```

The last line is the payoff: `Adobo — ₱75`, no braces, no field names — clean enough to tape onto the actual menu board.

## Reflection Questions

1. `short_label` appears in *neither* `impl` block, yet both types can call it — and each label still comes out personalized. What two trait features make that possible?
2. Inside `print_summary`, why does the compiler refuse `item.price` even when the caller really did pass a `MenuItem`? What does the function actually know about `item`?
3. `Debug`, `Clone`, and `PartialEq` are derivable, but `Display` deliberately is not. What is different about the question each trait answers?
