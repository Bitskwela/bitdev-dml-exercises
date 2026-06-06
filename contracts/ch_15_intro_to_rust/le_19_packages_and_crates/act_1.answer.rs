// ============================================
// PACKAGES & CRATES — Full Solution
// Lesson 19 by Dan Santos
// ============================================
// SINGLE-FILE PRACTICE VERSION. In the real
// two-crate layout these halves live apart:
//
//   luto-tools/
//   ├── lutolib/             <- library crate (cargo new lutolib --lib)
//   │   ├── Cargo.toml
//   │   └── src/
//   │       └── lib.rs       <- format_peso + senior_discount live here
//   └── kita-checker/        <- binary crate (cargo new kita-checker)
//       ├── Cargo.toml       <- [dependencies] lutolib = { path = "../lutolib" }
//       └── src/
//           └── main.rs      <- use lutolib::{format_peso, senior_discount};
//
// One dependency line, and cargo compiles the
// library first — unprompted — every time.
// ============================================

// ---------- the lutolib half ----------
// In the two-crate layout, everything in this
// section is lutolib/src/lib.rs.

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

// ---------- the kita-checker half ----------
// In the two-crate layout, main() is
// kita-checker/src/main.rs, and the borrow is
// explicit: use lutolib::{format_peso, senior_discount};

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
