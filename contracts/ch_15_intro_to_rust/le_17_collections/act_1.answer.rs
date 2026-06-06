// ============================================
// COLLECTIONS — Full Solution
// Lesson 17 by Dan Santos
// ============================================
// Vec<T>: the order spike — every sale, in
// order, growing as the rush grows.
// HashMap<K, V>: the tally board — chalk
// marks per ulam, looked up by name.
// ============================================

use std::collections::HashMap;

fn main() {
    println!("=== LutoCLI prototype: Lunch Rush Tally ===\n");

    // ===== Part 1: Vec<String> — the order spike =====
    // Every sale of today's lunch rush, in the order they were
    // shouted at the counter. `mut` because rushes grow.
    let mut sales: Vec<String> = vec![
        String::from("Adobo"),
        String::from("Sinigang na Baboy"),
        String::from("Adobo"),
        String::from("Lechon Kawali"),
        String::from("Tinola"),
        String::from("Adobo"),
        String::from("Sinigang na Baboy"),
        String::from("Halo-Halo"),
        String::from("Lechon Kawali"),
        String::from("Adobo"),
        String::from("Sinigang na Baboy"),
        String::from("Tinola"),
        String::from("Lechon Kawali"),
        String::from("Sinigang na Baboy"),
    ];

    // 12:58 PM — one last customer slides in. .push() needs that `mut`.
    sales.push(String::from("Adobo"));

    println!("Sales on the spike: {}", sales.len());
    println!("First order of the rush: {}", sales[0]);

    // sales[100] would PANIC: index out of bounds.
    // .get() asks politely and gets an Option back — Lesson 14, reporting for duty:
    match sales.get(100) {
        Some(dish) => println!("Order #101: {dish}"),
        None => println!("Order #101: wala — the rush was not THAT good."),
    }

    // ===== Part 2: HashMap — the tally board =====
    let mut tally: HashMap<String, u32> = HashMap::new();

    // THE idiom. Memorize this line — LutoCLI will run on it:
    //   .entry(key)     -> the slot for that key, existing or not
    //   .or_insert(0)   -> if vacant, put 0; either way, hand back &mut u32
    //   *slot += 1      -> bump the count through that mutable reference
    for dish in &sales {
        *tally.entry(dish.clone()).or_insert(0) += 1;
    }
    // (&sales, not sales — a bare `for dish in sales` MOVES the whole
    //  Vec into the loop, and the spike is gone after one pass.)

    // ===== Part 3: .get() — safe lookups, no panics =====
    println!();
    for lookup in ["Adobo", "Kare-Kare"] {
        match tally.get(lookup) {
            Some(count) => println!("{lookup}: {count} sold"),
            None => println!("{lookup}: wala sa menu ngayon, suki."),
        }
    }

    // ===== Part 4: the leaderboard =====
    // HashMaps are UNORDERED — print one directly and the order
    // shuffles every run. To display: collect into a Vec, then sort.
    let mut leaderboard: Vec<(&String, &u32)> = tally.iter().collect();
    leaderboard.sort_by(|a, b| b.1.cmp(a.1)); // descending by count

    println!("\n--- TALLY NG TANGHALIAN ---");
    for (dish, count) in &leaderboard {
        println!("{count:>2}x  {dish}");
    }

    // .first() returns an Option too — even a sorted leaderboard
    // refuses to promise it isn't empty.
    if let Some((top_dish, top_count)) = leaderboard.first() {
        println!("\nTop seller: {top_dish} — {top_count} plates. Tita Malou called it.");
    }
}
