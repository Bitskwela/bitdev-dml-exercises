// ============================================
// MINI PROJECT: LUTOCLI — Lesson 25
// by: <Your Name>
// ============================================
// Ship day. In the real shipped project this is three
// files — src/main.rs (the counter), src/record.rs (the
// prep station), src/report.rs (the kitchen). Here the
// stations are inline `mod` blocks so ONE file carries
// the whole tool. House rules: zero unwrap(), zero
// expect() — every failure becomes a sentence Tita
// Malou can read.
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
        // TODO(Task 1):
        //  1. let fields: Vec<&str> = line.split(',').collect();
        //  2. if fields.len() != 7 -> return Err with a friendly sentence
        //     that names the field count AND quotes the full row.
        //  3. parse fields[2] (quantity) and fields[3] (revenue) as u32:
        //     fields[2].trim().parse().map_err(|_| format!("hindi mabasa ang quantity na '{}' — dapat buong numero.", fields[2]))?
        //     (same move for revenue: "dapat buong piso.")
        //  4. Ok(SaleRecord { item: fields[1].to_string(), quantity, revenue,
        //     day_of_week: fields[4].to_string(), is_payday: fields[5] == "True",
        //     weather: fields[6].trim().to_string() })
        todo!()
    }

    #[cfg(test)]
    mod tests {
        use super::*;

        // Tests can return Result too — even our proofs get to use `?`.
        // TODO(Task 1): remove the #[ignore] once parse_line is implemented.
        #[test]
        #[ignore]
        fn payday_row_parses() -> Result<(), String> {
            let rec = parse_line("2026-05-15,Halo-Halo,16,960,Friday,True,sunny")?;
            assert_eq!(rec.item, "Halo-Halo");
            assert_eq!(rec.revenue, 960);
            assert!(rec.is_payday);
            Ok(())
        }

        // TODO(Task 1): the notebook says "sixteen"? Prove LutoCLI answers
        // with a sentence, not a crash:
        //   assert!(parse_line("2026-05-15,Halo-Halo,sixteen,960,Friday,True,sunny").is_err());
        #[test]
        fn written_out_number_is_rejected_politely() {
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
        // TODO(Task 2): total kita (sum of revenue), row count, average
        // (guard the zero-row case!), then the strongest day: tally a
        // HashMap<&str, u32> keyed by day_of_week, take .max_by_key.
        // Print exactly:
        //   === LutoCLI: Buod ng Benta ===
        //   Rows sa notebook:  {count}
        //   Kabuuang kita:     P{total}
        //   Average kada row:  P{average}
        //   Pinakamalakas:     {day} (P{kita} sa buong buwan)
        let _ = records; // (delete once you use `records`)
        let _ = HashMap::<&str, u32>::new(); // (delete once you build the real tally)
        todo!()
    }

    pub fn top_dishes(records: &[SaleRecord]) {
        // TODO(Task 2): tally servings per item with entry().or_insert(0),
        // collect into a Vec, sort most-servings-first (tie: alphabetical,
        // para deterministic), print the top 3:
        //   === LutoCLI: Top 3 Ulam (by servings) ===
        //   1. Halo-Halo          50 servings
        let _ = records;
        todo!()
    }

    pub fn payday_compare(records: &[SaleRecord]) {
        // TODO(Task 2): filter is_payday vs !is_payday — total, row count,
        // and average for each side (guard divide-by-zero). Print both
        // lines, then if payday_avg > ordinary_avg:
        //   Quincena effect: TOTOO. Mas malakas ang benta tuwing sweldo.
        let _ = records;
        todo!()
    }

    pub fn weather_report(records: &[SaleRecord]) {
        // TODO(Task 2): HashMap buckets keyed by weather, sum revenue per
        // bucket, sort descending (tie: alphabetical), print each:
        //   sunny   P10045
        let _ = records;
        todo!()
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
        // TODO(Task 3): add the two missing arms —
        //   Some("payday")  => report::payday_compare(&load_records(file)?),
        //   Some("weather") => report::weather_report(&load_records(file)?),
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
