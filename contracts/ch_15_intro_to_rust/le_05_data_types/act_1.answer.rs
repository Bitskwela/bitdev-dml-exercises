// ============================================
// DATA TYPES — Full Solution
// Lesson 5 by Dan Santos
// ============================================
// Ringing up one sale, GCash-and-cash hour.
// ============================================

fn main() {
    // ===== The sale, fully annotated — reads like a receipt =====
    let quantity: u32 = 3;        // three orders of sinigang
    let price: u32 = 95;          // pesos are u32 in this course — JM's rule
    let is_payday: bool = true;   // the 15th. Quincena. The counter is busy.
    let peso_symbol: char = '₱';  // one char — a 4-byte Unicode scalar
    let avg_rating: f64 = 4.6;    // floats exist — for NOT-money numbers

    // ===== Type inference: no annotation needed here =====
    // No type written, but `bill - total` below forces `bill` to be u32.
    // The compiler reads the whole function before deciding.
    let bill = 500;

    // ===== The sukli math — u32 in, u32 out =====
    let total = quantity * price; // u32 * u32 -> u32 (inferred)
    let sukli = bill - total;     // 500 - 285 = 215

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

    // ===== Task 3 solved: the comparison the compiler refused =====
    // Typed bare, `gcash_balance >= total` is f64 vs u32 ->
    // error[E0308]: mismatched types. The fix: cast the integer UP —
    // u32 -> f64 is exact, every u32 fits in an f64 losslessly.
    // Casting the float DOWN (`gcash_balance as u32`) would truncate
    // 358.25 to 358, silently throwing away ₱0.25 of someone's money.
    let gcash_balance: f64 = 358.25;
    if gcash_balance >= total as f64 {
        println!("Sapat ang balance mo, suki!");
    }
}
