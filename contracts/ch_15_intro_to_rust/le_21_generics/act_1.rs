// ============================================
// GENERICS — Lesson 21
// by: <Your Name>
// ============================================
// One ladle, many pots: ONE generic function
// instead of one per type. <T: PartialOrd + Copy>
// is the contract: PartialOrd makes `>` legal,
// Copy makes returning by value legal. Remove
// either and the compiler names what's missing.
// ============================================

// ===== Task 1: the ladle — ONE function, any orderable + copyable T =====
fn largest<T: PartialOrd + Copy>(list: &[T]) -> T {
    // TODO: start with list[0] as `biggest`, walk the slice with
    // `for &item in list`, keep whichever is bigger, return it.
    // Same body Dan wrote for largest_u32 — the types just became blanks.
    todo!()
}

// ===== Task 4: the other end of the ladle =====
fn smallest<T: PartialOrd + Copy>(list: &[T]) -> T {
    // TODO: same shape as `largest`, comparison flipped.
    // Same contract, same reasons: PartialOrd for `<`, Copy for `-> T`.
    todo!()
}

// ===== Task 3: a generic struct — the label is always a String,
// the value is whatever T turns out to be =====
struct Tagged<T> {
    label: String,
    value: T,
}

// The <T> after `impl` DECLARES the placeholder;
// the <T> after `Tagged` uses it.
impl<T> Tagged<T> {
    fn new(label: &str, value: T) -> Tagged<T> {
        // TODO: build and return the struct —
        // label.to_string() for the label, `value` as-is.
        todo!()
    }
}

fn main() {
    println!("=== LutoCLI Weekly Report: One Ladle, Many Pots ===\n");

    // Sinigang plates sold per day, Monday to Sunday — u32, as always.
    let plates_sold: [u32; 7] = [12, 8, 15, 7, 22, 30, 9];

    // Customer dish ratings from the suki notebook — f64 is allowed
    // here because ratings are NOT money. (Money stays u32. House rule.)
    let ratings: [f64; 5] = [4.5, 3.8, 4.9, 4.2, 4.7];

    // The first pot is already wired: T = u32 for this call.
    let best_day = largest(&plates_sold);
    println!("Best sales day this week: {} plates", best_day);

    // TODO (Task 2): the second pot — call the SAME `largest` on `ratings`
    // (T becomes f64 for that call) and print:
    //   Highest dish rating:      {} stars
    let _ = &ratings; // (delete this line once you use `ratings`)

    // TODO (Task 4): call `smallest` on BOTH arrays and print:
    //   Worst sales day:          {} plates
    //   Lowest dish rating:       {} stars

    // TODO (Task 3): two fillings from ONE struct definition —
    //   let revenue = Tagged::new("kita ngayong Lunes", 1480u32);
    //   let note = Tagged::new("paalala",
    //       String::from("mabenta ang sinigang pag umuulan"));
    // then print:
    //   \n[{}] P{}   with revenue.label, revenue.value
    //   [{}] {}      with note.label, note.value
}
