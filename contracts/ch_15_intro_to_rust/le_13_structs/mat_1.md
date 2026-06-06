## Dan's Story: Fifteen Dishes, Forty-Five Variables

Ten PM, dorm room. Tonight's mission for LutoCLI: digitize Tita Malou's menu board — every dish, every price, every "ubos na" cross-out. Dan started the obvious way, and forty minutes later the obvious way looked like this:

```rust
let adobo_name = String::from("Adobo");
let adobo_price: u32 = 75;
let adobo_available = true;
// ...and the real board has FIFTEEN dishes.
```

Three variables per dish. Fifteen dishes. Forty-five `let` lines before a single feature exists. Dan video-called Kuya JM.

> **Dan:** Kuya, three variables per dish. In Python I'd grab a dict or write a class. What do Rust people do?
>
> **Kuya JM:** Ah, the loose-variable swamp — everyone builds it exactly once. Tingnan mo yung menu board mismo. Your mom writes one line per dish: name, presyo, crossed out pag ubos. She doesn't keep three notebooks. **Group what belongs together.** Every dish IS one thing — so make it ONE type.
>
> **Dan:** My own type? Same level as `u32` and `String`?
>
> **Kuya JM:** Same level, same respect from the compiler. The keyword is `struct`. Define the shape once, stamp out every dish from it.
>
> **Dan:** The `name` field — `String` or `&str`? Yesterday's sticky note says structs own.
>
> **Kuya JM:** Naks, it stuck. `String`. A struct *can* hold a `&str`, pero a borrowed field means explaining to the compiler exactly how long that loan lives — and hindi ka pa ready sa usapang yan. Own muna.

On the whiteboard, Dan drew one box with three labeled shelves: `name`, `price`, `is_available`. *Tonight, the menu board becomes a type.*

---

## The Concept: Structs — Designing Your Own Types

### Defining a Struct

A **struct** bundles related values into one named type that *you* define:

```rust
struct MenuItem {
    name: String,
    price: u32,
    is_available: bool,
}
```

`struct` + a **PascalCase** name creates a brand-new type — `MenuItem` now stands shoulder to shoulder with `u32` and `String`. Each **field** gets a name and a type. And note `name: String`, not `&str` — the Lesson 12 sticky note paying off: **structs own their data.** A struct *can* hold a borrowed `&str`, but then you must tell the compiler how long the borrow lives — that's *lifetimes*, Lesson 22's problem, not tonight's. The definition is a **blueprint**: it costs nothing at runtime and creates no dish; it just teaches the compiler the shape.

### Instantiation and Dot Syntax

To make an actual dish, name the type and give **every** field a value:

```rust
let adobo = MenuItem {
    name: String::from("Adobo"),
    price: 75,
    is_available: true,
};

println!("{} costs P{}", adobo.name, adobo.price);
```

**Every field, every time.** No null, no "I'll fill that in later" — forget a field and the compiler lists exactly which one is missing. An instance is either complete or it doesn't exist. And **dot syntax reads fields:** `adobo.price` is the price of *this specific* adobo, not a loose `adobo_price` floating somewhere hoping you remember whose it is.

### Mutability Is Per-Binding — the Whole Dish or Nothing

There is **no per-field `mut`**. You cannot mark only `price` as changeable. The `mut` goes on the *binding*, exactly like Lesson 4, and covers the entire instance:

```rust
let adobo = MenuItem { /* ... */ };
adobo.price = 80; // error[E0594]: cannot assign to `adobo.price`,
                  // as `adobo` is not declared as mutable
```

The error blames the *binding*, not the field — and the `help:` line hands you the fix at the `let`: `let mut adobo` makes *all three* fields writable; plain `let` seals all three. The whole dish or nothing.

### `impl` — Where Behavior Lives

Data and behavior travel together. An `impl` block attaches functions to your type; a function whose first parameter is `self` in some form is a **method**, called with dot syntax:

```rust
impl MenuItem {
    fn display_line(&self) -> String {       // reads the dish
        format!("{:<20} P{}", self.name, self.price)
    }

    fn apply_discount(&mut self, pct: u32) { // changes the dish
        self.price = self.price * (100 - pct) / 100;
    }
}
```

That first parameter is Lesson 10 wearing a uniform: `&self` is a **shared borrow** of the instance (read-only, many at once allowed); `&mut self` is the **exclusive borrow** (one writer, zero readers). `halo_halo.apply_discount(20)` is sugar for `MenuItem::apply_discount(&mut halo_halo, 20)` — so it only compiles if `halo_halo` is bound with `mut`. The borrow checker doesn't take a night off just because you wrapped the borrow in a method.

### Associated Functions — `::` and the `new` Convention

A function inside `impl` with **no `self` at all** is an **associated function** — it belongs to the type, not to any instance, and you call it with `::`:

```rust
impl MenuItem {
    fn new(name: &str, price: u32) -> MenuItem {
        MenuItem {
            name: name.to_string(), // &str in, owned String stored
            price,                  // field init shorthand for `price: price`
            is_available: true,     // policy: every new dish starts available
        }
    }
}

let adobo = MenuItem::new("Adobo", 75);
```

You've been calling one since the day you met `String::from("Adobo")` — no instance, `::` syntax, makes a value out of nothing. The constructor convention is to name it `new`. Note it takes `&str` but stores `String` — both halves of the Lesson 12 sticky note in five lines: callers lend a cheap `&str`; the struct keeps its own owned copy via `.to_string()`.

### `#[derive(Debug)]` — Free Printing

`println!("{}", adobo)` refuses to compile — `{}` needs *Display* formatting, which Rust won't invent for your type. But the debug format `{:?}` can be **generated for you**:

```rust
#[derive(Debug)]
struct MenuItem { /* ... */ }
```

Now `{:?}` prints the whole struct on one line, and `{:#?}` pretty-prints it with one field per line — perfect for "what is actually inside this thing" moments. Forget the attribute and the compiler's `help:` line literally tells you to add it. And sit with what happened: one attribute, and the compiler *wrote code into your program*. `derive` is deeper than convenience — Lesson 20 opens that box.

---

## Key Takeaways

- **A struct groups what belongs together** into one type you define, with the same standing as `u32`. Instantiation requires *every* field — no nulls, no partially-built dishes — and dot syntax reads them back: `adobo.price`.
- **Struct fields own their data:** `String`, not `&str`. Borrowed fields require lifetimes (Lesson 22). Until then: structs own.
- **Mutability is per-binding, whole instance or nothing.** No per-field `mut`; E0594 points at the `let`, not the field.
- **`impl` attaches behavior.** `&self` = shared borrow (read), `&mut self` = exclusive borrow (write) — methods run on Lesson 10's borrowing rules, no exceptions.
- **Associated functions have no `self` and are called with `::`** — `MenuItem::new` is the constructor convention, and `String::from` was an associated function all along.
- **`#[derive(Debug)]` generates `{:?}` / `{:#?}` printing for free** — an attribute that writes code, a thread that leads to Lesson 20.

---

## What's Next?

The menu board is a type now — and then Tita Malou's payment notebook brought Dan back down. One page, three spellings: **"GCash"**, **"gcash"**, and one mysterious **"Gkash"** from a rushed Saturday. A `String` field will hold *anything you type*, including lies. A price can't be `"Gkash"` because `u32` won't allow it — but a `String` has no opinion at all. Tomorrow, Dan builds a field that has opinions: a type whose *only* possible values are the ones he lists — cash, GCash, wala nang iba — where a typo isn't a bad row in a report, it's a compile error.

**Next Lesson: Enums** — types with a fixed set of possible values, why "make invalid states unrepresentable" is the most Rust sentence ever written, and the day the payment notebook learns to stop lying.
