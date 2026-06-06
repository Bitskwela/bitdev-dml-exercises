// ============================================
// VARIABLES & MUTABILITY — Lesson 4
// by: <Your Name>
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

    // ===== Part 1: meet error[E0384] in person =====
    // Dan's first attempt. Uncomment the two lines below, run
    // `cargo check`, and READ the error calmly — error code first,
    // then the help: line, then the span arrows. Comment them back
    // out when you're done.
    //
    // let cups_of_rice = OPENING_CUPS;
    // cups_of_rice = cups_of_rice - 4;  // error[E0384]: cannot assign twice to immutable variable

    // ===== Part 2: `mut` — asking permission out loud =====
    let mut cups_of_rice: u32 = OPENING_CUPS;
    println!("Opening rice: {} cups", cups_of_rice);

    // 7:30 AM — jeepney drivers, silog batch (worked example)
    cups_of_rice -= 4;
    println!("After jeepney drivers:  {} cups left", cups_of_rice);

    // TODO: two more batches hit the counter. Update `cups_of_rice`
    // with `-=` and print after each one:
    //   11:45 AM — office crowd from the barangay hall, 12 cups
    //              "After the office crowd: {} cups left"
    //   12:30 PM — tricycle drivers, extra-rice gang, 9 cups
    //              "After the lunch rush:   {} cups left"

    // ===== Part 3: shadowing — same name, brand-new binding =====
    let price: u32 = 70; // base price of the lunch plate
    println!("\nBase price:   P{}", price);

    // TODO: the 15th — quincena. Shadow `price` with a NEW `let`
    // binding worth `price + 10` (same name, NOT mut), then print:
    // "Payday price: P{}"

    // TODO: shadow `price` AGAIN — and change the TYPE this time:
    // u32 -> String, via format!("P{} (payday)", price). Then print:
    // "Price tag:    {}"
    // (Try doing this with `mut` instead and the compiler hands you
    // a type mismatch. Shadowing is the only way.)

    // ===== Part 4: const earns its keep =====
    // TODO: bind `regular_price` (u32, 80 pesos), then compute
    // `senior_price` with integer math using the const:
    //   regular_price * (100 - SENIOR_DISCOUNT_PCT) / 100
    // and print: "\nSenior price: P{} ({}% off P{})"
}
