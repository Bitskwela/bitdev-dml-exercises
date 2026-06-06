// ============================================
// TRAITS — Full Solution
// Lesson 20 by Dan Santos
// ============================================
// A trait says WHAT you can do, not WHAT you
// are — one sandok, many ulam.
// ============================================

use std::fmt;

// ===== The two record types (the "ulam") =====

// Debug, Clone, PartialEq — all three are TRAITS.
// `#[derive]` asks the compiler to write the impl blocks.
#[derive(Debug, Clone, PartialEq)]
struct MenuItem {
    name: String,
    price: u32, // whole pesos, as always
}

#[derive(Debug)]
struct DailySales {
    date: String,
    total: u32,
    top_dish: String,
}

// ===== The contract (the "sandok") =====

trait Summarize {
    // Required: every implementor MUST write this one.
    fn summary(&self) -> String;

    // Default: implementors get this for FREE.
    // Note: a default method can call a required one.
    fn short_label(&self) -> String {
        format!("[REPORT] {}", self.summary())
    }
}

// ===== Each type signs the contract =====

impl Summarize for MenuItem {
    fn summary(&self) -> String {
        format!("{} — ₱{}", self.name, self.price)
    }
    // no short_label here — the default serves this type
}

impl Summarize for DailySales {
    fn summary(&self) -> String {
        format!(
            "{}: ₱{} kita, top dish: {}",
            self.date, self.total, self.top_dish
        )
    }
    // no short_label here either — same free default
}

// ===== ONE function, ANY Summarize (the trait bound) =====

fn print_summary(item: &impl Summarize) {
    println!("• {}", item.summary());
}

// ===== Display: the std trait that unlocks {} =====

impl fmt::Display for MenuItem {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{} — ₱{}", self.name, self.price)
    }
}

fn main() {
    println!("=== Isang Sandok: one trait, many types ===\n");

    let adobo = MenuItem {
        name: String::from("Adobo"),
        price: 75,
    };
    let tuesday = DailySales {
        date: String::from("2026-06-02"),
        total: 4870,
        top_dish: String::from("Sinigang na Baboy"),
    };

    // ===== Part 1: one sandok serves both ulam =====
    print_summary(&adobo);
    print_summary(&tuesday);

    // ===== Part 2: the free default method =====
    println!("\n{}", adobo.short_label());
    println!("{}", tuesday.short_label());

    // ===== Part 3: derives ARE traits (the L13 box, opened) =====
    let adobo_copy = adobo.clone(); // Clone trait, derived
    println!("\nDebug view:  {:?}", adobo); // Debug trait, derived
    println!("Same dish?   {}", adobo == adobo_copy); // PartialEq trait, derived

    // ===== Part 4: Display makes {} just work =====
    println!("\nMenu board:  {}", adobo); // no {:?}, no .summary() — Display
}
