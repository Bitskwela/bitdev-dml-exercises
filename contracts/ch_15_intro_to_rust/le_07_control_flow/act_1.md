# Rebuild Luto v1's Rule Engine

Rebuild the rainy-day rule from Dan's very first program — as a typed, compiled Rust binary that recommends an ulam and prices it by payday. Open `act_1.rs`; the inputs (`weather`, `is_payday`, `hour`) are already wired in.

---

## Task 1: Complete the Weather Chain

The recommendation `if` expression has its rainy branch done. Add the missing branches:

- `"hot"` → `"Halo-Halo — cool down muna."`
- `"cold"` → `"Bulalo — perfect for the cold."`
- final `else` → `"Adobo — the classic. You can never go wrong."`

Every arm must produce a `&str`, and an arm's last line carries **no semicolon** — that is how the arm hands its value to the chain.

## Task 2: Price by Payday — as an Expression

Replace the hardcoded `let price: u32 = 70;` with a single if-expression: `80` on payday, `70` otherwise. No mutable dummy variable, no overwrite — `price` is born initialized. Both arms must be `u32`, and the `else` is mandatory: without it, `price` would be half-born on regular days.

## Task 3: Merienda Mode

At three in the afternoon the carinderia changes personality. Using the `hour` input (24-hour clock), add a branch that **outranks the weather rules**: if `hour >= 15`, suggest `"Halo-Halo — peak merienda, peak heat."` when the weather is `"hot"`, and `"Turon — merienda classic, kahit anong panahon."` otherwise.

Think about *where* the branch goes — the first true condition wins, so a rule that outranks the others must be checked first. (Hint: an arm's body can itself be an `if` expression. Blocks all the way down, every arm still a `&str`.)

## Task 4: Meet E0308 on Purpose

Uncomment the `if quantity { ... }` lines near the bottom and run `cargo check`. Read the error — `expected bool, found integer` — then re-comment them. The live version underneath (`quantity > 0`) is the fix: Rust has no truthiness, so say what you mean.

---

## Sample Output

With `weather = "rainy"`, `is_payday = true`, `hour = 14`:

```text
==========================================
  ULAM RECOMMENDER v0.1 — Luto v1 reborn
==========================================
  Weather : rainy
  Payday? : true
  Hour    : 14:00

  Recommendation: Sinigang na Baboy — comfort food for a rainy day!
  Price tier    : 80 pesos

  (3 orders waiting — tara, luto na.)
```

Change `hour` to `15` and run again — merienda mode should take over with Turon, while the price stays payday-priced. Two independent decisions.

---

## Reflection Questions

1. Why must the merienda branch be checked *before* the weather branches? What would the program recommend at `hour = 16, weather = "rainy"` if it were checked last?
2. `let price: u32 = if is_payday { 80 } else { 70 };` — why does Rust make the `else` mandatory here, when a plain `if` statement doesn't need one?
3. In Python, `if quantity:` is idiomatic. Why does Rust turn the same line into a compile error instead of a convention?

---

## Challenge: One Honest Price

The carinderia's real pricing has three tiers: regular days are 70 pesos, paydays are 80 — but a *rainy* payday means bigger servings of sinigang, so 85. Rewrite the price selection as a **single `let`** with a nested if/else-if/else expression, and write a comment explaining why every arm must produce the same type — what would happen if one arm produced `"seventy"` or `70.0` instead?

Run it with `weather = "rainy"`, `is_payday = true`, `hour = 15`: you should get Turon at 85 pesos — merienda mode chose the dish, but the rainy payday still set the price.

---

## What You've Learned

- Rust branching: `if` / `else if` / `else`, braces always, no parentheses — and the first true condition wins, so rules are ordered deliberately
- Conditions must be `bool` (no truthiness), and `if` is an expression whose arms must all produce the same type
- Luto v1's rule engine reborn, typed and compile-checked — the rules were always Tita Malou's; the language just got stricter
