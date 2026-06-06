# Lesson 21 Quiz: Generics

---
# Quiz 1
## Scenario: The Copy-Paste Temptation

Dan has a working `largest_u32` and is two keystrokes away from pasting it as `largest_f64` when Kuya JM calls: "One ladle, many pots." The replacement is one function: `fn largest<T: PartialOrd + Copy>(list: &[T]) -> T`.

**Question 1:** What does the `<T>` in that signature declare?
A. A new struct named `T` that the function creates internally
B. A type parameter — a blank filled in by each CALLER: pass `&[u32]` and `T` becomes `u32` for that call; pass `&[f64]` and `T` becomes `f64`
C. A special compiler keyword that only works with number types
D. A runtime variable holding the type's name as a string

**Answer:** B
**Explanation:** `<T>` declares a placeholder type chosen by whoever calls the function. Declaring it right after the function name is what lets the rest of the signature and body use `T`. One ladle, many pots.

---

**Question 2:** Dan deletes `PartialOrd` from the bound and runs `cargo check`. What happens, and why?
A. It compiles — `>` works on every type
B. It compiles but crashes at runtime the first time two items are compared
C. E0369: "binary operation `>` cannot be applied to type `T`" — comparison operators are trait methods, so without the bound the compiler can't promise `T` is comparable; the `help:` line even writes the missing bound for you
D. The compiler silently adds the bound back

**Answer:** C
**Explanation:** `>` isn't free — it's `PartialOrd` at work, just like `println!("{}")` turned out to be `Display`. The bound is the contract that makes the comparison legal, and E0369's `help:` line literally types the amendment, `+`s and all.

---

**Question 3:** Why does `largest` also demand `Copy`?
A. To make the function run faster
B. Because the body returns an element BY VALUE out of a BORROWED slice — without `Copy`, `let mut biggest = list[0];` is a move out of borrowed data, and E0508 ("cannot move out of a non-copy slice") blocks it; for `Copy` types, taking an element just duplicates it
C. Because `PartialOrd` requires `Copy` as a prerequisite
D. `Copy` is mandatory on every generic function

**Answer:** B
**Explanation:** Ownership law from Lessons 9-10: you can't move a value out of something you only borrowed. `T: Copy` promises every pot holds cheap, duplicable stack values, so scooping is always legal. Each clause of the bound maps to a specific line of the body.

---

**Question 4:** Kuya JM makes Dan read his own LutoCLI code out loud: `Vec<String>`, `Option<u32>`, `HashMap<String, u32>`. How many times did the Rust team write `Vec`?
A. Once per element type — there's a `Vec_u32`, a `Vec_String`, and so on in the standard library
B. Exactly once, as `Vec<T>` — every angle bracket Dan has typed since Lesson 14 was a generic with its blank filled in by him, the caller
C. Twice — once for numbers, once for text
D. Zero times — `Vec` is built into the compiler, not written in Rust

**Answer:** B
**Explanation:** The retroactive reveal: `Vec<T>`, `Option<T>`, and `HashMap<K, V>` were each written once, with type parameters as the blanks. Dan has been a generics customer since Lesson 14 — tonight he became an author.

---

# Quiz 2
## Scenario: The Weekly Report Ships

The report module is done: one `largest`, one `smallest`, one `Tagged<T>`. A groupmate reviews the code and raises some worries.

**Question 5:** The groupmate warns: "Generics mean the program has to figure out types while Tita Malou waits — it'll be slow, like Python." What actually happens at runtime?
A. He's right — every generic call performs a type lookup
B. Nothing generic is left: at COMPILE time, monomorphization stamps out one fully concrete copy per type used (`largest::<u32>`, `largest::<f64>`) — the copy-paste Dan almost did by hand, done by the compiler from one source of truth; zero runtime cost, and the Lesson 8 race results stand
C. Generics are about 10% slower but worth it for the flexibility
D. Rust resolves the type on the first call and caches it, so only the first call is slow

**Answer:** B
**Explanation:** Monomorphization means that by runtime there are no generics left — the generic code IS the concrete code. You pay with a slightly longer compile and a slightly bigger binary, not with Tita Malou's time. Zero-cost abstraction is a mechanism, not a slogan.

---

**Question 6:** The groupmate then passes a `Tagged<String>` to a helper function that takes `Tagged<u32>`. What does the compiler say?
A. Nothing — both came from the same struct definition, so they're the same type
B. Type mismatch: once a caller fills the blank, `Tagged<u32>` and `Tagged<String>` are two fully distinct concrete types, as different as `u32` and `String` themselves — flexible at the definition, locked at every use
C. It compiles but panics at runtime
D. The compiler converts the `String` value into a `u32` automatically

**Answer:** B
**Explanation:** A generic struct is a recipe for types, not one type. Each filled-in blank produces a separate concrete type — exactly how `Option<u32>` and `Option<String>` have been different types since Lesson 14.

---

**Question 7:** Dan refactors a two-parameter signature with bounds `T: PartialOrd + Copy` and `U: std::fmt::Display` into a `where` clause. What changed about the function's meaning?
A. The `where` version accepts more types
B. The `where` version checks the bounds at runtime instead of compile time
C. Nothing — `where` is the identical contract in a different layout, and the compiler accepts both spellings as the same function; the team style is one bound inline, two or more in a `where`
D. `where` clauses are required whenever a function has two type parameters

**Answer:** C
**Explanation:** `where` exists for readability — the signature reads like a contract, parties first, terms below. The meaning is unchanged, character for character.

---
**Next:** Proceed to Lesson 21 exercises.
