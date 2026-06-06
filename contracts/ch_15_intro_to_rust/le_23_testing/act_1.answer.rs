// ============================================
// TESTING — Full Solution
// Lesson 23 by Dan Santos
// ============================================
// Veterans, all of them:
//   compute_change  — Lesson 6 (now with the Lesson 16 guard)
//   senior_discount — Lesson 6's apply_senior_discount, promoted
//   parse_price     — Lesson 16, unchanged since the Sunday Replay
// Today they stop being "trust me" code. Today they get receipts.
// ============================================

/// Sukli. A short payment HERE is a bug in LutoCLI — the cashier flow
/// upstream already checked — so it panics, loudly. (Lesson 16 policy.)
fn compute_change(paid: u32, total: u32) -> u32 {
    if paid < total {
        panic!("kulang ang bayad: P{} for a P{} order", paid, total);
    }
    paid - total
}

/// 20% senior citizen discount (RA 9994), whole pesos. House rule from
/// Tita Malou's ledger: truncate the DISCOUNT, never the price.
fn senior_discount(total: u32) -> u32 {
    // BUG (caught by test_senior_discount_99):
    //     total * 80 / 100
    // truncates the PRICE instead of the discount.
    // total = 99: 99 * 80 / 100 = 79. The ledger says P80.
    total - total * 20 / 100
}

/// From the digitized-notebook days — Lesson 16, unchanged.
fn parse_price(s: &str) -> Result<u32, std::num::ParseIntError> {
    let price = s.trim().parse::<u32>()?;
    Ok(price)
}

/// Tip jar at closing, split equally. Zero staff is a bug in the
/// CALLER, so panicking is allowed. (The Challenge stars here.)
fn split_tips_or_panic(total: u32, people: u32) -> u32 {
    if people == 0 {
        panic!("hatian sa zero staff? imposible");
    }
    total / people
}

fn main() {
    println!("=== LutoCLI money core — now with receipts ===\n");

    let senior_price = senior_discount(99);
    println!("P99 order, senior price:  P{}", senior_price);
    println!("Sukli from P100:          P{}", compute_change(100, senior_price));
    println!("Parsed menu price:        P{}", parse_price(" 95 ").unwrap_or(0));
    println!("Tip jar P450 / 3 staff:   P{} each", split_tips_or_panic(450, 3));

    println!("\n(Don't take main()'s word for any of this. Run: cargo test)");
}

// =====================================================
// THE TESTS — compiled ONLY when you run `cargo test`.
// Tita Malou's USB-stick binary carries none of this.
// The proof stays in the kitchen; only the dish goes out.
// =====================================================
#[cfg(test)]
mod tests {
    use super::*; // pull in every function from the parent module

    #[test]
    fn test_compute_change_exact_payment() {
        assert_eq!(compute_change(100, 100), 0);
    }

    #[test]
    fn test_compute_change_sukli() {
        let expected = 113;
        assert_eq!(compute_change(500, 387), expected, "sukli dapat {}", expected);
    }

    #[test]
    #[should_panic(expected = "kulang ang bayad")]
    fn test_compute_change_kulang_panics() {
        compute_change(50, 387); // P50 for a P387 order: must panic
    }

    #[test]
    fn test_senior_discount_80() {
        // The friendly input — every step divides cleanly, so truncation
        // never gets to lie. This PASSED even while the function was wrong.
        assert_eq!(senior_discount(80), 64);
        assert_ne!(senior_discount(80), 80, "discount dapat may binawas");
    }

    #[test]
    fn test_senior_discount_99() {
        // The ugly input. Ledger: P99 -> P19 discount -> P80. The bug-catcher.
        let expected = 80;
        assert_eq!(senior_discount(99), expected, "Lola Cion's P99 order: dapat P{}", expected);
    }

    #[test]
    fn test_parse_price_trims_spaces() -> Result<(), String> {
        // A test can return Result — which means `?` works inside it.
        let price = parse_price(" 120 ").map_err(|e| e.to_string())?;
        assert_eq!(price, 120);
        Ok(())
    }

    #[test]
    fn test_parse_price_rejects_garbage() {
        assert!(parse_price("tatlong piso").is_err());
        assert!(parse_price("").is_err());
    }
}
