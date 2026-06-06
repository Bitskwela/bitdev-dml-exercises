// ============================================
// STRINGS — Lesson 12
// by: <Your Name>
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

    // ===== Part 2: format! cooks the lines, push_str assembles =====
    // format! BORROWS its arguments and hands back a brand-new String.
    // The catering order: Adobo ₱75, Sinigang na Baboy ₱95, Halo-Halo ₱60.
    let dish1 = "Adobo";
    let dish2 = "Sinigang na Baboy";
    let dish3 = "Halo-Halo";

    // The Adobo line is cooked for you — note the template:
    let line1 = format!("{:<18} ₱{:>3}\n", dish1, 75);
    receipt.push_str(&line1); // push_str appends a &str view into YOUR pot

    // TODO 1: finish the receipt —
    //   a) cook line2 (dish2, 95) and line3 (dish3, 60) with the SAME
    //      format! template as line1, then push_str both into `receipt`
    //      (dish2 and dish3 stay alive afterwards — format! only borrows)
    //   b) push_str the separator: "----------------------\n"
    //   c) build total_line with the same template ("TOTAL", 75 + 95 + 60)
    //      and push_str it
    //   d) append ONE final '\n' with .push() — single quotes: a char,
    //      not a &str

    println!("{}", receipt);

    // ===== Part 3: the `+` that bit Dan this morning =====
    // `+` MOVES the left side and only borrows the right.
    // Uncomment the three lines below to watch `header` vanish, read
    // E0382 calmly, then re-comment them. `+` stays retired:
    //
    // let header = String::from("** Tita Malou's Carinderia **\n");
    // let banner = header + "Receipt No. 0001\n";
    // println!("{}", header); // error[E0382]: borrow of moved value: `header`

    // ===== Part 4: Kuya JM's video-call demo =====
    let halo = "Halo-Halo ₱95";
    println!("\"{}\"", halo);

    // TODO 2: print BOTH counts for `halo` — count with your eyes first
    // (thirteen characters), then let the terminal disagree:
    //   halo.len()             -> BYTES
    //   halo.chars().count()   -> CHARACTERS
    // The peso sign is ONE character but THREE bytes. This is exactly
    // why halo[0] refuses to compile — there is no honest answer.

    // ===== Part 5: Lesson 11's first_word, fed a &String =====
    // first_word wants &str. We hand it &receipt — a &String.
    // Deref coercion: &String quietly becomes &str. It just works.
    //
    // TODO 3: uncomment the two lines below — they compile unchanged:
    // let first = first_word(&receipt);
    // println!("\nFirst word of the receipt: {}", first);
}
