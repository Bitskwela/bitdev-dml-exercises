// ============================================
// TRAITS — Lesson 20
// by: <Your Name>
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
    // Required: every signer MUST write this one.
    // No body here — the body is the signer's problem.
    fn summary(&self) -> String;

    // TODO (Task 1): make this a real DEFAULT method — every signer
    // gets it for FREE. Replace todo!() with:
    //   format!("[REPORT] {}", self.summary())
    // Note: a default method can call a required one.
    fn short_label(&self) -> String {
        todo!()
    }
}

// ===== Each type signs the contract =====

impl Summarize for MenuItem {
    fn summary(&self) -> String {
        // TODO (Task 2): return the menu line, e.g. "Adobo — ₱75":
        //   format!("{} — ₱{}", self.name, self.price)
        todo!()
    }
    // no short_label here — the default serves this type
}

impl Summarize for DailySales {
    fn summary(&self) -> String {
        // TODO (Task 2): return "{date}: ₱{total} kita, top dish: {top_dish}"
        // using self.date, self.total, self.top_dish
        todo!()
    }
    // no short_label here either — same free default
}

// ===== ONE function, ANY Summarize (the trait bound) =====

fn print_summary(item: &impl Summarize) {
    // TODO (Task 3): print the bullet line:
    //   println!("• {}", item.summary());
    // Inside this function only the CONTRACT exists — item.summary()
    // compiles; item.price would not, even for a MenuItem.
    todo!()
}

// ===== Display: the std trait that unlocks {} =====

impl fmt::Display for MenuItem {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        // TODO (Task 4): write!(f, "{} — ₱{}", self.name, self.price)
        // write! writes into `f` and produces the fmt::Result this
        // signature demands — leave it as the LAST expression, no semicolon.
        todo!()
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
    // TODO (Task 3): uncomment — `tuesday` goes through the SAME function.
    // print_summary(&tuesday);

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
