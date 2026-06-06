// ============================================
// FUNCTIONS — Full Solution / Lesson 6
// by Dan Santos
// Money is u32 whole pesos (Lesson 5 rules).
// ============================================

// Sukli math. Written ONCE, called everywhere.
fn compute_change(paid: u32, total: u32) -> u32 {
    paid - total // no semicolon: this expression IS the return value
}

// 20% senior citizen discount — mandated by law in the Philippines (RA 9994).
fn apply_senior_discount(total: u32) -> u32 {
    total - (total * 20 / 100)
}

// `&str` is a borrowed string — the full story is Lesson 12.
fn receipt_line(dish: &str, price: u32) -> String {
    format!("{:<18} ₱{:>4}", dish, price)
}

// THE TRAP — uncomment this and the compiler refuses to build:
// fn compute_change_broken(paid: u32, total: u32) -> u32 {
//     paid - total; // that semicolon turns the value into ()
// }

fn main() {
    println!("===== LUTO CARINDERIA — Order #042 =====");
    println!();

    // Lola Cion's order: suki, senior citizen, same ulam every Tuesday.
    let sinigang: u32 = 95;
    let rice: u32 = 15;
    let extra_rice: u32 = 15;

    println!("{}", receipt_line("Sinigang na Baboy", sinigang));
    println!("{}", receipt_line("Kanin", rice));
    println!("{}", receipt_line("Extra Kanin", extra_rice));
    println!("------------------------------");

    let subtotal = sinigang + rice + extra_rice;
    println!("{}", receipt_line("Subtotal", subtotal));

    let total = apply_senior_discount(subtotal);
    println!("{}", receipt_line("Senior 20% off", total));

    let paid: u32 = 200;
    let sukli = compute_change(paid, total);
    println!("{}", receipt_line("Bayad", paid));
    println!("{}", receipt_line("Sukli", sukli));
    println!();
    println!("Salamat po, Lola. Balik kayo bukas!");
}
