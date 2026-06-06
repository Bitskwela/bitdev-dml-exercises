// ============================================
// TESTING — Lesson 23
// by: <Your Name>
// ============================================
// LutoCLI's money core. The functions are done — veterans, all of them:
//   compute_change       — Lesson 6 (with the Lesson 16 guard)
//   senior_discount      — FIXED after Dan's red night (see the comment)
//   parse_price          — Lesson 16, unchanged
//   split_tips_or_panic  — the Challenge stars here
//   merienda_combo_price — Tita Malou's new promo, Dan's DRAFT (Task 3!)
// The CHECKERS are yours to write. Run them with: cargo test
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
    // THE INFAMOUS BUG (caught by test_senior_discount_99):
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
/// CALLER, so panicking is allowed. (See the Challenge.)
fn split_tips_or_panic(total: u32, people: u32) -> u32 {
    if people == 0 {
        panic!("hatian sa zero staff? imposible");
    }
    total / people
}

/// Spec, per Tita Malou: "Tatlo o higit pa na merienda items, 10% off."
/// Three OR MORE. This is Dan's DRAFT — nobody has tested it yet.
fn merienda_combo_price(price_each: u32, count: u32) -> u32 {
    let total = price_each * count;
    if count > 3 {
        total - total * 10 / 100
    } else {
        total
    }
}

fn main() {
    println!("=== LutoCLI money core — now with receipts ===\n");

    let senior_price = senior_discount(99);
    println!("P99 order, senior price:  P{}", senior_price);
    println!("Sukli from P100:          P{}", compute_change(100, senior_price));
    println!("Parsed menu price:        P{}", parse_price(" 95 ").unwrap_or(0));
    println!("Tip jar P450 / 3 staff:   P{} each", split_tips_or_panic(450, 3));
    println!("Merienda combo (3 turon): P{}", merienda_combo_price(25, 3));

    println!("\n(Don't take main()'s word for any of this. Run: cargo test)");
}

// =====================================================
// THE TESTS — compiled ONLY when you run `cargo test`.
// Tita Malou's USB-stick binary carries none of this.
// Two checkers are written for you. The rest are YOURS.
// =====================================================
#[cfg(test)]
mod tests {
    use super::*; // pull in every function from the parent module

    // DONE — study the shape: call the function, assert the known answer.
    // A test passes by finishing, fails by panicking.
    #[test]
    fn test_compute_change_exact_payment() {
        assert_eq!(compute_change(100, 100), 0);
    }

    // DONE — the friendly input. Every step divides cleanly, so truncation
    // never gets to lie. This test PASSED even while senior_discount was
    // broken. Friendly inputs vouch for buggy functions.
    #[test]
    fn test_senior_discount_80() {
        assert_eq!(senior_discount(80), 64);
        assert_ne!(senior_discount(80), 80, "discount dapat may binawas");
    }

    #[test]
    fn test_compute_change_sukli() {
        // TODO: write this test (Task 1).
        // P500 paid on a P387 order must return P113. Use assert_eq! with
        // the custom message:  "sukli dapat {}", expected
    }

    #[test]
    fn test_senior_discount_99() {
        // TODO: write this test (Task 1).
        // The ugly input — the one that convicted the old formula.
        // Ledger: P99 -> P19 discount -> P80 to pay. Use assert_eq! with
        // the message:  "Lola Cion's P99 order: dapat P{}", expected
    }

    #[test]
    fn test_parse_price_rejects_garbage() {
        // TODO: write this test (Task 1).
        // assert! that parse_price("tatlong piso").is_err()
        // and that parse_price("").is_err() — yes, the row-113 blank.
    }

    #[test]
    fn test_combo_exactly_3_gets_discount() {
        // TODO: write this test (Task 3) — the boundary hunt.
        // 3 turon at P25 each = P75, minus 10% (P7) = P68. Use assert_eq!
        // with the message: "spec says 3 OR MORE items get the discount"
        // Then run `cargo test combo`, READ the failure, and fix the
        // FUNCTION (not the test!).
    }
}
