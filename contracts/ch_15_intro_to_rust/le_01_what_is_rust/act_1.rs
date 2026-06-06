// ============================================
// WHAT IS RUST? — Lesson 1
// by: <Your Name>
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
    // TODO: add two more println! lines to finish the Python side:
    //   "   - 1 blank cell in the digitized notebook"
    //   "   - KeyError: 'weather' -- crashed mid-demo"
    println!();

    // -- What Rust is promising instead --
    println!("The Rust deal:");
    // TODO: add three println! lines for the Rust side of the deal:
    //   "   - One compiled file. No Python. No internet."
    //   "   - Starts in milliseconds on the old desktop"
    //   "   - Whole bug families REFUSED at compile time"
    println!();

    let best_seller = String::from("Sinigang");
    let kita_today: u32 = 4250; // whole pesos — u32, always

    println!("Sample report line (the future LutoCLI):");
    println!("   Best-seller: {}", best_seller);
    println!("   Kita today:  P{}", kita_today);
    println!();
    // TODO: print the promise line:
    //   "Promise to Tita Malou: if it compiles, it runs."

    // ===== THE WHOLE COURSE IN THREE LINES =====
    // After the banner runs cleanly, uncomment the three lines
    // below and press Run. The compiler will REFUSE to build
    // the program. That refusal is the entire point of this course.
    //
    // let order = String::from("Sinigang");
    // let moved = order;             // ownership of the String MOVES to `moved`
    // println!("Order: {}", order);  // using `order` after the move -- REFUSED
}
