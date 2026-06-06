## Dan's Story: Whiteboard Night

Nine-forty PM, carinderia closed, chairs up on the tables. Dan held his markered-up delivery box to the camera and Kuya JM redrew it on a shared canvas, properly this time — the LutoCLI roadmap:

```text
[1] READ SALES  ->  [2] TALLY PER DISH  ->  [3] SUMMARIZE        ->  [4] RUN ANYWHERE
    (sales file)        (per ulam)             (kita, top seller)        (one binary, USB)
```

> **Kuya JM:** Apat na bricks, one at a time — and we don't start with brick one. Files come later; for now we fake it with hardcoded data. Tonight's question: while LutoCLI is running, where does a whole lunch rush *live*?
>
> **Dan:** Python Dan says: a list for the sales, a dict for the tally. Five minutes.
>
> **Kuya JM:** Rust says: `Vec` for the sales, `HashMap` for the tally. Same idea — pero with the ownership rules you spent all of Act 2 paying for.

JM drew two pictures. The **order spike** by the counter — slips stabbed in arrival order, growing all rush. That's a `Vec`. The **chalk tally board** — dish names, marks beside each, "ilan na ang Adobo?" answered instantly. That's a `HashMap`. Dan typed a quick prototype, looped `for dish in sales`, asked for `sales.len()` afterward — and got E0382: *borrow of moved value*. The bare loop had **eaten** his Vec.

> **Kuya JM:** The fix is one character — `&sales`. "Tingin lang, hindi kukunin." Now the tally board — one line of Rust na tina-type ko sa trabaho almost daily. By tonight you'll know it from memory:

```rust
*tally.entry(dish.clone()).or_insert(0) += 1;
```

---

## The Concept: `Vec<T>` and `HashMap<K, V>`

### `Vec<T>` — the Order Spike

A growable list where every element has the same type `T`, stored in order. Growth *changes* the Vec, so: no `mut`, no push.

```rust
let mut sales: Vec<String> = Vec::new();   // empty, type stated
sales.push(String::from("Adobo"));         // legal only because of `mut`
let menu = vec!["Adobo", "Tinola"];        // the vec! macro, with starters
```

Two ways to loop — one of them eats the Vec. A bare `for dish in sales` implicitly calls `.into_iter()` and **moves** the whole Vec into the loop; `for dish in &sales` borrows it instead, and the Vec is still usable afterward. Default to the `&`.

Two ways to read by index, too: `sales[0]` works — and `sales[100]` **panics** with "index out of bounds." That's a crash, the exact thing this course exists to keep away from Tita Malou. The safe way is `.get(i)`, which returns `Option<&T>`:

```rust
match sales.get(100) {
    Some(dish) => println!("Order #101: {dish}"),
    None => println!("Order #101: wala."),   // a handled value, not a crash
}
```

### `HashMap<K, V>` — the Tally Board

Maps keys to values — dish name to count, dish name to price. One ceremony: unlike `Vec` and `String`, `HashMap` is not in the prelude, so every file that uses it starts with `use std::collections::HashMap;`. And the same safety split as Vec applies: `.get(&key)` answers with an `Option`; `menu[&key]` square brackets panic on a missing key.

```rust
let mut menu: HashMap<String, u32> = HashMap::new();
menu.insert(String::from("Adobo"), 75);
let price = menu.get("Adobo");   // Option<&u32> — match it, like always
```

Same safety split as Vec: `.get(&key)` answers with an `Option`; `menu[&key]` square brackets panic on a missing key. You know the rule by now.

### `entry().or_insert(0)` — THE LutoCLI Idiom

Counting with `.get()` + `.insert()` means two lookups and an awkward dance. The `entry` API does it in one motion:

```rust
let mut tally: HashMap<String, u32> = HashMap::new();
for dish in &sales {
    *tally.entry(dish.clone()).or_insert(0) += 1;
}
```

Read it left to right: **`.entry(key)`** gets the slot for this key, occupied or not; **`.or_insert(0)`** puts a `0` in if vacant, and either way hands back a mutable reference (`&mut u32`) to whatever's in the slot; **`*... += 1`** follows that reference and bumps the count. First "Adobo" of the day: vacant, becomes 0, bumped to 1. Fifth: has 4, bumped to 5. Tally by dish, revenue by dish, orders by hour — in LutoCLI, they are all this line wearing different clothes. Memorize it cold.

### Inserting a `String` Moves It

When you `.insert()` a `String`, the map takes ownership — the cash-drawer-key rule applies to keys too:

```rust
let dish = String::from("Halo-Halo");
menu.insert(dish, 60);
println!("{dish}");   // E0382: borrow of moved value — the map owns it now
```

This is why the tally idiom says `dish.clone()`: inside `for dish in &sales` you only *borrowed* each String from the Vec, and you can't hand the map something you don't own. So you hand it a copy. (The `u32` values are `Copy` — small numbers just duplicate, no drama.)

### Unordered, On Purpose

**HashMaps have no order.** Print one directly and the entries come out shuffled — and shuffled *differently* on the next run. Not a bug; that's how hash maps buy their instant lookups. To *display* a tally, collect the pairs into a Vec — which does have order — and sort it yourself:

```rust
let mut leaderboard: Vec<(&String, &u32)> = tally.iter().collect();
leaderboard.sort_by(|a, b| b.1.cmp(a.1));   // b vs a = DESCENDING by count
```

Map for tallying, Vec for displaying: that division of labor is permanent.

---

## Key Takeaways

- **`Vec<T>` is the growable, ordered list** — `Vec::new()` or `vec![...]`, `.push()` to grow (needs `mut`), `.len()` to count.
- **A bare `for x in v` MOVES the Vec** via an implicit `.into_iter()`. `for x in &v` borrows — default to the `&`.
- **`v[i]` panics out of bounds; `.get(i)` returns `Option<&T>`.** Same rule for HashMap lookups.
- **`*map.entry(key).or_insert(0) += 1;` is THE tally idiom** — slot, default-if-vacant, bump through the `&mut`. Type it until your fingers know it.
- **Maps own their keys.** Inserting a `String` moves it in — tallying from borrowed data needs `.clone()`.
- **HashMaps are unordered, on purpose.** Tally in the map, display from a sorted Vec.

---

## What's Next?

Dan pushed the tally board to the call and JM drew a fat check mark over brick two of the roadmap. Then Dan scrolled to the top of `main.rs` to admire the whole thing — and kept scrolling. Two hundred lines, one file, one `main()` doing six different jobs. Tita Malou's kitchen doesn't work like that: the rice station doesn't chop meat, the prep table doesn't take payments. Tomorrow, Dan's code gets stations.

**Next Lesson: Modules** — `mod`, `pub`, and `use`; splitting one bloated `main.rs` into rooms with doors; and deciding what each room shows the public versus what stays kitchen-only.
