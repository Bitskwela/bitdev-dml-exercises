// ============================================
// COLLECTIONS — Lesson 17
// by: <Your Name>
// ============================================
// Vec<T>: the order spike — every sale, in
// order, growing as the rush grows.
// HashMap<K, V>: the tally board — chalk
// marks per ulam, looked up by name.
// ============================================

use std::collections::HashMap;

fn main() {
    println!("=== LutoCLI prototype: Lunch Rush Tally ===\n");

    // ===== Part 1: Vec<String> — the order spike (GIVEN) =====
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

    // TODO 1: sales[100] would PANIC — index out of bounds, a crash.
    // Ask politely instead: match sales.get(100) with BOTH arms —
    //   Some(dish) => "Order #101: {dish}"
    //   None       => "Order #101: wala — the rush was not THAT good."

    // ===== Part 2: HashMap — the tally board =====
    let mut tally: HashMap<String, u32> = HashMap::new();

    for dish in &sales {
        // TODO 2: THE LutoCLI idiom, one line. Fill in the blanks:
        //   *tally.entry( ??? ).or_insert( ??? ) += 1;
        // Remember: `dish` here is a BORROWED &String (note the &sales
        // above — a bare `for dish in sales` would MOVE the whole Vec).
        // The map demands ownership of its keys, so hand it dish.clone().
    }

    // ===== Part 3: .get() — safe lookups, no panics =====
    println!();
    for lookup in ["Adobo", "Kare-Kare"] {
        // TODO 3: look up `lookup` with tally.get(lookup) and match
        // BOTH arms. Kare-Kare is NOT on today's menu — that arm prints
        //   "{lookup}: wala sa menu ngayon, suki."
        // and the found arm prints "{lookup}: {count} sold".
        let _ = lookup; // (remove this line once your match uses `lookup`)
    }

    // ===== Part 4: the leaderboard =====
    // HashMaps are UNORDERED — print one directly and the order
    // shuffles every run. To display: collect into a Vec, then sort.

    // TODO 4: build the leaderboard:
    //   let mut leaderboard: Vec<(&String, &u32)> = tally.iter().collect();
    //   sort DESCENDING by count: .sort_by(|a, b| b.1.cmp(a.1))
    // then print the "--- TALLY NG TANGHALIAN ---" board, one line per
    // dish: "{count:>2}x  {dish}".

    // TODO 5: the top seller. .first() on the sorted leaderboard returns
    // an Option (even a sorted Vec refuses to promise it isn't empty) —
    // use `if let Some((top_dish, top_count)) = ...` to print:
    //   "Top seller: {top_dish} — {top_count} plates. Tita Malou called it."
}
