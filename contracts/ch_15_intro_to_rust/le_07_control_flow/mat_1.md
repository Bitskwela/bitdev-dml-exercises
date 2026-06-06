## Dan's Story: The Rain Remembers

The rain arrived at two in the afternoon — the heavy kind that turns the carinderia's tin roof into a drum section. Tita Malou hadn't even looked at the sky. That morning she had already pulled the sinigang pot to the front burner and told the vegetable suki to double the kangkong. By 2:30, sinigang was the only word the carinderia knew.

Dan had seen this exact scene before — as code. Luto v1, his first program ever: a Python `if/elif` chain that recommended ulam. *If weather == "rainy" → Sinigang na Baboy.* The rules were never really his. They were hers — he had just typed his mom's brain into a file. He opened a terminal, `cargo new ulam_recommender`, and rebuilt the tiniest slice of the old rule engine. Same rules, new language. Python muscle memory got him exactly once (you'll meet that error below), and then:

```text
Recommendation: Sinigang na Baboy — comfort food for a rainy day!
```

> **Tita Malou:** *(reading the screen, slowly)* "Sinigang na Baboy... comfort food for a rainy day."... The computer agrees with me again.
>
> **Dan:** It always did, Ma. Ikaw naman talaga yung nakasulat diyan.

She set a bowl next to his laptop — pork rib, one big chunk of gabi, the good part of the kangkong — and moved on. Outside, the rain kept agreeing with everyone.

---

## The Concept: Branching, the Strict Way

### if / else if / else

```rust
if weather == "rainy" {
    println!("Sinigang day.");
} else if weather == "hot" {
    println!("Halo-Halo day.");
} else {
    println!("Adobo. Walang tanong.");
}
```

Three differences from Python: no parentheses around the condition (rustc even warns if you add them), braces `{ }` are **always** required — even for one-line bodies — and the middle keyword is `else if`, not `elif`. Branches are checked top to bottom, and the **first true condition wins**; everything after it is skipped. Order your rules deliberately: in Luto v1, `rainy` outranked everything because Tita Malou said so.

### Conditions Must Be `bool` — No Truthiness

First, the honest contrast — this is *good*, idiomatic Python. Empty lists, empty strings, `0`, and `None` are all "falsy", and experienced Python hands lean on that every day:

```python
quantity = 3
if quantity:              # idiomatic Python: nonzero is "truthy"
    print("May order!")
```

Rust does not have truthiness. At all:

```rust
let quantity = 3;
if quantity {             // DOES NOT COMPILE
    println!("May order!");
}
```

```text
error[E0308]: mismatched types
 --> src\main.rs:3:8
  |
3 |     if quantity {
  |        ^^^^^^^^ expected `bool`, found integer
```

`if` takes a `bool` — not an integer that implies one, not a string that suggests one. Why so strict? Truthiness is a quiet bug factory: in Python, `if discount:` is false when `discount` is `0`, but a zero-peso discount might be real, deliberate data, not "no discount." Rust refuses to guess which one you meant. The fix costs seven keystrokes and removes the guess forever: `if quantity > 0`.

### `if` Is an Expression — Arms Must Type-Match

Lesson 6's rule — *the last expression of a block, without a semicolon, IS the block's value* — applies to **every block in Rust**, including the arms of an `if`. Which means an `if` can produce a value:

```rust
let price: u32 = if is_payday { 80 } else { 70 };
```

No semicolon after `80` or `70` — a semicolon would turn the value into a statement and the arm would produce nothing. The semicolon after the closing `}` belongs to the `let`. And the `else` is **mandatory** here: if `is_payday` were false with no `else`, `price` would be half-born, and Rust refuses. No more `let mut price = 70;` then overwrite — `price` is born initialized, immutable, and correct.

One catch: `price` is ONE variable with ONE type, so every arm must produce that same type:

```rust
let price = if is_payday { 80 } else { "seventy" };   // DOES NOT COMPILE
// error[E0308]: `if` and `else` have incompatible types
```

The compiler saw `80` first and locked in "this `if` produces an integer"; then `"seventy"` arrived claiming to be a `&str`, and the deal collapsed. On payday the program would hold a number; on regular days, text. No single type fits. Make every arm speak the same type: `80` and `70`, both `u32`, both whole pesos.

### A Bigger Sandok Is Coming

One honest spoiler: when a chain of `else if`s grows past three or four branches, Rust has a sharper tool called `match`, and it does something `if` can't — it forces you to handle **every possible case**, checked at compile time, no forgotten branch ever. It shines brightest with enums, types you build yourself in Lesson 14, so it arrives properly in **Lesson 15**. Today, `if` is the right tool, and mastering it first is what will make `match` feel inevitable.

---

## Key Takeaways

- **`if` / `else if` / `else`** — no parentheses around the condition, braces always required, `else if` instead of `elif`. The first true condition wins, so order branches deliberately.
- **Conditions must be `bool`. No truthiness.** `if quantity` is idiomatic Python and a compile error in Rust — E0308, expected `bool`, found integer. Write `if quantity > 0` and say what you mean.
- **`if` is an expression.** `let price = if is_payday { 80 } else { 70 };` — the arms' last expressions (no semicolon, Lesson 6's rule) become the value, and the `else` is mandatory.
- **All arms must produce the same type.** One variable, one type, no exceptions.
- A more powerful branching tool, **`match`**, arrives in Lesson 15 — with compile-time proof that you handled every case.

---

## What's Next?

Tomorrow Dan stays till closing time, tallying the day's kita — and catches himself typing the same `total = total + ...` for the thirtieth time. Lesson 6 fixed code that repeats *in space*; next lesson is about code that repeats *in time*. And then Kuya JM sends the dare: the same 10-million-iteration sum, Python versus `cargo run --release`. Phone timer. Tonight.

**Next Lesson: Loops** — `loop`, `while`, `for`, ranges — and the speed promise, finally made real.
