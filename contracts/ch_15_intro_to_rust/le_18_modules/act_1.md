# Give the Kitchen Its Stations

Take Lesson 17's lunch-rush tally and give it the kitchen it deserves: two stations and one thin cashier. One twist before you start: the lesson teaches the three-file refactor, but this activity ships as **one file**, because the exercise runner compiles a single `act_1.rs`. So the starter uses the **inline form** — `mod menu { ... }` and `mod sales { ... }` as brace blocks inside one file. To the compiler it is the *same module tree*, the same privacy rules, the same E0603. On your own machine, the equivalent multi-file layout this lesson teaches is:

```text
lutocli_refactor/
├── Cargo.toml
└── src/
    ├── main.rs     <- `mod menu;` + `mod sales;` + the cashier code in main()
    ├── menu.rs     <- everything inside `mod menu { ... }`, minus the braces
    └── sales.rs    <- everything inside `mod sales { ... }`, minus the braces
```

`mod menu { ... }` inline and `mod menu;` + `src/menu.rs` declare the *same* station — `crate::menu::build_menu` is the address either way. Open `act_1.rs` and work the TODOs in order.

## Task 1: Stock the Prep Station — `build_menu`

Inside `mod menu`, implement `pub fn build_menu() -> Vec<MenuItem>` returning the four dishes: Adobo 75, Sinigang na Baboy 95, Tapsilog 95, Halo-Halo 60. The `MenuItem` struct is given — notice the type *and each field* carry their own `pub`, because fields are private by default too.

## Task 2: The Tally Station — `tally`

Inside `mod sales`, implement `pub fn tally(sales: &[String]) -> HashMap<String, u32>` — Lesson 17's `entry().or_insert(0)` idiom, byte-for-byte, just living at a new address. Note that `mod sales` does its *own* `use std::collections::HashMap;` — imports never leak between modules.

## Task 3: Rank It — `leaderboard` Uses the Private Helper

Implement `pub fn leaderboard(counts: &HashMap<String, u32>) -> String`: collect into a `Vec<(&String, &u32)>`, sort by count (biggest first, ties by name), start the board with the `=== Sabado Lunch Rush: Leaderboard ===` header line, then build each row with `format_row(rank, dish, *count)`. `format_row` has no `pub` — but `leaderboard` lives at the same station, so no key is needed.

## Task 4: The Cashier Delegates

In `main`, uncomment the Station 2 block: tally the rush, print the leaderboard, then compute total revenue using prices from the menu station and counts from the tally station. `main` stays thin — it asks stations, it doesn't cook.

Then the privacy experiment: uncomment the `sales::format_row(1, "Adobo", 4)` line at the bottom and run `cargo check`. Read the E0603 ritual-style — which function does the headline name, where does the `note:` say it lives? Re-comment it and go green again.

## Sample Output

```text
=== LutoCLI (dev build) — refactor weekend ===

Menu (4 items):
  Adobo              ₱ 75
  Sinigang na Baboy  ₱ 95
  Tapsilog           ₱ 95
  Halo-Halo          ₱ 60

=== Sabado Lunch Rush: Leaderboard ===
1. Sinigang na Baboy  x5
2. Adobo              x4
3. Halo-Halo          x3
4. Tapsilog           x2

Total kita: ₱1145
```

## Reflection Questions

1. `leaderboard` calls `format_row` with no ceremony, but the exact same call from `main` is error E0603. Nothing about the function changed — only the address of the caller. Why is "which module are you standing in" the thing Rust checks, and what does that buy Dan when he rewrites `format_row` next month?
2. Suppose you lift the contents of `mod sales { ... }` into `src/sales.rs` and replace the block with `mod sales;`. What changes in `main`'s `use crate::sales::...` lines? (Hint: nothing. Why does the `crate::` absolute path survive the move?)
3. The compiler never reads a file that no `mod` line declares. How is that different from Python's "any `.py` in the folder is importable" — and which failure mode does Rust's rule prevent?

## Challenge: The Re-Export Shortcut

Sometimes a tidy module tree produces an ugly path. Paste this at the bottom of the `mod menu { ... }` block:

```rust
pub mod specials {
    pub fn weekend_special() -> String {
        String::from("Kare-Kare — Sabado lang, habang may laman ang kaldero")
    }
}
```

Calling it works, but look at this hallway of a `use` line:

```rust
use crate::menu::specials::weekend_special;
```

Flatten it with a **re-export**. Add one line inside `mod menu`, after the `specials` block:

```rust
pub use specials::weekend_special;
```

`pub use` means *import it, then hand it out as if it were mine* — `menu` puts the deep item on its own front counter. Now `main` shortens to:

```rust
use crate::menu::weekend_special;
```

Verify both versions compile and print the same Kare-Kare announcement. This is how real Rust libraries curate their public face: deep module trees inside, short friendly paths at the counter — it's why `HashMap` lives at `std::collections::HashMap` instead of some six-segment internal path.

## What You've Learned

- `mod menu { ... }` inline and `mod menu;` + `src/menu.rs` build the same module tree — the inline form is the whole multi-file refactor, minus the file boundaries
- Everything in a module is private by default; `pub` opts in item by item, and E0603 is the locked drawer answering an illegal reach
- `use crate::menu::build_menu;` says the absolute address once so the short name works afterwards — and survives moving the module to its own file
- A private helper (`format_row`) is callable by its station-mates and invisible to everyone else — privacy as a design tool, not paperwork
- `pub use` re-exports a deep item onto a module's own counter, flattening ugly paths
