// ============================================
// PATTERN MATCHING — Lesson 15
// by: <Your Name>
// ============================================
// `match`: every payment lands in exactly ONE
// tray — and the compiler checks na walang
// nakakalimutang tray.
//   Task 1: describe() — open the variants, free the ref numbers
//   Task 2: the tally  — one arm per method, NO `_` catch-all
//   Task 3: the tip    — `if let` for the one pattern that matters
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

// THE LESSON 14 CLIFFHANGER. We match on `&Payment` (a borrow — main
// still owns every order), so the arms bind references: `ref_no` is
// a `&String`. Read it, print it — just don't move it out.
//
// Cash and GCash are done. The last two arms are `todo!()` — that
// compiles fine, but it PANICS if the arm actually runs, and the
// Utang order at the counter WILL find it. Replace both before
// `cargo run`.
fn describe(p: &Payment) -> String {
    match p {
        Payment::Cash => String::from("Cash"),
        Payment::GCash(ref_no) => format!("GCash ref {}", ref_no),
        // TODO (Task 1): mirror the GCash arm — change `_` to `ref_no`
        // to bind the reference number, then format!("Maya ref {}", ref_no).
        Payment::Maya(_) => todo!(),
        // TODO (Task 1): Utang carries no data — return
        // String::from("Utang (nasa lista)").
        Payment::Utang => todo!(),
    }
}

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

        // TODO (Task 3): one pattern we care about: Some(tip).
        // None? Skip lang. Write an `if let Some(tip) = order.tip`
        // that prints:
        //     "       tip: P{} (salamat, suki!)"
        // "match when you care about every case; if let when you
        // care about one."

        // TODO (Task 2): sort the order into its tray. Write a
        // `match &order.payment` with one arm per variant, each
        // incrementing its counter (cash_count, gcash_count,
        // maya_count, utang_count). Use `_` INSIDE a variant when
        // you don't need the ref number — Payment::GCash(_) — but
        // NO bare `_` catch-all arm. On purpose: kapag may bagong
        // payment method someday, we WANT this match to break the
        // build. That's the bodyguard working.
    }

    println!("\n=== Closing trays ===");
    println!("Cash : {} order(s)", cash_count);
    println!("GCash: {} order(s)", gcash_count);
    println!("Maya : {} order(s)", maya_count);
    println!("Utang: {} order(s)", utang_count);
    println!("Total sales: P{}", total_sales);
}
