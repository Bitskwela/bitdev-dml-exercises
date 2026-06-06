// ============================================
// MINI PROJECT: LUTOCLI — Full Solution
// Lesson 25 by Dan Santos
// ============================================
// One file, three stations. In the real shipped project
// these are three files — src/main.rs (the counter),
// src/record.rs (the prep station), src/report.rs (the
// kitchen) — flattened here into inline `mod` blocks so
// one file carries the whole tool. Zero unwrap(). Zero
// expect(). House rules, fulfilled.
// ============================================

use std::path::Path;
use std::{env, fs, process};

use record::SaleRecord;

/// The real May 2026 notebook, if it's sitting next to Cargo.toml.
const DATA_FILE: &str = "carinderia-sales.csv";

/// No CSV nearby? LutoCLI still runs: 14 real rows embedded in the
/// binary — both quincenas (May 15 + 30) and the rainy week included.
const SAMPLE_CSV: &str = "\
date,item,quantity,revenue,day_of_week,is_payday,weather
2026-05-01,Sinigang na Baboy,10,950,Friday,False,sunny
2026-05-02,Adobo,15,1125,Saturday,False,cloudy
2026-05-03,Halo-Halo,13,780,Sunday,False,sunny
2026-05-05,Halo-Halo,2,120,Tuesday,False,rainy
2026-05-05,Sinigang na Baboy,15,1425,Tuesday,False,rainy
2026-05-10,Lechon Kawali,9,1170,Sunday,False,sunny
2026-05-12,Tinola,9,630,Tuesday,False,sunny
2026-05-15,Halo-Halo,16,960,Friday,True,sunny
2026-05-15,Sinigang na Baboy,12,1140,Friday,True,sunny
2026-05-18,Sinigang na Baboy,14,1330,Monday,False,rainy
2026-05-22,Adobo,12,900,Friday,False,sunny
2026-05-23,Bistek,10,950,Saturday,False,sunny
2026-05-30,Adobo,19,1425,Saturday,True,sunny
2026-05-30,Halo-Halo,19,1140,Saturday,True,sunny
";

// ============================================
// mod record — the prep station
// (src/record.rs in the real three-file layout)
// One CSV row -> one SaleRecord, or one friendly sentence.
// ============================================
mod record {
    pub struct SaleRecord {
        pub item: String,
        pub quantity: u32,
        pub revenue: u32, // whole pesos — Lesson 5's law still stands
        pub day_of_week: String,
        pub is_payday: bool,
        pub weather: String,
    }

    /// "2026-05-15,Halo-Halo,16,960,Friday,True,sunny" -> SaleRecord.
    /// The exact bug that crashed Python Dan dies HERE, politely.
    pub fn parse_line(line: &str) -> Result<SaleRecord, String> {
        let fields: Vec<&str> = line.split(',').collect();

        if fields.len() != 7 {
            return Err(format!(
                "may {} field ang row pero 7 ang inaasahan. Buong row: '{}'",
                fields.len(),
                line
            ));
        }

        let quantity: u32 = fields[2].trim().parse().map_err(|_| {
            format!("hindi mabasa ang quantity na '{}' — dapat buong numero.", fields[2])
        })?;

        let revenue: u32 = fields[3].trim().parse().map_err(|_| {
            format!("hindi mabasa ang revenue na '{}' — dapat buong piso.", fields[3])
        })?;

        Ok(SaleRecord {
            item: fields[1].to_string(),
            quantity,
            revenue,
            day_of_week: fields[4].to_string(),
            is_payday: fields[5] == "True",
            weather: fields[6].trim().to_string(),
        })
    }

    #[cfg(test)]
    mod tests {
        use super::*;

        // Tests can return Result too — so even our proofs get to use `?`.
        #[test]
        fn payday_row_parses() -> Result<(), String> {
            let rec = parse_line("2026-05-15,Halo-Halo,16,960,Friday,True,sunny")?;
            assert_eq!(rec.item, "Halo-Halo");
            assert_eq!(rec.revenue, 960);
            assert!(rec.is_payday);
            Ok(())
        }

        #[test]
        fn ordinary_day_is_not_payday() -> Result<(), String> {
            let rec = parse_line("2026-05-18,Adobo,11,825,Monday,False,rainy")?;
            assert!(!rec.is_payday);
            Ok(())
        }

        #[test]
        fn written_out_number_is_rejected_politely() {
            // The notebook says "sixteen"? LutoCLI says no — a sentence, not a crash.
            assert!(parse_line("2026-05-15,Halo-Halo,sixteen,960,Friday,True,sunny").is_err());
        }
    }
}

// ============================================
// mod report — the kitchen
// (src/report.rs in the real three-file layout)
// Aggregations only. Borrowed views — nobody owns the records here.
// ============================================
mod report {
    use crate::record::SaleRecord;
    use std::collections::HashMap;

    pub fn summary(records: &[SaleRecord]) {
        let total: u32 = records.iter().map(|r| r.revenue).sum();
        let count = records.len() as u32;
        let average = if count == 0 { 0 } else { total / count };

        // Tita Malou's actual question: alin ang pinakamalakas na araw?
        let mut per_day: HashMap<&str, u32> = HashMap::new();
        for rec in records {
            *per_day.entry(rec.day_of_week.as_str()).or_insert(0) += rec.revenue;
        }
        let best_day = per_day.into_iter().max_by_key(|(_, kita)| *kita);

        println!("=== LutoCLI: Buod ng Benta ===");
        println!("Rows sa notebook:  {}", records.len());
        println!("Kabuuang kita:     P{}", total);
        println!("Average kada row:  P{}", average);
        if let Some((day, kita)) = best_day {
            println!("Pinakamalakas:     {} (P{} sa buong buwan)", day, kita);
        }
    }

    pub fn top_dishes(records: &[SaleRecord]) {
        // Lesson 17's lunch-rush tally, now earning its keep.
        let mut tally: HashMap<&str, u32> = HashMap::new();
        for rec in records {
            *tally.entry(rec.item.as_str()).or_insert(0) += rec.quantity;
        }

        // Most servings first; pantay? Alphabetical, para deterministic.
        let mut ranked: Vec<(&str, u32)> = tally.into_iter().collect();
        ranked.sort_by(|a, b| b.1.cmp(&a.1).then(a.0.cmp(&b.0)));

        println!("=== LutoCLI: Top 3 Ulam (by servings) ===");
        for (rank, (item, servings)) in ranked.iter().take(3).enumerate() {
            println!("{}. {:<17} {} servings", rank + 1, item, servings);
        }
    }

    pub fn payday_compare(records: &[SaleRecord]) {
        let payday_total: u32 = records.iter().filter(|r| r.is_payday).map(|r| r.revenue).sum();
        let payday_rows = records.iter().filter(|r| r.is_payday).count() as u32;
        let ordinary_total: u32 = records.iter().filter(|r| !r.is_payday).map(|r| r.revenue).sum();
        let ordinary_rows = records.len() as u32 - payday_rows;

        let payday_avg = if payday_rows == 0 { 0 } else { payday_total / payday_rows };
        let ordinary_avg = if ordinary_rows == 0 { 0 } else { ordinary_total / ordinary_rows };

        println!("=== LutoCLI: Quincena vs Ordinaryong Araw ===");
        println!("Payday rows:   {:>2} | kita P{:>5} | avg P{:>4}/row", payday_rows, payday_total, payday_avg);
        println!("Ordinary rows: {:>2} | kita P{:>5} | avg P{:>4}/row", ordinary_rows, ordinary_total, ordinary_avg);
        if payday_avg > ordinary_avg {
            println!("Quincena effect: TOTOO. Mas malakas ang benta tuwing sweldo.");
        }
    }

    pub fn weather_report(records: &[SaleRecord]) {
        let mut buckets: HashMap<&str, u32> = HashMap::new();
        for rec in records {
            *buckets.entry(rec.weather.as_str()).or_insert(0) += rec.revenue;
        }

        let mut ranked: Vec<(&str, u32)> = buckets.into_iter().collect();
        ranked.sort_by(|a, b| b.1.cmp(&a.1).then(a.0.cmp(&b.0)));

        println!("=== LutoCLI: Kita kada Panahon ===");
        for (weather, total) in &ranked {
            println!("{:<7} P{}", weather, total);
        }
    }
}

// ============================================
// The counter (src/main.rs in the real layout)
// Takes the order, dispatches to the kitchen,
// never shows Tita Malou a traceback.
// ============================================
fn main() {
    // args[0] is the program itself; args[1] is the subcommand.
    let args: Vec<String> = env::args().collect();

    // ONE funnel for every error in the whole program. No unwrap. Anywhere.
    if let Err(message) = run(&args) {
        eprintln!("{}", message);
        process::exit(1);
    }
}

fn run(args: &[String]) -> Result<(), String> {
    // .get(1) -> Option<&String>, .map(|s| s.as_str()) -> Option<&str>.
    // Option + closures + string slices + exhaustive match, isang linya.
    let command = args.get(1).map(|s| s.as_str());

    // Optional: `lutocli summary ibang-file.csv` reads a different file.
    let file = args.get(2).map(|s| s.as_str());

    match command {
        Some("summary") => report::summary(&load_records(file)?),
        Some("top") => report::top_dishes(&load_records(file)?),
        Some("payday") => report::payday_compare(&load_records(file)?),
        Some("weather") => report::weather_report(&load_records(file)?),
        Some(other) => {
            println!("Pasensya na, hindi ko kilala ang utos na '{}'.\n", other);
            print_usage();
        }
        None => print_usage(),
    }
    Ok(())
}

/// File -> lines -> parsed records. Every failure becomes a friendly sentence.
/// No file at all? The embedded sample steps in — LutoCLI never ships broken.
fn load_records(requested: Option<&str>) -> Result<Vec<SaleRecord>, String> {
    let (contents, source) = match requested {
        // She asked for a specific file: it must exist, or she gets the sentence.
        Some(path) => {
            let text = fs::read_to_string(path).map_err(|_| missing_file_message(path))?;
            (text, path.to_string())
        }
        // Default: the real notebook if it's there, else the embedded sample.
        None => match fs::read_to_string(DATA_FILE) {
            Ok(text) => (text, DATA_FILE.to_string()),
            Err(_) => {
                println!("(Walang '{}' sa folder — ginagamit ang built-in sample data.)\n", DATA_FILE);
                (SAMPLE_CSV.to_string(), String::from("built-in sample"))
            }
        },
    };

    let mut records = Vec::new();
    for (i, line) in contents.lines().skip(1).enumerate() {
        if line.trim().is_empty() {
            continue; // a blank line is not a crime
        }
        let rec = record::parse_line(line)
            .map_err(|why| format!("Problema sa row {} ng '{}': {}", i + 2, source, why))?;
        records.push(rec);
    }
    Ok(records)
}

fn missing_file_message(path: &str) -> String {
    if path != DATA_FILE && Path::new(DATA_FILE).exists() {
        format!("Hindi mahanap ang file na '{}'. Baka ang ibig mo sabihin ay '{}'?", path, DATA_FILE)
    } else {
        format!("Hindi mahanap ang file na '{}'. Siguraduhing nasa tabi ito ng lutocli — parehong folder, parehong spelling.", path)
    }
}

fn print_usage() {
    println!("LutoCLI v1.0 — sales tool ng carinderia ni Tita Malou");
    println!("Gamit / Usage: lutocli <utos>\n");
    println!("Mga utos / Commands:");
    println!("  summary   Bilang ng rows, kabuuang kita, average kada row");
    println!("  top       Top 3 ulam ayon sa servings");
    println!("  payday    Kita tuwing quincena vs ordinaryong araw");
    println!("  weather   Kita kada klase ng panahon\n");
    println!("Halimbawa / Example: lutocli summary");
}
