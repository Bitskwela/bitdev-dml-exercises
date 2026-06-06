# Extract lutolib

Dan's peso math is about to serve every Luto tool from now on — which means today's real exercise is a *layout*, not a function. You'll build two sibling crates joined by one line of `Cargo.toml`, exactly like Kuya JM's `pesocore`. The `act_1.rs` in this folder is the **single-file practice version**: library functions and `main` sharing one file so it runs anywhere, with a comment block sketching where each half lives in the real thing. Build the two-crate layout on your own machine, then make the practice file print the same summary.

## Task 1: Create the Two Crates

Make a parent folder so the crates can live as siblings — note the `--lib` flag on the first one:

```powershell
mkdir luto-tools
cd luto-tools
cargo new lutolib --lib
cargo new kita-checker
```

Cargo announces each one differently:

```text
    Creating library `lutolib` package
    Creating binary (application) `kita-checker` package
```

```text
luto-tools/
├── lutolib/             <- library crate: the shared recipe book
│   ├── Cargo.toml
│   └── src/
│       └── lib.rs       <- no main.rs here. Nothing to run.
└── kita-checker/        <- binary crate: today's tool
    ├── Cargo.toml
    └── src/
        └── main.rs
```

Peek inside the generated `lib.rs`: cargo seeds every new library with a sample `add` function and a ready-made unit test — libraries are born expecting to be tested. Delete the sample; we have real recipes to shelve.

## Task 2: Stock the Library

Replace `lutolib/src/lib.rs` with the two recipes every Luto tool will borrow. The `///` lines are **doc comments** — `cargo doc --open` compiles them into a browsable HTML manual:

```rust
/// Formats an amount in centavos as a peso string.
/// Example: 123450 centavos -> "₱1,234.50"
pub fn format_peso(centavos: u64) -> String {
    let pesos = centavos / 100;
    let cents = centavos % 100;

    // Group the peso digits in threes: 7470 -> "7,470"
    let digits = pesos.to_string();
    let mut grouped = String::new();
    for (i, digit) in digits.chars().enumerate() {
        if i > 0 && (digits.len() - i) % 3 == 0 {
            grouped.push(',');
        }
        grouped.push(digit);
    }

    format!("₱{grouped}.{cents:02}")
}

/// Applies the 20% senior citizen discount to a whole-peso total.
/// Integer math, same as the counter: 175 -> 140.
pub fn senior_discount(total: u32) -> u32 {
    total * 80 / 100
}
```

## Task 3: Wire the Path Dependency

Open `kita-checker/Cargo.toml` and add the one line that is today's entire lesson:

```toml
[package]
name = "kita-checker"
version = "0.1.0"
edition = "2024"

[dependencies]
lutolib = { path = "../lutolib" }
```

(If your cargo generated `edition = "2021"`, keep it.) The line says: *the crate named `lutolib` lives one folder up and over — go compile it yourself.* No registry, no download, no internet.

## Task 4: Borrow It

Replace `kita-checker/src/main.rs` — the dependency lives in `Cargo.toml`; the code only has to say `use`:

```rust
use lutolib::{format_peso, senior_discount};

fn main() {
    println!("=== Kita Checker — Daily Summary ===");
    println!("(money math by lutolib v0.1.0)\n");

    // (dish, plates sold, price per plate in whole pesos)
    let sales: [(&str, u32, u32); 4] = [
        ("Adobo", 32, 85),
        ("Sinigang na Baboy", 21, 90),
        ("Menudo", 17, 80),
        ("Tortang Talong", 25, 60),
    ];

    let mut gross: u32 = 0;
    for (dish, plates, price) in sales {
        let subtotal = plates * price;
        gross += subtotal;
        println!(
            "{dish:<18} {plates:>3} plates x {:>7} = {:>10}",
            format_peso(price as u64 * 100),
            format_peso(subtotal as u64 * 100),
        );
    }

    println!("{:-<52}", "");
    println!("Gross kita:        {}", format_peso(gross as u64 * 100));

    // One senior order at the counter — the discount math now
    // lives in ONE place, not copy-pasted into every tool.
    let senior_order: u32 = 175;
    let senior_pays = senior_discount(senior_order);
    println!(
        "\nSenior order:      {} -> {} after 20% discount",
        format_peso(senior_order as u64 * 100),
        format_peso(senior_pays as u64 * 100),
    );
}
```

Run from inside the *binary* crate — the library has nothing to run:

```powershell
cd kita-checker
cargo run
```

Watch the first two `Compiling` lines: you typed `cargo run` once, yet cargo compiled `lutolib` *first*, unprompted. It read the `[dependencies]` line, walked to the sibling folder, and built your library before the binary that needs it. That ordering is the dependency mechanism working.

## Task 5: The Single-File Practice Version

Open `act_1.rs` in this folder. The two `todo!()` functions are the lutolib half; `main` is the kita-checker half. Implement `format_peso` and `senior_discount`, then uncomment the marked `println!` lines in `main` (and delete the placeholder `let _ =` lines) until the summary below prints.

## Sample Output

```text
=== Kita Checker — Daily Summary ===
(money math by lutolib v0.1.0)

Adobo               32 plates x  ₱85.00 =  ₱2,720.00
Sinigang na Baboy   21 plates x  ₱90.00 =  ₱1,890.00
Menudo              17 plates x  ₱80.00 =  ₱1,360.00
Tortang Talong      25 plates x  ₱60.00 =  ₱1,500.00
----------------------------------------------------
Gross kita:        ₱7,470.00

Senior order:      ₱175.00 -> ₱140.00 after 20% discount
```

(If your terminal prints a strange symbol where `₱` should be, that's your terminal's font or encoding being old-fashioned — the code is fine.)

## Reflection Questions

1. You typed `cargo run` once, inside `kita-checker` — yet two `Compiling` lines appeared, library first. What did cargo read to know it had to build `lutolib` at all, and why in that order?
2. The dependency line `lutolib = { path = "../lutolib" }` names the *crate*, not any function. What does that imply about what `kita-checker` has to do when the library grows a new `pub fn`?
3. Money stays `u32` whole pesos everywhere business logic lives; centavos exist only as `u64` *inside* `format_peso`, at the display boundary. Why is the library the right place to bury that conversion, now that more than one tool will print pesos?

## Challenge: The Quincena Function

Every 15th and 30th, the lunch crowd doubles and Tita Malou's prices tick up. Add this to `lutolib/src/lib.rs` — doc comment included; it's a library now, and libraries explain themselves:

```rust
/// Adds the 15% quincena markup to a whole-peso base price.
/// Example: 80 -> 92.
pub fn payday_price(base: u32) -> u32 {
    base * 115 / 100
}
```

Then call it from `kita-checker` — extend the `use` line and append to `main`:

```rust
use lutolib::{format_peso, payday_price, senior_discount};
```

```rust
    // Challenge
    let base: u32 = 85;
    println!(
        "\nQuincena price:    {} -> {} on the 15th",
        format_peso(base as u64 * 100),
        format_peso(payday_price(base) as u64 * 100),
    );
```

`cargo run` from `kita-checker` should now end with `Quincena price:    ₱85.00 -> ₱97.00 on the 15th`. Now the actual point of this challenge: **look at `kita-checker/Cargo.toml`. You didn't touch it.** The dependency line doesn't name functions — it names the crate. Every `pub` item the library has, or will ever grow, is already covered. You stocked the commissary, and every stall that buys from it got the new sauce automatically. (Mirror the same function and print in `act_1.rs` to keep the practice file in step.)

## What You've Learned

- `cargo new --lib` creates a library crate: `src/lib.rs`, no `main`, nothing to run — just `pub` recipes waiting to be borrowed
- One path-dependency line in `Cargo.toml` is the entire relationship; cargo builds the library first, automatically, with zero network
- `///` doc comments make a library self-explaining — `cargo doc --open` renders them into HTML
- A new `pub fn` in the library reaches every dependent with no manifest change — the dependency names the crate, not the functions
