// ============================================
// VARIABLES & MUTABILITY — Full Solution
// Lesson 4 by Dan Santos
// ============================================
// Immutable by default. `mut` is permission,
// said out loud. Shadowing makes a NEW binding
// — and it can even change the type.
// ============================================

// Constants: type annotation REQUIRED, SCREAMING_SNAKE_CASE,
// value must be known at compile time.
const SENIOR_DISCOUNT_PCT: u32 = 20;
const OPENING_CUPS: u32 = 50;

fn main() {
    println!("=== Tita Malou's Rice Tracker ===");
    println!("(rice in cups, money in whole pesos)\n");

    // ===== Part 1: the line that started it all =====
    // Dan's first attempt. Uncomment the two lines below and run
    // `cargo check` to meet error[E0384] in person:
    //
    // let cups_of_rice = OPENING_CUPS;
    // cups_of_rice = cups_of_rice - 4;  // error[E0384]: cannot assign twice to immutable variable

    // ===== Part 2: `mut` — asking permission out loud =====
    let mut cups_of_rice: u32 = OPENING_CUPS;
    println!("Opening rice: {} cups", cups_of_rice);

    // 7:30 AM — jeepney drivers, silog batch
    cups_of_rice -= 4;
    println!("After jeepney drivers:  {} cups left", cups_of_rice);

    // 11:45 AM — office crowd from the barangay hall
    cups_of_rice -= 12;
    println!("After the office crowd: {} cups left", cups_of_rice);

    // 12:30 PM — tricycle drivers, extra-rice gang
    cups_of_rice -= 9;
    println!("After the lunch rush:   {} cups left", cups_of_rice);

    // ===== Part 3: shadowing — same name, brand-new binding =====
    let price: u32 = 70; // base price of the lunch plate
    println!("\nBase price:   P{}", price);

    // The 15th — quincena. Same NAME, new BINDING. Not mutation.
    let price: u32 = price + 10;
    println!("Payday price: P{}", price);

    // Shadow AGAIN — and this time the TYPE changes: u32 -> String.
    // Plain `mut` could never do this; mutation must keep the type.
    let price: String = format!("P{} (payday)", price);
    println!("Price tag:    {}", price);

    // ===== Part 4: const earns its keep =====
    let regular_price: u32 = 80;
    let senior_price = regular_price * (100 - SENIOR_DISCOUNT_PCT) / 100;
    println!(
        "\nSenior price: P{} ({}% off P{})",
        senior_price, SENIOR_DISCOUNT_PCT, regular_price
    );
}
