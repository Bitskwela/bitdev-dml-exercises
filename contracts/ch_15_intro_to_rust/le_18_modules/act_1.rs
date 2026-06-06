// ============================================
// MODULES — Lesson 18
// by: <Your Name>
// ============================================
// Refactor weekend, single-file edition: one
// kitchen split into stations with INLINE `mod`
// blocks. On your own machine, each block below
// could move to src/menu.rs / src/sales.rs with
// `mod menu;` / `mod sales;` — same module tree,
// same privacy rules, same addresses.
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
        // TODO 1: return the four dishes as a Vec<MenuItem>:
        //   Adobo 75, Sinigang na Baboy 95, Tapsilog 95, Halo-Halo 60
        todo!()
    }
}

// ===== STATION 2: the tally station =========
// Inline form of `mod sales;` + src/sales.rs.
mod sales {
    // Every module does its own imports — `use` lines elsewhere
    // in this file do NOT leak in here. Each station starts clean.
    use std::collections::HashMap;

    pub fn tally(sales: &[String]) -> HashMap<String, u32> {
        // TODO 2: Lesson 17's idiom, relocated. For each dish in `sales`:
        //   let count = counts.entry(dish.clone()).or_insert(0);
        //   *count += 1;
        // Then return the HashMap.
        todo!()
    }

    pub fn leaderboard(counts: &HashMap<String, u32>) -> String {
        // TODO 3: collect into a Vec<(&String, &u32)>, then sort —
        // biggest count first, ties broken by name:
        //   rows.sort_by(|a, b| b.1.cmp(a.1).then(a.0.cmp(b.0)));
        // Start the String with "=== Sabado Lunch Rush: Leaderboard ===\n",
        // then push one format_row(rank, dish, *count) per dish, rank 1 up.
        todo!()
    }

    // NO `pub`. This is the cash drawer — tally staff only.
    // `leaderboard` (same module) may call it. main() may NOT.
    // (The "never used" warning disappears once TODO 3 calls it.)
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

    // TODO 4: uncomment Station 2 below once TODO 2 and TODO 3 compile.
    //
    // // ===== Station 2: the tally station does its thing =====
    // let counts = tally(&lunch_rush);
    // println!("\n{}", leaderboard(&counts));
    //
    // // ===== Cross-station teamwork: total kita =====
    // // Prices from the menu station, counts from the tally station.
    // let mut revenue: u32 = 0;
    // for item in &menu {
    //     if let Some(count) = counts.get(&item.name) {
    //         revenue += item.price * *count;
    //     }
    // }
    // println!("Total kita: ₱{revenue}");

    // ===== The locked cash drawer =====
    // `format_row` is sales' PRIVATE helper. Uncomment the line
    // below and run `cargo check` to meet error[E0603] in person —
    // the same function `leaderboard` calls freely is a brick wall
    // from out here. Re-comment it to go green again.
    //
    // println!("{}", sales::format_row(1, "Adobo", 4));
}
