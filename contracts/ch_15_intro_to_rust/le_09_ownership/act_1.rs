// ============================================
// OWNERSHIP — Lesson 9
// by: <Your Name>
// ============================================
// Four stops:
//   1. The wall   — a String moves into a function; the old binding dies
//   2. Fix v1     — clone(): pay for a real copy, keep the original
//   3. Fix v2     — return the String back (hand the key back)
//   4. Copy types — u32 never moves; numbers are photocopied keys
// ============================================

fn main() {
    // ===== PART 1: the wall =====
    println!("=== PART 1: the wall ===");

    // One value, one owner: `order` owns this String.
    let order = String::from("2x sinigang, 1x extra rice");

    // Passing a String to a function MOVES ownership into it.
    // This line hands over the cash-drawer key. After it, `order`
    // here in main is INVALID — not empty, not null: gone.
    print_order(order);

    // TODO(1): uncomment the line below, run `cargo check`, and meet
    // error[E0382]: borrow of moved value — in person. Do the four-part
    // read: headline, the `value moved here` arrow, the `value borrowed
    // here after move` arrow, the note naming print_order as the
    // key-taker, and the `help:` patch. Then RE-COMMENT the line.
    //
    // println!("Saving to the record: {}", order);

    // ===== PART 2: fix v1 — clone() =====
    println!("\n=== PART 2: fix v1 — clone() ===");

    let order = String::from("1x adobo, 1x rice"); // fresh String, fresh owner

    // TODO(2): add .clone() to the call below — the CLONE (a real second
    // String on the heap) moves into the function and the original never
    // leaves us. Then uncomment the save line. Without the clone, the
    // save line is E0382 all over again.
    print_order(order);
    // println!("Saving to the record: {}", order);

    // ===== PART 3: fix v2 — return the key =====
    println!("\n=== PART 3: fix v2 — return the key ===");

    let order = String::from("3x tortang talong");

    // The function takes ownership... then hands it BACK as the return
    // value. We catch it by shadowing — the Lesson 4 trick. The body of
    // print_and_return is yours to write: see TODO(3) below main.
    let order = print_and_return(order);

    println!("Saving to the record: {}", order); // legal: the key came home

    // ===== PART 4: Copy types don't move =====
    println!("\n=== PART 4: Copy types don't move ===");

    let price: u32 = 95; // whole pesos, as always since Lesson 5

    // u32 lives entirely on the stack. Copying four bytes is one
    // cheap instruction, so Rust just COPIES it into the function.
    print_price(price);

    // TODO(4): call print_price(price) a SECOND time, then print
    //   "Price is still ours: ₱{price}"
    // Both lines compile — no move, no funeral, no E0382. u32 is a
    // Copy type: the function only ever received a photocopy.
}

// Takes OWNERSHIP of the String (the parameter type is plain `String`).
fn print_order(order: String) {
    println!("Kitchen receives: {}", order);
} // <- `order` is dropped HERE: owner left the scope, heap memory freed.

// Takes ownership too — and must hand the key back out.
fn print_and_return(order: String) -> String {
    // TODO(3): print "Kitchen receives: {}" with the order, then make
    // `order` the LAST LINE with no semicolon — an expression, not a
    // statement. That tail expression is the return value: ownership
    // moves back OUT to whoever called us.
    todo!()
}

// u32 is a Copy type: this function receives a photocopy, not the original.
fn print_price(price: u32) {
    println!("Kitchen quotes:  ₱{}", price);
}
