// ============================================
// STRUCTS — Lesson 13
// by: <Your Name>
// ============================================
// One dish = ONE MenuItem, not three loose
// variables. Methods live in `impl`. The
// constructor is an associated function.
// ============================================

// `#[derive(Debug)]` asks the compiler to WRITE the
// `{:?}` printing code for this type. Free X-ray.
#[derive(Debug)]
struct MenuItem {
    name: String, // owned — the Lesson 12 rule: structs own String
    price: u32,   // whole pesos, as always
    is_available: bool,
}

impl MenuItem {
    // Associated function — no `self` parameter.
    // Called with `::`, like String::from.
    fn new(name: &str, price: u32) -> MenuItem {
        // TODO (Task 2): build and return a MenuItem.
        //   - name: &str comes in, store an owned String (.to_string())
        //   - price: field init shorthand (`price,` not `price: price`)
        //   - is_available: every new dish starts available
        let _ = (name, price); // keeps the starter warning-free; delete me
        todo!("Task 2: implement the constructor")
    }

    // Method — `&self` BORROWS the dish to read it. Lesson 10 rules.
    fn display_line(&self) -> String {
        // TODO (Task 3): if self.is_available, return the name
        // left-aligned in 20 columns followed by P + price
        // (the format spec for left-align-in-20 is `:<20`).
        // Otherwise return the name followed by "UBOS NA".
        todo!("Task 3: implement display_line")
    }

    // Method — `&mut self` borrows EXCLUSIVELY to change it.
    // Only callable when the instance's binding is `mut`.
    fn apply_discount(&mut self, pct: u32) {
        // TODO (Task 4): integer math, whole pesos — no floats near
        // money. Multiply first, divide second:
        //   self.price = self.price * (100 - pct) / 100;
        let _ = pct; // keeps the starter warning-free; delete me
        todo!("Task 4: implement apply_discount")
    }
}

fn main() {
    println!("=== Tita Malou's Menu Board v1 ===\n");

    // This dish is built the LONG way — a struct literal, every field
    // spelled out — so the starter runs before you implement anything.
    // Your `new` does the same job in one call. Delete this demo once
    // Part 1 below is live (Task 5).
    let lumpia = MenuItem {
        name: String::from("Lumpiang Shanghai"),
        price: 50,
        is_available: true,
    };
    println!(
        "Struct literal: {} at P{} (available: {})",
        lumpia.name, lumpia.price, lumpia.is_available
    );
    println!("Debug X-ray: {:?}\n", lumpia);

    // ===== Part 1: one value per dish, not three =====
    // TODO: uncomment once `new` is implemented (Task 2)
    // let adobo = MenuItem::new("Adobo", 75);
    // let sinigang = MenuItem::new("Sinigang na Baboy", 95);
    // let mut halo_halo = MenuItem::new("Halo-Halo", 60);

    // ===== Part 2: dot syntax reads fields =====
    // TODO: uncomment once Part 1 is live
    // println!(
    //     "Most expensive ulam today: {} at P{}",
    //     sinigang.name, sinigang.price
    // );

    // ===== Part 3: mutability is per-BINDING =====
    // `adobo` is not mut, so NO field of it can change — try
    // `adobo.price = 80;` once Part 1 is live to meet error[E0594].
    // `halo_halo` IS mut — merienda promo, 20% off:
    // TODO: uncomment once `apply_discount` is implemented (Task 4)
    // halo_halo.apply_discount(20);
    // println!("Merienda promo! Halo-Halo is now P{}\n", halo_halo.price);

    // ===== Part 4: the board, printed via display_line =====
    // TODO: uncomment once `display_line` is implemented (Task 3)
    // println!("----------- MENU -----------");
    // println!("{}", adobo.display_line());
    // println!("{}", sinigang.display_line());
    // println!("{}", halo_halo.display_line());

    // ===== Part 5: {:#?} — the free X-ray from derive(Debug) =====
    // TODO: uncomment once everything above is live
    // println!("\n[debug view of one dish]");
    // println!("{:#?}", halo_halo);
}
