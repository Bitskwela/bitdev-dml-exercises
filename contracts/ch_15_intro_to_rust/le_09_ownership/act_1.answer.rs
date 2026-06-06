// ============================================
// OWNERSHIP — Full Solution — Lesson 9
// by Dan Santos (one hour against the wall)
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

    // Dan's innocent line. Uncomment it, run `cargo check`,
    // and meet error[E0382] in person:
    //
    //   error[E0382]: borrow of moved value: `order`
    //     ----- value moved here                 (the print_order call)
    //     ^^^^^ value borrowed here after move   (this println)
    //   help: consider cloning the value if the performance cost
    //         is acceptable:  print_order(order.clone());
    //
    // println!("Saving to the record: {}", order);

    // ===== PART 2: fix v1 — clone() =====
    println!("\n=== PART 2: fix v1 — clone() ===");

    let order = String::from("1x adobo, 1x rice"); // fresh String, fresh owner

    // .clone() builds a SECOND String on the heap — a real copy.
    // The CLONE moves into the function. The original never left us.
    print_order(order.clone());

    println!("Saving to the record: {}", order); // legal: our key never moved

    // ===== PART 3: fix v2 — return the key =====
    println!("\n=== PART 3: fix v2 — return the key ===");

    let order = String::from("3x tortang talong");

    // The function takes ownership... then hands it BACK as the
    // return value. We catch it by shadowing — the Lesson 4 trick.
    let order = print_and_return(order);

    println!("Saving to the record: {}", order); // legal: the key came home

    // ===== PART 4: Copy types don't move =====
    println!("\n=== PART 4: Copy types don't move ===");

    let price: u32 = 95; // whole pesos, as always since Lesson 5

    // u32 lives entirely on the stack. Copying four bytes is one
    // cheap instruction, so Rust just COPIES it into the function.
    // No move, no funeral, no E0382.
    print_price(price);
    print_price(price); // again, because we still own it
    println!("Price is still ours: ₱{}", price); // and STILL legal
}

// Takes OWNERSHIP of the String (the parameter type is plain `String`).
fn print_order(order: String) {
    println!("Kitchen receives: {}", order);
} // <- `order` is dropped HERE: owner left the scope, heap memory freed.

// Takes ownership too — but the last line hands the key back out.
fn print_and_return(order: String) -> String {
    println!("Kitchen receives: {}", order);
    order // no semicolon: this is the return value — ownership moves OUT
}

// u32 is a Copy type: this function receives a photocopy, not the original.
fn print_price(price: u32) {
    println!("Kitchen quotes:  ₱{}", price);
}
