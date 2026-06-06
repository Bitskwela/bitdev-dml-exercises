// ============================================
// STRUCTS — Full Solution
// Lesson 13 by Dan Santos
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
    // Takes &str (functions take &str), stores String (structs own String).
    fn new(name: &str, price: u32) -> MenuItem {
        MenuItem {
            name: name.to_string(), // borrowed in, owned copy stored
            price,                  // field init shorthand for `price: price`
            is_available: true,     // every new dish starts available
        }
    }

    // Method — `&self` BORROWS the dish to read it. Lesson 10 rules.
    fn display_line(&self) -> String {
        if self.is_available {
            // `{:<20}` left-aligns the name in 20 columns
            format!("{:<20} P{}", self.name, self.price)
        } else {
            format!("{:<20} UBOS NA", self.name)
        }
    }

    // Method — `&mut self` borrows EXCLUSIVELY to change it.
    // Only callable when the instance's binding is `mut`.
    fn apply_discount(&mut self, pct: u32) {
        // integer math, whole pesos — no floats near money
        self.price = self.price * (100 - pct) / 100;
    }
}

fn main() {
    println!("=== Tita Malou's Menu Board v1 ===\n");

    // ===== Part 1: one value per dish, not three =====
    let adobo = MenuItem::new("Adobo", 75);
    let sinigang = MenuItem::new("Sinigang na Baboy", 95);
    let mut halo_halo = MenuItem::new("Halo-Halo", 60);

    // ===== Part 2: dot syntax reads fields =====
    println!(
        "Most expensive ulam today: {} at P{}",
        sinigang.name, sinigang.price
    );

    // ===== Part 3: mutability is per-BINDING =====
    // `adobo` is not mut, so NO field of it can change.
    // Uncomment the line below to meet error[E0594]:
    //
    // adobo.price = 80;  // error[E0594]: cannot assign to `adobo.price`, as `adobo` is not declared as mutable

    // `halo_halo` IS mut — merienda promo, 20% off:
    halo_halo.apply_discount(20);
    println!("Merienda promo! Halo-Halo is now P{}\n", halo_halo.price);

    // ===== Part 4: the board, printed via display_line =====
    println!("----------- MENU -----------");
    println!("{}", adobo.display_line());
    println!("{}", sinigang.display_line());
    println!("{}", halo_halo.display_line());

    // ===== Part 5: {:#?} — the free X-ray from derive(Debug) =====
    println!("\n[debug view of one dish]");
    println!("{:#?}", halo_halo);
}
