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
