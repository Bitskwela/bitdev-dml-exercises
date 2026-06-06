// ============================================
// ERROR HANDLING — Lesson 16
// by: <Your Name>
// ============================================
// The Sunday crash, replayed in Rust. Same messy
// data. This time the failure is a value we open,
// not a traceback with an audience.
// ============================================

// .parse::<u32>() returns Result<u32, ParseIntError> — never a bare number.
fn parse_price(s: &str) -> Result<u32, std::num::ParseIntError> {
    // TODO: trim `s`, parse it with .parse::<u32>(), and put `?` after the
    // call so any Err returns to the caller RIGHT HERE, unopened. Then wrap
    // the parsed number in Ok(...). This function never panics.
    todo!()
}

fn main() {
    println!("=== Carinderia Sales: Sunday Replay ===");
    println!("(prices in whole pesos, u32)\n");

    // The digitized notebook, exactly as messy as real life:
    // good rows, a row with stray spaces, garbage text, a BLANK —
    // the same blank that killed sales_report.py on row 113.
    let raw_prices = ["120", " 95 ", "abc", "", "210"];

    let mut total: u32 = 0;
    let mut parsed_rows: u32 = 0;
    let mut skipped_rows: u32 = 0;

    for raw in raw_prices {
        // Every row gets the SAME exhaustive treatment. No row can
        // surprise us, because the compiler makes us answer for both arms.
        match parse_price(raw) {
            Ok(price) => {
                // TODO: add `price` to `total`, count the row in
                // `parsed_rows`, then print:  ok    '{raw}' -> P{price}
                let _ = price; // (delete this line once you use `price`)
            }
            Err(_) => {
                // TODO: count the row in `skipped_rows`, then print the
                // polite warning:  warn  Hindi ma-parse ang '{raw}' — nilaktawan
            }
        }
    }

    println!("\nParsed rows:  {parsed_rows}");
    println!("Skipped rows: {skipped_rows}");
    println!("Total kita:   P{total}");

    println!("\nDalawang sirang row, zero crash.");
    println!("Sorry, Sunday lunch — hindi na mauulit.");
}
