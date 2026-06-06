// ============================================
// STRINGS — Full Solution
// Lesson 12 by Dan Santos
// ============================================
// String is the pot you own — heap, growable.
// &str is looking into someone else's pot.
// `format!` cooks new Strings without taking
// anyone's pot away. `+` is retired.
// ============================================

// Lesson 11's first_word, unchanged. It asks for &str —
// so it accepts string literals AND &String. Watch Part 5.
fn first_word(s: &str) -> &str {
    let bytes = s.as_bytes();
    for (i, &b) in bytes.iter().enumerate() {
        if b == b' ' {
            return &s[..i];
        }
    }
    s
}

fn main() {
    println!("=== Receipt Printer — Lesson 12 ===\n");

    // ===== Part 1: the pot you own =====
    // String::from buys you your OWN pot: owned, growable, on the heap.
    let mut receipt = String::from("** Tita Malou's Carinderia **\n");

    // ===== Part 2: format! cooks the lines =====
    // format! BORROWS its arguments and hands back a brand-new String.
    // `dish` below stays alive and usable after every call. Nobody
    // loses a pot.
    let dish1 = "Adobo";
    let dish2 = "Sinigang na Baboy";
    let dish3 = "Halo-Halo";

    let line1 = format!("{:<18} ₱{:>3}\n", dish1, 75);
    let line2 = format!("{:<18} ₱{:>3}\n", dish2, 95);
    let line3 = format!("{:<18} ₱{:>3}\n", dish3, 60);

    let total: u32 = 75 + 95 + 60;
