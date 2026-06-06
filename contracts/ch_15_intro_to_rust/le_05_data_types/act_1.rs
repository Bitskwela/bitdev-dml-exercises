// ============================================
// DATA TYPES — Lesson 5
// by: <Your Name>
// ============================================
// Ring up one sale, GCash-and-cash hour.
// Complete the TODOs, then `cargo run`.
// ============================================

fn main() {
    // ===== Task 1: the sale, fully annotated — reads like a receipt =====
    // TODO: replace the placeholder values with the real morning:
    //       3 orders, ₱95 each, payday is true, the symbol is '₱', rating 4.6
    let quantity: u32 = 0;        // three orders of sinigang
    let price: u32 = 0;           // pesos are u32 in this course — JM's rule
    let is_payday: bool = false;  // the 15th. Quincena. The counter is busy.
    let peso_symbol: char = '?';  // one char — a 4-byte Unicode scalar
    let avg_rating: f64 = 0.0;    // floats exist — for NOT-money numbers

    // ===== Task 2: type inference + the sukli math =====
    // No type written on `bill`, but the subtraction you write below
    // forces it to be u32. The compiler reads the whole function first.
    let bill = 500;

    // TODO: compute `total` (quantity * price) and `sukli` (bill - total)
    let total = quantity; // TODO: replace with the real multiplication
    let sukli = bill;     // TODO: replace with the real subtraction

    println!("=================================");
    println!("   CARINDERIA NI ALING MALOU");
    println!("=================================");
    println!("payday today?       {}", is_payday);
    println!("average rating:     {} stars", avg_rating);
    println!("{} x sinigang  @  {}{} each", quantity, peso_symbol, price);
    println!("total:              {}{}", peso_symbol, total);
    println!("cash received:      {}{}", peso_symbol, bill);
    println!("sukli:              {}{}", peso_symbol, sukli);
    println!();

    // ===== Kuya JM's war story, reproduced in two lines =====
    let point_one: f64 = 0.1;
    let point_two: f64 = 0.2;
    println!("0.1 + 0.2         = {}", point_one + point_two);
    println!("0.1 + 0.2 == 0.3? {}", point_one + point_two == 0.3);
    println!();

    // ===== A char is NOT one byte =====
    let enye: char = 'ñ';
    println!(
        "'{}' and '{}' are one char each — {} bytes in memory",
        peso_symbol,
        enye,
        std::mem::size_of::<char>()
    );

    // ===== Task 3: the experiment the compiler refuses =====
    // A suki asked: "Kuya, abot pa ba ng balance ko?" Her GCash app
    // shows decimals, so Dan typed the balance as f64.
    // TODO: uncomment the four lines below, run `cargo check`, and meet
    //       error[E0308]: mismatched types. Then make it compile with an
    //       explicit `as` cast — and defend WHICH side of `>=` you convert.

    // let gcash_balance: f64 = 358.25;
    // if gcash_balance >= total {
    //     println!("Sapat ang balance mo, suki!");
    // }
}
