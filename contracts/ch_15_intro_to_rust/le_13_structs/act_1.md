# Digitize the Menu Board Properly

Tita Malou's board as a type: one `MenuItem` struct, a constructor, a read method, a write method — and the loose-variable swamp drained for good. Open `act_1.rs` and work through the TODOs in order. The starter compiles and runs as shipped: it builds one dish the long way (a struct literal) so you have something on screen before writing a single method.

## Task 1: Meet the Blueprint

`MenuItem` is already defined at the top — `#[derive(Debug)]`, then three fields: `name: String` (owned — the Lesson 12 rule: structs own `String`, never `&str` without lifetimes), `price: u32` (whole pesos), `is_available: bool`. Read it, run `cargo run`, and note that the struct-literal demo spells out *every* field — no nulls, no "fill it in later."

## Task 2: `MenuItem::new` — the Constructor

Implement the associated function (no `self` — called with `::`, like `String::from`). Take `&str` in (functions take `&str`), store an owned `String` via `.to_string()` (structs own `String`), use field init shorthand for `price`, and set the policy: every new dish starts `is_available: true`.

## Task 3: `display_line(&self)` — Read the Dish

`&self` is a shared borrow — read-only, Lesson 10 rules. If the dish is available, return `format!("{:<20} P{}", self.name, self.price)` — `{:<20}` left-aligns the name in 20 columns so the board lines up. Otherwise return the name followed by `UBOS NA`.

## Task 4: `apply_discount(&mut self, pct: u32)` — Change the Dish

`&mut self` is the exclusive borrow — one writer, zero readers, only callable on a `mut` binding. Integer math only: `self.price = self.price * (100 - pct) / 100`. Multiply first, divide second; no floats anywhere near money.

## Task 5: Wire Up `main`

Uncomment the marked lines in order: build the three dishes with `MenuItem::new` (Adobo 75, Sinigang na Baboy 95, Halo-Halo 60 — note only `halo_halo` gets `mut`), print the most expensive ulam via dot syntax, apply the 20% merienda discount to halo-halo, print the board with three `display_line` calls, and finish with the `{:#?}` X-ray. Then delete the Lumpiang Shanghai demo — your constructor has replaced it.

## Sample Output

```
=== Tita Malou's Menu Board v1 ===

Most expensive ulam today: Sinigang na Baboy at P95
Merienda promo! Halo-Halo is now P48

----------- MENU -----------
Adobo                P75
Sinigang na Baboy    P95
Halo-Halo            P48

[debug view of one dish]
MenuItem {
    name: "Halo-Halo",
    price: 48,
    is_available: true,
}
```

₱60 minus 20% is ₱48 — clean integer math. And that pretty-printed dump at the end was written by code you never wrote: `derive(Debug)` earning its one line.

## Reflection Questions

1. `adobo` is bound without `mut`, so even `adobo.price = 80` is error E0594 — the compiler blames the *binding*, not the field. Why does Rust put `mut` on the binding instead of on individual fields?
2. `halo_halo.apply_discount(20)` is sugar for `MenuItem::apply_discount(&mut halo_halo, 20)`. Which Lesson 10 rule decides whether that call compiles, and what would break it?
3. `new` takes `&str` but stores `String`. What problem would a `name: &str` field create for a struct that's supposed to outlive the function that built it?

## Challenge: The Special That Stole a Field

First, a quick upgrade: add a fourth field `category: String` to `MenuItem`, give `new` a third parameter `category: &str`, and store it owned — same trick as `name`. Rebuild the dishes: adobo and sinigang are `"ulam"`, halo-halo is `"merienda"`.

At closing time, Tita Malou announces a Sinigang Special — bigger cut of baboy, ₱120, same category and availability as the regular sinigang, so don't retype those. Rust has **struct-update syntax** for exactly this:

```rust
let sinigang = MenuItem::new("Sinigang na Baboy", 95, "ulam");

let sinigang_special = MenuItem {
    name: String::from("Sinigang Special"),
    price: 120,
    ..sinigang // every field you DIDN'T list comes from here
};
```

Now the actual challenge. Add these three lines after the special, **predict each one before running**, then `cargo check`:

```rust
println!("{}", sinigang.price);    // prediction?
println!("{}", sinigang.name);     // prediction?
// println!("{}", sinigang.category);  // error[E0382]: borrow of moved value: `sinigang.category`
```

Leave the broken line commented out and write a comment in your code explaining all three results. Your explanation should land on these points:

- `..sinigang` had to supply two fields: `is_available` and `category`. The `category` is a `String` — not `Copy` — so it **moved** out of `sinigang` into the special, exactly like Lesson 9's `let s2 = s1;`. That field of `sinigang` is now gone. E0382 — Lesson 9's old enemy, back in struct clothing.
- `sinigang.price` still works because `u32` **is** `Copy` — `..` copied it, and copies leave the original intact.
- The twist: `sinigang.name` *also* still works — you listed `name` explicitly, so `..` never touched it. Only the fields that `..` actually supplies can move.
- Brain-twister for the end of your comment: on the original *three-field* struct, this exact code compiles with zero errors. Why? (Hint: what's the only field `..sinigang` would supply there, and is it `Copy`?)

## What You've Learned

- One dish = one `MenuItem` — a struct groups what belongs together into a type you define, instantiated with every field, read back with dot syntax
- Methods run on borrowing rules: `&self` is the shared borrow (read), `&mut self` is the exclusive borrow (write) — and `&mut self` methods need a `mut` binding
- `MenuItem::new` — an associated function (no `self`, called with `::`): `&str` in, owned `String` stored, policy defaults set in one place
- `#[derive(Debug)]` buys `{:?}` and `{:#?}` for free, and struct-update `..base` moves any non-`Copy` field it supplies
