// ============================================
// LIFETIMES — Lesson 22
// by: <Your Name>
// ============================================
// Lifetime annotations DESCRIBE relationships
// between borrows. They never extend anything.
// No 'a has ever kept a value alive longer.
// ============================================

// ===== TODO 1: describe the borrow =====
// Dan's three-liner, exactly as it met E0106:
//   error[E0106]: missing lifetime specifier
// The return type borrows, but the signature never says whether
// the borrow comes from `x` or `y` — so a caller's borrow checker
// has nothing to verify against.
//
// TODO: add the lifetime annotations and uncomment.
// (<'a> after the name, 'a on both inputs, 'a on the return.
// The promise you are writing down: the result is borrowed from
// an input, so it expires when the SHORTER-lived input dies.)
//
// fn longest(x: &str, y: &str) -> &str {
//     if x.len() > y.len() { x } else { y }
// }

// ===== TODO 2: a struct that BORROWS instead of owning =====
// Course rule since Lesson 12: structs own String. This is the one
// borrowed-field struct we write, to see exactly what that rule has
// been protecting us from. A reference field demands a schedule:
//
// TODO: declare <'a> on the struct, label the field &'a str,
// and uncomment. The promise: no BestSeller value may outlive
// the string its `name` borrows from.
//
// struct BestSeller {
//     name: &str, // E0106 here too: missing lifetime specifier
// }

fn main() {
    println!("=== LutoCLI: Specials Board ===\n");

    // ===== Part 1: longest() on two dish names =====
    // TODO 3: once longest<'a> is alive, uncomment. Both owners
    // live to the end of main, so the promise holds trivially.
    //
    // let dish_a = String::from("Sinigang na Baboy");
    // let dish_b = String::from("Adobo");
    // let headline = longest(&dish_a, &dish_b);
    // println!("Headline dish: {}", headline);

    // ===== Part 2: the scope puzzle =====
    // TODO 4: PREDICT FIRST — does this block compile? Write your
    // answer below, THEN uncomment and let `cargo check` grade you.
    // (Lesson 10's rule decides it: a borrow lives to its LAST USE,
    // not to the closing brace.)
    //
    // My prediction: ____
    //
    // let main_dish = String::from("Lechon Kawali");
    // {
    //     let merienda = String::from("Turon");
    //     let featured = longest(&main_dish, &merienda);
    //     println!("Featured this week: {}", featured);
    //     // `featured`'s last use happens HERE, while `merienda`
    //     // is still alive. Promise kept.
    // }

    // This one DOES NOT compile — the inner String dies while the
    // result is still needed. Keep it commented; uncomment only to
    // meet the error in person, then re-comment and go green:
    //   error[E0597]: `merienda` does not live long enough
    //
    // let featured;
    // {
    //     let merienda = String::from("Turon");
    //     featured = longest(&main_dish, &merienda);
    // } // <- merienda is dropped HERE...
    // println!("Featured this week: {}", featured); // ...but used here

    // ===== Part 3: BestSeller borrows from an owned String =====
    // TODO 5: once BestSeller<'a> is alive, uncomment. It compiles
    // because `top_dish` outlives `poster` — the struct's 'a is
    // exactly that promise, written down.
    //
    // let top_dish = String::from("Kare-Kare");
    // let poster = BestSeller { name: &top_dish };
    // println!("\nBest-seller poster: {}", poster.name);
}
