// ============================================
// FUNCTIONS — Lesson 6
// by: <Your Name>
// ============================================
// Money is u32 whole pesos (Lesson 5 rules).
// Rule of three: kapag inulit mo ng tatlong
// beses, function na 'yan. Write each helper
// ONCE here, call it everywhere.
// ============================================

// Task 1: Sukli math.
// Formula: change = paid - total
// Remember: the last expression takes NO semicolon —
// that bare expression IS the return value.
fn compute_change(paid: u32, total: u32) -> u32 {
    // TODO: replace todo!() with the formula above
    todo!()
}

// Task 2: 20% senior citizen discount — legally
// mandated in the Philippines (RA 9994).
// Careful: return the total AFTER the discount,
// not the discount amount itself.
fn apply_senior_discount(total: u32) -> u32 {
    todo!()
}

// Task 3: format one receipt line.
// `&str` is a borrowed string — full story in Lesson 12.
// Hint: format!() works like println!() but hands back a String.
fn receipt_line(dish: &str, price: u32) -> String {
    todo!()
}

fn main() {
    println!("===== LUTO CARINDERIA — Order #042 =====");
    println!();

    // Lola Cion's order: suki, senior citizen, same ulam every Tuesday.
    let sinigang: u32 = 95;
    let rice: u32 = 15;
    let extra_rice: u32 = 15;

    let subtotal = sinigang + rice + extra_rice;
    println!("(starter) subtotal so far: ₱{}", subtotal);

    // TODO: uncomment once receipt_line is implemented
    // println!("{}", receipt_line("Sinigang na Baboy", sinigang));
    // println!("{}", receipt_line("Kanin", rice));
    // println!("{}", receipt_line("Extra Kanin", extra_rice));
    // println!("------------------------------");
    // println!("{}", receipt_line("Subtotal", subtotal));

    // TODO: uncomment once all three functions are implemented
    // let total = apply_senior_discount(subtotal);
    // println!("{}", receipt_line("Senior 20% off", total));
    //
    // let paid: u32 = 200;
    // let sukli = compute_change(paid, total);
    // println!("{}", receipt_line("Bayad", paid));
    // println!("{}", receipt_line("Sukli", sukli));
    // println!();
    // println!("Salamat po, Lola. Balik kayo bukas!");
}
