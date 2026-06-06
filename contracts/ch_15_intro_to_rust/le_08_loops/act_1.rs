// ============================================
// LOOPS — Lesson 8
// by: <Your Name>
// ============================================
// Three loops, one carinderia:
//   1. `for`   — tally the day's sales
//   2. `while` — countdown to closing time
//   3. `loop`  — scan for the day the cash target was hit
// Finale: the 10-million-iteration drag race.
// ============================================

use std::time::Instant;

fn main() {
    // ===== PART 1: `for` — sum + count the day's sales =====
    // Whole pesos, so u32. (Lesson 5 rule: money is u32.)
    let sales: [u32; 8] = [120, 85, 200, 150, 95, 310, 180, 250];

    let mut total: u32 = 0;
    let mut count: u32 = 0;
    for amount in sales {
        total += amount;
        // TODO: increment `count` here so the tally also reports
        // HOW MANY transactions there were (expected: 8).
    }
    println!("=== PART 1: for — tally the day's sales ===");
    println!("Transactions: {count}");
    println!("Total kita:   ₱{total}");
    println!();

    // ===== PART 2: `while` — countdown to closing time =====
    // The carinderia closes at 8 PM (hour 20). It's 4 PM (hour 16).
    let closing_hour: u32 = 20;
    let mut hour: u32 = 16;

    println!("=== PART 2: while — countdown to closing ===");
    // TODO: write a `while hour < closing_hour` loop that prints
    //   "{hour}:00 — {hours left} hour(s) left. Keep cooking!"
    // once per hour, incrementing `hour` each pass. Remember the
    // Lesson 7 rule: the condition must be a real `bool`.

    println!("{}:00 — sarado na. Good work today.", hour);
    println!();

    // ===== PART 3: `loop` + break-with-value =====
    // Which day did the carinderia first hit the ₱5,000 cash target?
    let day_names = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    let daily_totals: [u32; 7] = [3_500, 4_200, 2_800, 5_600, 4_900, 6_100, 5_300];
    let target: u32 = 5_000;

    // TODO: replace this placeholder with a `loop` that walks `daily_totals`
    // and does `break day;` at the first day >= target. The whole loop is an
    // expression — `let hit_day = loop { ... };` catches the broken-out value.
    // No `found` flag, no post-loop cleanup. (Expected: Thu, ₱5600.)
    let hit_day: usize = 0;

    println!("=== PART 3: loop — first day to hit the target ===");
    println!(
        "First day to hit ₱{target}: {} (₱{})",
        day_names[hit_day], daily_totals[hit_day]
    );
    println!();

    // ===== FINALE: the 10-million-iteration drag race =====
    // u64 accumulator: the true sum is 50,000,005,000,000 —
    // way past u32::MAX (4,294,967,295). The u32 money rule
    // doesn't apply here; this is a counter, not a cash drawer.
    println!("=== FINALE: the drag race ===");
    let start = Instant::now();

    let mut sum: u64 = 0;
    // TODO: write a `for` loop over the INCLUSIVE range 1..=10_000_000u64
    // that adds each n into `sum`. (Careful: 1..10_000_000 stops one short.)
    // The Instant stopwatch above is already running — just write the loop.

    let elapsed = start.elapsed();
    println!("Sum of 1..=10,000,000 = {sum}");
    println!("Time: {:.3?}", elapsed);
    println!();
    println!("NOTE: run `cargo run` first, then `cargo run --release`,");
    println!("and compare the two times. Same code. Same laptop.");
}
