// ============================================
// CONTROL FLOW — Lesson 7
// by: <Your Name>
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
    // TODO 1: The rainy branch is done. Add the missing branches:
    //   - `else if` weather == "hot"  -> "Halo-Halo — cool down muna."
    //   - `else if` weather == "cold" -> "Bulalo — perfect for the cold."
    //   - final `else`                -> "Adobo — the classic. You can never go wrong."
    // Every arm must produce a &str, and an arm's last line carries
    // NO semicolon — that's how the arm hands its value to the chain.
    //
    // TODO 3: Merienda mode. If `hour >= 15`, the recommender changes
    // personality and OUTRANKS the weather rules: suggest
    // "Halo-Halo — peak merienda, peak heat." when the weather is "hot",
    // and "Turon — merienda classic, kahit anong panahon." otherwise.
    // The first true condition wins — so where must this branch go?
    // (Hint: an arm's body can itself be an `if` expression.)
    let recommendation: &str = if weather == "rainy" {
        "Sinigang na Baboy — comfort food for a rainy day!"
    } else {
        "TODO — no rule written for this weather yet"
    };

    // --- Price tier ---
    // TODO 2: Replace the hardcoded 70 with a single if-expression:
    // 80 on payday, 70 otherwise. Both arms u32, whole pesos —
    // no mutable dummy variable, no overwrite.
    // Shape: let price: u32 = if <condition> { <value> } else { <value> };
    let price: u32 = 70;

    println!("  Recommendation: {recommendation}");
    println!("  Price tier    : {price} pesos");

    // --- The mistake every Python hand makes on day one ---
    // In Python, `if quantity:` is idiomatic — nonzero means true.
    // In Rust, a number is not a bool.
    //
    // TODO 4: Uncomment the four lines below, run `cargo check`, and read
    // E0308 for yourself: expected `bool`, found integer. Then re-comment
    // them and move on — the fixed version is already live underneath.
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
