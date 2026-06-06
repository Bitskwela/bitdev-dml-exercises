// ============================================
// MODULES — Full Solution
// Lesson 18 by Dan Santos
// ============================================
// The three-file refactor, flattened into one
// file with INLINE `mod` blocks. To the compiler
// this is the SAME module tree as main.rs +
// menu.rs + sales.rs — lift each block into its
// file, swap the braces for `mod menu;` /
// `mod sales;`, and nothing else changes.
// ============================================

// ===== STATION 1: the prep station ==========
// Inline form of `mod menu;` + src/menu.rs.
mod menu {
    // `pub struct` makes the TYPE visible to the rest of the
    // crate — and every field needs its own `pub`, because
    // fields are private by default too.
    pub struct MenuItem {
        pub name: String,
        pub price: u32,
    }

    pub fn build_menu() -> Vec<MenuItem> {
        vec![
            MenuItem { name: String::from("Adobo"), price: 75 },
            MenuItem { name: String::from("Sinigang na Baboy"), price: 95 },
            MenuItem { name: String::from("Tapsilog"), price: 95 },
            MenuItem { name: String::from("Halo-Halo"), price: 60 },
        ]
    }
}

// ===== STATION 2: the tally station =========
// Inline form of `mod sales;` + src/sales.rs.
mod sales {
    // Every module does its own imports. `use` lines elsewhere
    // in this file do NOT leak in here — each station starts clean.
    use std::collections::HashMap;

    pub fn tally(sales: &[String]) -> HashMap<String, u32> {
        let mut counts: HashMap<String, u32> = HashMap::new();
        for dish in sales {
            // The Lesson 17 one-liner: fetch this dish's counter,
            // or insert a 0 first if this is its first sale today.
            let count = counts.entry(dish.clone()).or_insert(0);
            *count += 1;
        }
        counts
    }

    pub fn leaderboard(counts: &HashMap<String, u32>) -> String {
        // HashMap order is scrambled on purpose — sort before showing.
        let mut rows: Vec<(&String, &u32)> = counts.iter().collect();
        // "Sort by count, biggest first; break ties by name."
        rows.sort_by(|a, b| b.1.cmp(a.1).then(a.0.cmp(b.0)));

        let mut board = String::from("=== Sabado Lunch Rush: Leaderboard ===\n");
        let mut rank: u32 = 1;
        for (dish, count) in rows {
            board.push_str(&format_row(rank, dish, *count));
            rank += 1;
        }
        board
    }

    // NO `pub`. This is the cash drawer — tally staff only.
    // `leaderboard` (same module) may call it. main() may NOT.
    fn format_row(rank: u32, dish: &str, count: u32) -> String {
        format!("{rank}. {dish:<18} x{count}\n")
    }
}

// The cashier's counter: absolute address once, short name afterwards.
use crate::menu::build_menu;
use crate::sales::{leaderboard, tally};

fn main() {
    println!("=== LutoCLI (dev build) — refactor weekend ===\n");

    // ===== Station 1: the prep station hands over the menu =====
    let menu = build_menu();
    println!("Menu ({} items):", menu.len());
    for item in &menu {
        println!("  {:<18} ₱{:>3}", item.name, item.price);
    }

    // ===== The Saturday lunch rush, simulated =====
    // (Lesson 17's rush — same orders, new floor plan.)
    let orders = [
        "Sinigang na Baboy", "Adobo", "Sinigang na Baboy", "Halo-Halo",
        "Adobo", "Tapsilog", "Sinigang na Baboy", "Adobo",
        "Halo-Halo", "Sinigang na Baboy", "Tapsilog", "Adobo",
        "Sinigang na Baboy", "Halo-Halo",
    ];
    let mut lunch_rush: Vec<String> = Vec::new();
    for dish in orders {
        lunch_rush.push(String::from(dish));
    }

    // ===== Station 2: the tally station does its thing =====
    let counts = tally(&lunch_rush);
    println!("\n{}", leaderboard(&counts));

    // ===== Cross-station teamwork: total kita =====
    // Prices from the menu station, counts from the tally station.
    let mut revenue: u32 = 0;
    for item in &menu {
        if let Some(count) = counts.get(&item.name) {
            revenue += item.price * *count;
        }
    }
    println!("Total kita: ₱{revenue}");

    // ===== The locked cash drawer =====
    // `format_row` is sales' PRIVATE helper. Uncomment the line
    // below and run `cargo check` to meet error[E0603] in person:
    //
    // println!("{}", sales::format_row(1, "Adobo", 4));
}
