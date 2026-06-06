// ============================================
// BORROWING — Full Solution
// Lesson 10 by Dan Santos
// ============================================
// Yesterday: clone() as first aid, everywhere.
// Today: zero clones. References BORROW the
// value; ownership never moves.
// ============================================

// A shared reference: read-only. Any number can exist at once.
// (&String works fine — Lesson 11 makes this even better with &str.)
fn print_order(order: &String) {
    println!("ORDER UP: {}", order);
} // the reference `order` dies here — the String it points to does NOT.
  // References never own, so nothing gets dropped.

// An exclusive reference: read-AND-write. Exactly ONE at a time.
fn add_note(order: &mut String) {
    order.push_str(" — extra rice");
}

// The utang bookkeeper. Method calls reach through references on
// their own, but plain arithmetic does NOT — dereference with the star.
fn add_utang(balance: &mut u32, amount: u32) {
    *balance += amount;
}

fn main() {
    println!("=== Tita Malou's Order Board v2 ===");
    println!("(borrow-first edition — zero clones)\n");

    // ===== Part 1: shared borrows — many readers, walang gulo =====
    let order1 = String::from("Sinigang na Baboy + rice");

    print_order(&order1); // lend it...
    print_order(&order1); // ...lend it again, no clone needed...

    let counter_copy = &order1; // ...two MORE readers, alive at the same time
    let kitchen_copy = &order1;
    println!("Counter reads: {}", counter_copy);
    println!("Kitchen reads: {}", kitchen_copy);

    // The owner never lost the String. In Lesson 9 this line needed clone():
    println!("Owner still has: {}\n", order1);

    // ===== Part 2: the exclusive borrow — one hand writes =====
    let mut order2 = String::from("Adobo + rice");
    println!("Before the note: {}", order2);

    add_note(&mut order2); // ONE writer, briefly — then the pen comes back
    println!("After the note:  {}", order2);

    // The &mut ended when add_note returned, so reading is legal again:
    print_order(&order2);
    println!();

    // ===== Part 3: the aliasing rule, broken on purpose =====
    // Uncomment the three lines below to meet error[E0502]:
    //
    // let reader = &order2;   // shared borrow starts...
    // add_note(&mut order2);  // ...&mut while `reader` is still live: DENIED
    // println!("{}", reader); // ...because `reader` is read down here

    // ===== Part 4: the running tab — three writes, one balance =====
    let mut tab: u32 = 0;

    add_utang(&mut tab, 85); // breakfast — the pen comes back after each call
    println!("Suki's tab: P{tab}");
    add_utang(&mut tab, 95); // lunch
    println!("Suki's tab: P{tab}");
    add_utang(&mut tab, 60); // merienda
    println!("Suki's tab: P{tab}");
}
