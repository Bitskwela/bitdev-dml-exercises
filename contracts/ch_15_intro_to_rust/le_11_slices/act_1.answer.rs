// ============================================
// SLICES — Full Solution
// Lesson 11 by Dan Santos
// ============================================
// A slice is a borrowed VIEW into data someone
// else owns: a pointer + a length, zero copying.
//   &str  = a view into string data
//   &[T]  = a view into array / Vec data
// ============================================

// Takes &str, NOT &String — so it accepts a String,
// a literal, or another slice. (Deref coercion.)
fn first_word(s: &str) -> &str {
    match s.find(' ') {
        Some(space_at) => &s[..space_at], // window: start to the space
        None => s,                        // no space? the word IS the string
    }
}

// One function, every view: the whole week, the
// weekdays, the weekend — anything that is &[u32].
fn total(days: &[u32]) -> u32 {
    let mut sum = 0;
    for amount in days {
        sum += amount;
    }
    sum
}

fn main() {
    println!("=== Tita Malou's Menu Board ===\n");

    // ===== Part 1: short labels, zero clones =====
    let dishes = [
        String::from("Sinigang na Baboy"),
        String::from("Lechon Kawali"),
        String::from("Adobo"),
    ];

    println!("-- Chalkboard (short) vs records (full) --");
    for dish in &dishes {
        let label = first_word(dish); // &String coerces to &str, quietly
        println!("  {:<10} <- {}", label, dish);
    }
    // The full names still live in `dishes`, untouched.
    // Every `label` was only ever a window into them.

    // ===== Part 2: bytes, not chars =====
    let price_tag = "₱95"; // the peso sign is THREE bytes in UTF-8
    println!("\n-- Price tag surgery --");
    println!("  {:?} is {} bytes long, not 3", price_tag, price_tag.len());

    let sign = &price_tag[..3]; // OK: 0..3 is exactly the ₱
    let digits = &price_tag[3..]; // OK: starts right after it
    println!("  sign = {:?}, digits = {:?}", sign, digits);

    // String slices count BYTES. Cut through the middle of a
    // character and the program PANICS at runtime. Uncomment to meet it:
    //
    // let broken = &price_tag[0..1]; // byte 1 is INSIDE the ₱ -> panic!

    // ===== Part 3: one week, three views, zero copies =====
    let revenues: [u32; 7] = [4_850, 5_200, 4_975, 5_430, 6_100, 7_250, 6_980];
    //                         Mon    Tue    Wed    Thu    Fri    Sat    Sun

    let weekdays = &revenues[0..5]; // Mon..Fri — a view, not a copy
    let weekend = &revenues[5..7]; // Sat..Sun — same array, second window
    // shorthand for the same windows: &revenues[..5] and &revenues[5..]

    println!("\n-- Revenue views --");
    println!("  Weekday total: P{}", total(weekdays));
    println!("  Weekend total: P{}", total(weekend));
    println!("  Whole week:    P{}", total(&revenues)); // [u32; 7] -> &[u32], same function
}
