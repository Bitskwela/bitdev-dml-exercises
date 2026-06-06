// ============================================
// HELLO, WORLD! — Full Solution
// Lesson 3 by Dan Santos
// ============================================
// My first compiled Rust program.
// One source file in, one standalone binary out.
// ============================================

fn main() {
    // --- The welcome banner ---
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
    println!("    Adobo ..................... PHP {}", adobo);
    println!("    Sinigang na Baboy ......... PHP {}", sinigang);
    println!("    Halo-Halo ................. PHP {}", halo_halo);
    println!("    ---------------------------------");
    println!();
    println!("    Bukas araw-araw, 6AM hanggang 8PM.");
    println!("    Salamat sa lahat ng suki!");
}
