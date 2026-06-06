// ============================================
// ENUMS — Full Solution
// Lesson 14 by Dan Santos
// ============================================
// An enum is the turo-turo tray rule: a value
// can only be one of the trays that EXIST.
// Walang 'Gkash' tray.
// ============================================

#[derive(Debug)]
enum Payment {
    Cash,          // no extra data needed
    GCash(String), // the reference number rides INSIDE the variant
    Maya(String),  // same idea, different wallet
    Utang,         // the notebook remembers
}

impl Payment {
    // Enums get impl blocks too — same move as MenuItem::new.
    // These helpers turn a &str into the owned String the variant wants.
    fn gcash(reference: &str) -> Payment {
        Payment::GCash(String::from(reference))
    }

    fn maya(reference: &str) -> Payment {
        Payment::Maya(String::from(reference))
    }
}

#[derive(Debug)]
struct Order {
    dish: String,
    total: u32,       // whole pesos, as always
    payment: Payment, // an enum, living inside a struct
    tip: Option<u32>, // maybe a tip, maybe none — absence is a TYPE
}

fn main() {
    println!("=== Tita Malou's Payment Drawer ===");
    println!("(money in whole pesos)\n");

    // ===== Part 1: three orders, three ways to pay =====
    let breakfast = Order {
        dish: String::from("Tapsilog"),
        total: 95,
        payment: Payment::Cash,
        tip: Some(5), // the jeepney driver said "keep the change"
    };

    let lunch = Order {
        dish: String::from("Sinigang na Baboy"),
        total: 120,
        payment: Payment::gcash("REF-2384-001"),
        tip: None, // no tip — and the program does NOT explode
    };

    let merienda = Order {
        dish: String::from("Lechon Kawali"),
        total: 150,
        payment: Payment::Utang, // Aling Nena, suki for ten years
        tip: None,
    };

    // ===== Part 2: {:?} shows the whole drawer =====
    println!("{:?}", breakfast);
    println!("{:?}", lunch);
    println!("{:?}", merienda);

    // One stray payment, no full order: the Zumba instructor's
    // halo-halo to-go, paid via Maya.
    let stray = Payment::maya("MAYA-7745-002");
    println!("Stray payment (halo-halo to-go): {:?}", stray);

    // ===== Part 3: the closing tally =====
    let sales_total = breakfast.total + lunch.total + merienda.total;
    println!("\nSales recorded:  P{}", sales_total);

    // `.unwrap_or(0)` reads as: "if there's a tip inside, take it;
    // if it's None, use 0." No crash, no null, no drama.
    let tip_total =
        breakfast.tip.unwrap_or(0) + lunch.tip.unwrap_or(0) + merienda.tip.unwrap_or(0);
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
