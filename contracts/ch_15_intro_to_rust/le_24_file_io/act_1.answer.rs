// ============================================
// FILE I/O — Full Solution
// Lesson 24 by Dan Santos
// ============================================
// Read the real carinderia CSV — or the embedded
// sample when the file isn't there — total the
// month, and write Dan's first-ever output file.
// ============================================

use std::fs;

// 14 representative rows of May 2026, straight from the digitized
// notebook: same 7 columns as the real carinderia-sales.csv, including
// 2 payday rows and 3 rainy rows. No commas inside fields, by design —
// split(',') is safe here.
const SAMPLE_CSV: &str = "\
date,item,quantity,revenue,day_of_week,is_payday,weather
2026-05-01,Sinigang na Baboy,10,950,Friday,False,sunny
2026-05-01,Halo-Halo,11,660,Friday,False,sunny
2026-05-02,Adobo,15,1125,Saturday,False,cloudy
2026-05-04,Lechon Kawali,7,910,Monday,False,sunny
2026-05-05,Halo-Halo,2,120,Tuesday,False,rainy
2026-05-05,Sinigang na Baboy,15,1425,Tuesday,False,rainy
2026-05-08,Tinola,9,630,Friday,False,sunny
2026-05-10,Adobo,14,1050,Sunday,False,sunny
2026-05-15,Halo-Halo,16,960,Friday,True,sunny
2026-05-15,Sinigang na Baboy,12,1140,Friday,True,sunny
2026-05-19,Sinigang na Baboy,16,1520,Tuesday,False,rainy
2026-05-23,Bistek,10,950,Saturday,False,sunny
2026-05-24,Tinola,11,770,Sunday,False,cloudy
2026-05-27,Halo-Halo,11,660,Wednesday,False,sunny
";

fn main() -> Result<(), Box<dyn std::error::Error>> {
    // Read or fall back. The one-liner version of this pattern is:
    //     fs::read_to_string("carinderia-sales.csv")
    //         .unwrap_or_else(|_| SAMPLE_CSV.to_string());
    // The match form does the same tolerant thing AND lets us stamp the
    // source. Tolerant is honest here — a missing dataset file has a
    // sensible default (the embedded sample), so the program runs anywhere.
    // A garbage peso below does NOT get the same mercy: that stays strict.
    let (contents, source) = match fs::read_to_string("carinderia-sales.csv") {
        Ok(text) => (text, "carinderia-sales.csv (May 2026)"),
        Err(_) => (
            SAMPLE_CSV.to_string(),
            "embedded SAMPLE_CSV (14 rows, May 2026)",
        ),
    };

    let mut row_count: u32 = 0;
    let mut total_revenue: u32 = 0;
    let mut payday_rows: u32 = 0;

    // .lines() iterates &str line by line; .skip(1) jumps the header row.
    for line in contents.lines().skip(1) {
        // date,item,quantity,revenue,day_of_week,is_payday,weather
        //  [0]  [1]    [2]      [3]      [4]        [5]      [6]
        let fields: Vec<&str> = line.split(',').collect();

        // STRICT parse for money. If a revenue cell is garbage, the
        // program STOPS — it never quietly counts the row as P0.
        let revenue = fields[3].parse::<u32>()?;

        // The True/False gotcha: "True".parse::<bool>() FAILS in Rust
        // (lowercase only). The notebook doesn't speak Rust — Python
        // wrote this file — so we compare the raw text instead.
        let is_payday = fields[5] == "True";

        row_count += 1;
        total_revenue += revenue;
        if is_payday {
            payday_rows += 1;
        }
    }

    let average = total_revenue / row_count; // whole pesos, u32 division

    println!("=== LutoCLI: Notebook Import ===");
    println!("Source:          {source}");
    println!("Rows read:       {row_count}");
    println!("Total revenue:   P{total_revenue}");
    println!("Average per row: P{average}");
    println!("Payday rows:     {payday_rows}");

    // Build the WHOLE report as one String first...
    // (The filename is aspirational — LutoCLI v1.0 will write one per day.)
    let report = format!(
        "TITA MALOU'S CARINDERIA - MONTHLY REPORT\n\
         Source: {}\n\
         ----------------------------------------\n\
         Rows read:       {}\n\
         Total revenue:   P{}\n\
         Average per row: P{}\n\
         Payday rows:     {}\n",
        source, row_count, total_revenue, average, payday_rows
    );

    // ...then write it to disk in one call. Same Result discipline as reading.
    fs::write("daily-report.txt", report)?;
    println!("\nReport written!");

    Ok(())
}
