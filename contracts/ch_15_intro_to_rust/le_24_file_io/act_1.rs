// ============================================
// FILE I/O — Lesson 24
// by: <Your Name>
// ============================================
// Read the carinderia CSV — the real file if it's
// there, the embedded sample if not — total the
// month, and write your first-ever output file.
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
    // Read or fall back — GIVEN. The one-liner version of this pattern is:
    //     fs::read_to_string("carinderia-sales.csv")
    //         .unwrap_or_else(|_| SAMPLE_CSV.to_string());
    // We use the match form of the same tolerant choice so the program can
    // stamp WHICH data it ate. Tolerant is honest here — a missing dataset
    // file has a sensible default (the embedded sample), so the exercise
    // runs anywhere. A garbage peso below does NOT get the same mercy.
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

    // TODO 1: the header row is labels, not data — add .skip(1) after
    // .lines() so the word "revenue" never reaches your number parser.
    for line in contents.lines() {
        // date,item,quantity,revenue,day_of_week,is_payday,weather
        //  [0]  [1]    [2]      [3]      [4]        [5]      [6]
        let fields: Vec<&str> = line.split(',').collect();

        // TODO 2: STRICT-parse fields[3] (revenue) with .parse::<u32>()?
        //         Money stops loudly on garbage — never unwrap_or(0) a peso.

        // TODO 3: is_payday — careful: "True".parse::<bool>() FAILS in Rust
        //         (lowercase only; Python wrote this file). Compare the raw
        //         text instead: fields[5] == "True"

        // TODO 4: count the row in row_count, add the revenue to
        //         total_revenue, and if is_payday, count it in payday_rows.

        let _ = fields; // (delete this line once you use `fields`)
    }

    // Whole-peso u32 division, guarded so the starter runs as shipped.
    let average = if row_count == 0 { 0 } else { total_revenue / row_count };

    println!("=== LutoCLI: Notebook Import ===");
    println!("Source:          {source}");
    println!("Rows read:       {row_count}");
    println!("Total revenue:   P{total_revenue}");
    println!("Average per row: P{average}");
    println!("Payday rows:     {payday_rows}");

    // TODO 5: build the WHOLE report as one String with format! — rows,
    // total, average, payday rows, plus the {source} stamp — then write
    // it in one call:
    //     fs::write("daily-report.txt", report)?;
    // and print "Report written!" so the user knows where to look.

    Ok(())
}
