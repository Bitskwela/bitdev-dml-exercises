// ============================================
// GENERICS — Full Solution
// Lesson 21 by Dan Santos
// ============================================
// One generic function instead of one per type.
// <T: PartialOrd + Copy> is the contract:
// PartialOrd makes `>` legal, Copy makes
// returning by value legal. Remove either and
// the compiler names exactly what's missing.
// ============================================

// ===== The ladle: ONE function, any orderable + copyable T =====
fn largest<T: PartialOrd + Copy>(list: &[T]) -> T {
    let mut biggest = list[0];
    for &item in list {
        if item > biggest {
            biggest = item;
        }
    }
    biggest
}

// ===== The other end of the ladle: same contract, comparison flipped =====
fn smallest<T: PartialOrd + Copy>(list: &[T]) -> T {
    let mut lowest = list[0];
    for &item in list {
        if item < lowest {
            lowest = item;
        }
    }
    lowest
}

// ===== The same ladle, `where` edition — identical meaning,
// the signature just breathes better. (Pick ONE; defining both
// is defining the same function twice.)
//
// fn largest<T>(list: &[T]) -> T
// where
//     T: PartialOrd + Copy,
// {
//     ...same body...
// }

// ===== A generic struct: the label is always a String,
// the value is whatever T turns out to be =====
struct Tagged<T> {
    label: String,
    value: T,
}

// The <T> after `impl` DECLARES the placeholder;
// the <T> after `Tagged` uses it.
impl<T> Tagged<T> {
    fn new(label: &str, value: T) -> Tagged<T> {
        Tagged {
            label: label.to_string(),
            value,
        }
    }
}

// ===== The broken ladle: PartialOrd missing from the contract.
// Uncomment and run `cargo check` to meet E0369 in person:
//
// fn largest_no_contract<T: Copy>(list: &[T]) -> T {
//     let mut biggest = list[0];
//     for &item in list {
//         if item > biggest {
//             biggest = item;
//         }
//     }
//     biggest
// }

fn main() {
    println!("=== LutoCLI Weekly Report: One Ladle, Many Pots ===\n");

    // Sinigang plates sold per day, Monday to Sunday — u32, as always.
    let plates_sold: [u32; 7] = [12, 8, 15, 7, 22, 30, 9];

    // Customer dish ratings from the suki notebook — f64 is allowed
    // here because ratings are NOT money. (Money stays u32. House rule.)
    let ratings: [f64; 5] = [4.5, 3.8, 4.9, 4.2, 4.7];

    // ONE function, two element types. At compile time the compiler
    // stamps out largest::<u32> and largest::<f64> as separate
    // machine-code functions. Zero generics left at runtime.
    let best_day = largest(&plates_sold);
    let best_rating = largest(&ratings);

    println!("Best sales day this week: {} plates", best_day);
    println!("Highest dish rating:      {} stars", best_rating);

    // The report needs bad news too — same ladle, other direction.
    let worst_day = smallest(&plates_sold);
    let worst_rating = smallest(&ratings);

    println!("Worst sales day:          {} plates", worst_day);
    println!("Lowest dish rating:       {} stars", worst_rating);

    // ===== Tagged<T>: same struct, different fillings =====
    let revenue = Tagged::new("kita ngayong Lunes", 1480u32);
    let note = Tagged::new(
        "paalala",
        String::from("mabenta ang sinigang pag umuulan"),
    );

    println!("\n[{}] P{}", revenue.label, revenue.value);
    println!("[{}] {}", note.label, note.value);
}
