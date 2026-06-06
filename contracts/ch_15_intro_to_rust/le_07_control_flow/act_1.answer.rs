// ============================================
// CONTROL FLOW — Full Solution
// Lesson 7 by Dan Santos
// ============================================
// A tiny slice of Luto v1's rule engine, reborn.
// The original was a Python if/elif chain
// (Intro to AI, Lesson 1). Same rules, new
// language — and this time, every condition
// is checked at compile time.
// ============================================

fn main() {
    // --- Today's inputs (hardcoded for now) ---
    let weather: &str = "rainy";
    let is_payday: bool = true;
    let hour: u32 = 14; // 24-hour clock; 14 = 2 PM, mid-ulan rush

    println!("==========================================");
    println!("  ULAM RECOMMENDER v0.1 — Luto v1 reborn");
    println!("==========================================");
    println!("  Weather : {weather}");
    println!("  Payday? : {is_payday}");
    println!("  Hour    : {hour}:00");
    println!();

    // --- The rule engine: the same branches Luto v1 had, now typed ---
    // `if` is an expression, so the WHOLE chain produces one value
    // and `recommendation` is born initialized. No mutable dummy first.
    //
    // Merienda mode OUTRANKS the weather rules — the first true condition
    // wins, so it is checked FIRST. Its arm is itself an `if` expression
    // nested inside an arm: blocks all the way down, every arm still
    // producing a &str.
    let recommendation: &str = if hour >= 15 {
        if weather == "hot" {
            "Halo-Halo — peak merienda, peak heat."
        } else {
            "Turon — merienda classic, kahit anong panahon."
        }
    } else if weather == "rainy" {
        "Sinigang na Baboy — comfort food for a rainy day!"
    } else if weather == "hot" {
        "Halo-Halo — cool down muna."
    } else if weather == "cold" {
        "Bulalo — perfect for the cold."
    } else {
        "Adobo — the classic. You can never go wrong."
    };

    // --- Price tier: if-as-expression. Both arms u32, whole pesos. ---
    let price: u32 = if is_payday { 80 } else { 70 };

    println!("  Recommendation: {recommendation}");
    println!("  Price tier    : {price} pesos");

    // --- The mistake every Python hand makes on day one ---
    // In Python, `if quantity:` is idiomatic — nonzero means true.
    // In Rust, a number is not a bool. Uncomment to meet E0308:
    //
    // let quantity = 3;
    // if quantity {
    //     println!("May order tayo!");
    // }
    //
    // The fix: say what you actually mean.
    let quantity = 3;
    if quantity > 0 {
        println!();
        println!("  ({quantity} orders waiting — tara, luto na.)");
    }
}
