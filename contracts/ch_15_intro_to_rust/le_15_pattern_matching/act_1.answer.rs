// ============================================
// PATTERN MATCHING — Full Solution
// Lesson 15 by Dan Santos
// ============================================
// `match`: every payment lands in exactly ONE
// tray — and the compiler checks na walang
// nakakalimutang tray.
// ============================================

// Lesson 14's enum, typo-proof since birth.
// GCash and Maya carry their reference number inside the variant.
enum Payment {
    Cash,
    GCash(String), // e-wallet reference number
    Maya(String),  // e-wallet reference number
    Utang,         // suki credit — nasa lista notebook
}

// One order at the counter. Money in whole pesos (u32), as always.
// `tip` is an Option<u32>: "no tip" is None — absent, not zero.
struct Order {
    amount: u32,
    payment: Payment,
    tip: Option<u32>,
}

// THE LESSON 14 CLIFFHANGER, RESOLVED.
// We match on `&Payment` (a borrow — main still owns every order),
// so the arms bind references: `ref_no` below is a `&String`.
// Rust keeps this natural — just read the value, don't move it out.
//
// Also note: this match is the ENTIRE function body. `match` is an
// expression — every arm produces a String, so the match produces
// a String, so `describe` returns it. No `return` needed.
fn describe(p: &Payment) -> String {
    match p {
        Payment::Cash => String::from("Cash"),
        Payment::GCash(ref_no) => format!("GCash ref {}", ref_no),
        Payment::Maya(ref_no) => format!("Maya ref {}", ref_no),
        Payment::Utang => String::from("Utang (nasa lista)"),
    }
}

// ===== The bodyguard, on demand =====
// Uncomment this function and run `cargo check` to watch
// exhaustiveness checking refuse a missing tray:
//
// fn describe_forgetful(p: &Payment) -> String {
//     match p {
//         Payment::Cash => String::from("Cash"),
//         Payment::GCash(ref_no) => format!("GCash ref {}", ref_no),
//         Payment::Maya(ref_no) => format!("Maya ref {}", ref_no),
//         // Utang arm "forgotten" — error[E0004]: non-exhaustive patterns
//     }
// }

fn main() {
    println!("=== Tita Malou's Payment Sorter ===");
    println!("(money in whole pesos)\n");

    // Saturday's orders. A plain array for now — Vec and friends
    // get their own lesson soon.
    let orders = [
        Order { amount: 80, payment: Payment::Cash, tip: None },
        Order { amount: 150, payment: Payment::GCash(String::from("GC-7741")), tip: Some(20) },
        Order { amount: 95, payment: Payment::Utang, tip: None },
        Order { amount: 210, payment: Payment::Maya(String::from("MY-5529")), tip: None },
        Order { amount: 80, payment: Payment::GCash(String::from("GC-1138")), tip: Some(10) },
        Order { amount: 165, payment: Payment::Cash, tip: None },
    ];

    // Four named counters. Oo, clunky — a HashMap would collapse
    // these into one line, but HashMap arrives in Lesson 17.
    // Tiis muna.
    let mut cash_count: u32 = 0;
    let mut gcash_count: u32 = 0;
    let mut maya_count: u32 = 0;
    let mut utang_count: u32 = 0;

    let mut total_sales: u32 = 0;

    for order in &orders {
        total_sales += order.amount;
        println!("P{:>3} — {}", order.amount, describe(&order.payment));

        // One pattern we care about: Some(tip). None? Skip lang.
        // "match when you care about every case; if let when you
        // care about one."
        if let Some(tip) = order.tip {
            println!("       tip: P{} (salamat, suki!)", tip);
        }

        // Sort the order into its tray. NO `_` arm here, on purpose:
        // kapag may bagong payment method someday, we WANT this
        // match to break the build. That's the bodyguard working.
        match &order.payment {
            Payment::Cash => cash_count += 1,
            Payment::GCash(_) => gcash_count += 1, // _ INSIDE the variant: may laman, di natin kailangan dito
            Payment::Maya(_) => maya_count += 1,
            Payment::Utang => utang_count += 1,
        }
    }

    println!("\n=== Closing trays ===");
    println!("Cash : {} order(s)", cash_count);
    println!("GCash: {} order(s)", gcash_count);
    println!("Maya : {} order(s)", maya_count);
    println!("Utang: {} order(s)", utang_count);
    println!("Total sales: P{}", total_sales);
}
