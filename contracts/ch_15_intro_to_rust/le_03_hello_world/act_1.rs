// ============================================
// HELLO, WORLD! — Lesson 3
// by: <Your Name>
// ============================================
// My first compiled Rust program.
// One source file in, one standalone binary out.
// ============================================

fn main() {
    // --- The welcome banner (done for you) ---
    println!("=============================================");
    println!("    Kamusta, Carinderia ni Tita Malou!");
    println!("    Lutong bahay since 2010. Tuloy po kayo!");
    println!("=============================================");
    println!();

    // --- Today's prices, in whole pesos (u32) ---
    // (`let` makes a variable -- full story in Lesson 4.)
    let adobo: u32 = 75;
    let sinigang: u32 = 95;
    let halo_halo: u32 = 60;

    // --- Today's menu, printed with {} placeholders ---
    println!("    ULAM NGAYON");
    println!("    ---------------------------------");

    // TODO: print the Adobo line through a {} placeholder, using `adobo`.
    //       Pattern:  println!("    <dish> ............ PHP {}", <variable>);

    // TODO: print the Sinigang na Baboy line the same way, using `sinigang`.

    // TODO: print the Halo-Halo line the same way, using `halo_halo`.

    println!("    ---------------------------------");
    println!();
    println!("    Bukas araw-araw, 6AM hanggang 8PM.");
    println!("    Salamat sa lahat ng suki!");
}
