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

    // push_str appends a &str view into YOUR pot.
    // The lines are only BORROWED — still usable afterwards.
    receipt.push_str(&line1);
    receipt.push_str(&line2);
    receipt.push_str(&line3);
    receipt.push_str("----------------------\n");

    let total_line = format!("{:<18} ₱{:>3}\n", "TOTAL", total);
    receipt.push_str(&total_line);

    // push appends ONE char. Single quotes — a char, not a &str.
    receipt.push('\n');

    println!("{}", receipt);

    // ===== Part 3: the `+` that bit Dan this morning =====
    // `+` MOVES the left side and only borrows the right.
    // Uncomment the three lines below to watch `header` vanish:
    //
    // let header = String::from("** Tita Malou's Carinderia **\n");
    // let banner = header + "Receipt No. 0001\n";
    // println!("{}", header); // error[E0382]: borrow of moved value: `header`

    // ===== Part 4: Kuya JM's video-call demo, re-run =====
    let halo = "Halo-Halo ₱95";
    println!("\"{}\"", halo);
    println!("  .len()           = {}  <- BYTES", halo.len());
    println!("  .chars().count() = {}  <- CHARACTERS", halo.chars().count());
    // ₱ is ONE character but THREE bytes. This is exactly why
    // halo[0] refuses to compile — there is no honest answer.

    // ===== Part 5: Lesson 11's first_word, fed a &String =====
    // first_word wants &str. We hand it &receipt — a &String.
    // Deref coercion: &String quietly becomes &str. It just works.
    let first = first_word(&receipt);
    println!("\nFirst word of the receipt: {}", first);
}
