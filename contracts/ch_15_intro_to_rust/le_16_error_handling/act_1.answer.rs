// ============================================
// ERROR HANDLING — Full Solution
// Lesson 16 by Dan Santos
// ============================================
// The Sunday crash, replayed in Rust. Same messy
// data. This time the failure is a value we open,
// not a traceback with an audience.
// ============================================

// .parse::<u32>() returns Result<u32, ParseIntError> — never a bare number.
// The `?` says: if Ok, hand me the value; if Err, return it to the caller
// RIGHT HERE and let them decide. This function never panics.
fn parse_price(s: &str) -> Result<u32, std::num::ParseIntError> {
    let price = s.trim().parse::<u32>()?;
    Ok(price)
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
        // surprise us, because the compiler made us answer for both arms.
        match parse_price(raw) {
            Ok(price) => {
                total += price;
                parsed_rows += 1;
                println!("ok    '{raw}' -> P{price}");
            }
            Err(_) => {
                skipped_rows += 1;
                println!("warn  Hindi ma-parse ang '{raw}' — nilaktawan");
            }
        }
    }

    println!("\nParsed rows:  {parsed_rows}");
    println!("Skipped rows: {skipped_rows}");
    println!("Total kita:   P{total}");

    println!("\nDalawang sirang row, zero crash.");
    println!("Sorry, Sunday lunch — hindi na mauulit.");
}
