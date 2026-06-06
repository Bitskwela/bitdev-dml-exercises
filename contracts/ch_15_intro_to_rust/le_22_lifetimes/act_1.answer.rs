// ============================================
// LIFETIMES — Full Solution
// Lesson 22 by Dan Santos
// ============================================
// Lifetime annotations DESCRIBE relationships
// between borrows. They never extend anything.
// ============================================

// ===== The error that started the night =====
// Dan's first attempt — no 'a anywhere. Uncomment this
// function and run `cargo check` to meet it in person:
// error[E0106]: missing lifetime specifier
//
// fn longest_dish_name(a: &str, b: &str) -> &str {
//     if a.len() > b.len() { a } else { b }
// }

// ===== The fix: one 'a, one promise, written down =====
// "The returned reference is only valid while BOTH
// inputs are still valid — whichever dies first wins."
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() { x } else { y }
}

// ===== A struct that BORROWS instead of owning =====
// Course rule since Lesson 12: structs own String. This is
// the one borrowed-field struct we'll write, to see exactly
// what that rule has been protecting us from.
struct BestSeller<'a> {
    name: &'a str,
}

fn main() {
    println!("=== LutoCLI: Specials Board ===\n");

    // ===== Part 1: longest() on two dish names =====
    let dish_a = String::from("Sinigang na Baboy");
    let dish_b = String::from("Adobo");

    let headline = longest(&dish_a, &dish_b);
    println!("Headline dish: {}", headline);
    // Both owners are alive on the line above,
    // so the promise holds. No drama.

    // ===== Part 2: the scope puzzle =====
    // 2a. COMPILES — the result's last use happens while
    //     BOTH inputs are still alive.
    let main_dish = String::from("Lechon Kawali");
    {
        let merienda = String::from("Turon");
        let featured = longest(&main_dish, &merienda);
        println!("Featured this week: {}", featured);
        // `featured` is done being used HERE, while
        // `merienda` is still alive. Promise kept.
    }

    // 2b. DOES NOT COMPILE — the inner String dies while
    //     the result is still needed. Uncomment to meet
    //     error[E0597]: `merienda` does not live long enough
    //
    // let featured;
    // {
    //     let merienda = String::from("Turon");
    //     featured = longest(&main_dish, &merienda);
    // } // <- merienda is dropped HERE...
    // println!("Featured this week: {}", featured); // ...but used here

    // ===== Part 3: BestSeller borrows from an owned String =====
    let top_dish = String::from("Kare-Kare");
    let poster = BestSeller { name: &top_dish };
    println!("\nBest-seller poster: {}", poster.name);
    // Compiles because `top_dish` outlives `poster` —
    // the struct's 'a is exactly that promise, written down.
}
