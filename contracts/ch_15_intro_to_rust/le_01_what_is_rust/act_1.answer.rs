// ============================================
// WHAT IS RUST? — Full Solution
// Lesson 1 by Dan Santos
// ============================================
// No installation needed yet. Run this at:
// https://play.rust-lang.org
// ============================================

fn main() {
    let line = "=".repeat(52);

    println!("{}", line);
    println!("   LutoCLI: THE RELIABILITY PROMISE");
    println!("{}", line);
    println!();

    // -- What happened last Sunday (Python, runtime crash) --
    println!("Last Sunday, in Python:");
    println!("   - 40 seconds just to start on the old laptop");
    println!("   - 1 blank cell in the digitized notebook");
    println!("   - KeyError: 'weather' -- crashed mid-demo");
    println!();

    // -- What Rust is promising instead --
    println!("The Rust deal:");
    println!("   - One compiled file. No Python. No internet.");
    println!("   - Starts in milliseconds on the old desktop");
    println!("   - Whole bug families REFUSED at compile time");
    println!();

    let best_seller = String::from("Sinigang");
    let kita_today: u32 = 4250; // whole pesos — u32, always

    println!("Sample report line (the future LutoCLI):");
    println!("   Best-seller: {}", best_seller);
    println!("   Kita today:  P{}", kita_today);
    println!();
    println!("Promise to Tita Malou: if it compiles, it runs.");

    // ===== THE WHOLE COURSE IN THREE LINES =====
    // Uncomment the three lines below and press Run.
    // The compiler will REFUSE to build the program.
    // That refusal is the entire point of this course.
    //
    // let order = String::from("Sinigang");
    // let moved = order;             // ownership of the String MOVES to `moved`
    // println!("Order: {}", order);  // using `order` after the move -- REFUSED
}
