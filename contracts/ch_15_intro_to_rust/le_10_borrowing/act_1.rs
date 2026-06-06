// ============================================
// BORROWING — Lesson 10
// by: <Your Name>
// ============================================
// Yesterday: clone() as first aid, everywhere.
// Today: zero clones. References BORROW the
// value; ownership never moves.
// ============================================

// A shared reference: read-only. Any number can exist at once.
// (&String works fine — Lesson 11 makes this even better with &str.)
//
// TODO 1 (part-worked): this reader is done for you — the signature
// takes &String, so calling it LENDS the order instead of moving it.
// Your half of the job is in main: lend `order1` a second time, then
// bind two more simultaneous readers. Zero clones anywhere in this file.
fn print_order(order: &String) {
    println!("ORDER UP: {}", order);
} // the reference `order` dies here — the String it points to does NOT.
  // References never own, so nothing gets dropped.

// An exclusive reference: read-AND-write. Exactly ONE at a time.
//
// TODO 2: append " — extra rice" to the borrowed String with push_str.
// Method calls reach through references on their own — no star needed.
fn add_note(order: &mut String) {
    todo!("order.push_str(...) — make the note land on the REAL order")
}

// The utang bookkeeper. Plain arithmetic does NOT reach through a
// reference on its own — to change the number a &mut u32 points at,
// dereference with the star: *balance += amount;
//
// TODO 3: add `amount` to the number `balance` points at.
fn add_utang(balance: &mut u32, amount: u32) {
    todo!("*balance += amount — without the star you'd be adding to a reference")
}

fn main() {
    println!("=== Tita Malou's Order Board v2 ===");
    println!("(borrow-first edition — zero clones)\n");

    // ===== Part 1: shared borrows — many readers, walang gulo =====
    let order1 = String::from("Sinigang na Baboy + rice");

    print_order(&order1); // lending, not giving — done for you

    // TODO 1 (continued): lend `order1` to print_order ONE more time,
    // then bind two readers alive at the same moment and print each:
    //     let counter_copy = &order1;
    //     let kitchen_copy = &order1;
    //     println!("Counter reads: {}", counter_copy);
    //     println!("Kitchen reads: {}", kitchen_copy);

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
    // Uncomment the three lines below to meet error[E0502], read the
    // three arrows calmly, then re-comment and confirm green:
    //
    // let reader = &order2;   // shared borrow starts...
    // add_note(&mut order2);  // ...&mut while `reader` is still live: DENIED
    // println!("{}", reader); // ...because `reader` is read down here

    // ===== Part 4: the running tab — three writes, one balance =====
    let mut tab: u32 = 0;

    add_utang(&mut tab, 85); // breakfast — done for you
    println!("Suki's tab: P{tab}");

    // TODO 4: two more writes to the SAME balance — lunch (95), then
    // merienda (60) — printing the running tab after EACH call.
    // Expected: P85, then P180, then P240.
}
