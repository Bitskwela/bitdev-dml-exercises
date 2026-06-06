# One Ladle, Many Pots

One generic function serving two element types, and one generic struct holding two different fillings — the weekly report module, with zero copy-paste. Open `act_1.rs` and work through the TODOs in order.

## Task 1: Implement `largest<T>` — the Ladle

The contract is already on the signature: `fn largest<T: PartialOrd + Copy>(list: &[T]) -> T`. Write the body: start with `list[0]` as `biggest`, walk the slice with `for &item in list`, keep whichever is bigger, return it. It's the exact body Dan wrote for `largest_u32` — the types just became blanks. (`PartialOrd` is what makes `>` legal; `Copy` is what makes returning by value out of a borrowed slice legal.)

## Task 2: Two Pots — `&[u32]` and `&[f64]`

The first pot is already wired: `largest(&plates_sold)` finds the best sales day, with `T = u32` for that call. Add the second pot — call the SAME function on `ratings` (`T` becomes `f64`) and print the `Highest dish rating:` line. No `largest_f64` exists anywhere; at compile time, monomorphization stamps out `largest::<u32>` and `largest::<f64>` for you.

## Task 3: `Tagged<T>` — One Struct, Two Fillings

Implement `Tagged::new` (build the struct: `label.to_string()` for the label, `value` as-is — the `<T>` after `impl` declares the placeholder). Then build two values from the ONE definition — `Tagged::new("kita ngayong Lunes", 1480u32)` and `Tagged::new("paalala", String::from("mabenta ang sinigang pag umuulan"))` — and print both. Note what you just made: `Tagged<u32>` and `Tagged<String>`, two distinct concrete types from one blank.

## Task 4: `smallest<T>` — the Other End of the Ladle

The report needs bad news too: worst sales day, lowest rating. Implement `smallest` — same shape as `largest`, comparison flipped — and call it on **both** arrays. Same contract, same reasons: `PartialOrd` for the comparison, `Copy` for the return. If the worst day moved 7 plates and the lowest rating is 3.8 stars, your ladle scoops both directions. (Notice what you did NOT write: `smallest_u32` and `smallest_f64`.)

## Sample Output

```
=== LutoCLI Weekly Report: One Ladle, Many Pots ===

Best sales day this week: 30 plates
Highest dish rating:      4.9 stars
Worst sales day:          7 plates
Lowest dish rating:       3.8 stars

[kita ngayong Lunes] P1480
[paalala] mabenta ang sinigang pag umuulan
```

## Reflection Questions

1. The bound says `T: PartialOrd + Copy`. Why is `Copy` needed at all — what specifically goes wrong with `let mut biggest = list[0];` if `T` could be a non-copy type like `String`? (Lessons 9-10 have the vocabulary: you can't ___ a value out of something you only ___.)
2. Delete `PartialOrd` from the bound and run `cargo check` — the `help:` line of E0369 writes the fix for you. Why CAN'T the compiler simply allow `>` on any `T` and find out at runtime, the way Python would?
3. `Tagged<u32>` and `Tagged<String>` come from one definition. Can you push a `Tagged<u32>` into a `Vec<Tagged<String>>`? Why does the answer prove the blank is "flexible at the definition, locked at every use"?

## Challenge: The Counting Ladle

Tita Malou's actual question will never be "what was the maximum" — it'll be *"ilang araw ba maganda ang benta?"* Write:

```rust
fn count_above<T: PartialOrd>(items: &[T], threshold: T) -> usize {
    // TODO: keep it simple — .iter().filter(...).count()
}
```

Use it twice: on `plates_sold` — how many days sold above **10 plates**? — and on last week's revenues, whole pesos as always:

```rust
let revenues: [u32; 7] = [980, 1240, 1100, 875, 1480, 1830, 960];
```

— how many days above **1000**? Expected answers: **4** days above 10 plates, **4** days above ₱1,000.

Study the contract before you write the body: this signature needs *neither* `Copy` *nor* a returned `T`. You never move an element out — you only *compare* items behind references and count the survivors, and comparing works fine through a reference. The return type is `usize`, a count, no blanks involved. **Bounds are per-function, not per-habit:** demand exactly what the body uses, nothing more. A thinner contract means *more* types can use your ladle.

## What You've Learned

- One generic `largest<T: PartialOrd + Copy>` replaced the `largest_u32`/`largest_f64` twins — written once, monomorphized into concrete copies per type at compile time, zero runtime cost
- Each clause of the bound maps to a line of the body: `PartialOrd` licenses `>`, `Copy` licenses returning by value out of a borrowed slice
- `Tagged<T>` held a `u32` and a `String` from one definition — and the two results are fully distinct concrete types
- Thinner contracts serve more types: `count_above` needed only `PartialOrd`, because its body never moves a `T` out
