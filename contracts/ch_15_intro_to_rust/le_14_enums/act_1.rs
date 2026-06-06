// ============================================
// ENUMS — Lesson 14
// by: <Your Name>
// ============================================
// An enum is the turo-turo tray rule: a value
// can only be one of the trays that EXIST.
// Walang 'Gkash' tray.
// ============================================

#[derive(Debug)]
enum Payment {
    Cash, // no extra data needed
    // TODO 1: add the two data-carrying variants —
    //   GCash(String), // the reference number rides INSIDE the variant
    //   Maya(String),  // same idea, different wallet
    Utang, // the notebook remembers
}

// TODO 2: enums get impl blocks too — same move as MenuItem::new.
// Write an `impl Payment` block with two constructor helpers that
// turn a &str into the owned String the variant wants:
//   fn gcash(reference: &str) -> Payment { Payment::GCash(String::from(reference)) }
//   fn maya(reference: &str) -> Payment  { Payment::Maya(String::from(reference)) }

#[derive(Debug)]
struct Order {
    dish: String,
    total: u32,       // whole pesos, as always
    payment: Payment, // an enum, living inside a struct
    // TODO 3: add the tip field — maybe a tip, maybe none.
    // Absence is a TYPE, not a null:
    //   tip: Option<u32>,
}

fn main() {
    println!("=== Tita Malou's Payment Drawer ===");
    println!("(money in whole pesos)\n");

    // ===== Part 1: three orders, three ways to pay =====
    // TODO 4: once TODOs 1-3 are done, finish these orders:
    //   breakfast — tip: Some(5)  (the jeepney driver said "keep the change")
    //   lunch     — payment: Payment::gcash("REF-2384-001"), tip: None
    //   merienda  — tip: None
    // (No tip is None — and the program does NOT explode.)
    let breakfast = Order {
        dish: String::from("Tapsilog"),
        total: 95,
        payment: Payment::Cash,
    };

    let lunch = Order {
        dish: String::from("Sinigang na Baboy"),
        total: 120,
        payment: Payment::Cash, // <- switch to the gcash helper from TODO 2
    };

    let merienda = Order {
        dish: String::from("Lechon Kawali"),
        total: 150,
        payment: Payment::Utang, // Aling Nena, suki for ten years
    };

    // ===== Part 2: {:?} shows the whole drawer =====
    println!("{:?}", breakfast);
    println!("{:?}", lunch);
    println!("{:?}", merienda);

    // One stray payment, no full order: the Zumba instructor's
    // halo-halo to-go, paid via Maya. Un-comment once TODO 2 exists:
    // let stray = Payment::maya("MAYA-7745-002");
    // println!("Stray payment (halo-halo to-go): {:?}", stray);

    // ===== Part 3: the closing tally =====
    let sales_total = breakfast.total + lunch.total + merienda.total;
    println!("\nSales recorded:  P{}", sales_total);

    // TODO 5: tally the tip jar with `.unwrap_or(0)` — it reads as:
    // "if there's a tip inside, take it; if it's None, use 0."
    // No crash, no null, no drama. Expected: P5.
    //   let tip_total =
    //       breakfast.tip.unwrap_or(0) + lunch.tip.unwrap_or(0) + merienda.tip.unwrap_or(0);
    let tip_total: u32 = 0; // <- replace with the real tally
    println!("Tip jar tonight: P{}", tip_total);

    // ===== Part 4: the locked tray (read this part slowly) =====
    // Reading a FIELD is easy — even the enum field. It's just a field:
    println!("\n{} — paid via: {:?}", lunch.dish, lunch.payment);

    // But "REF-2384-001" is locked INSIDE the GCash variant.
    // {:?} can show it; Dan cannot extract it. This does not compile:
    //
    //     if lunch.payment == Payment::GCash { ... }  // error[E0369]
    //
    // Which GCash? Carrying which reference? `==` has no way to
    // open the tray and look inside.
    // Tomorrow's tool is called `match`. (JM: "Promise, worth the wait.")
}
