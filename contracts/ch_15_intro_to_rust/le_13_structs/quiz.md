# Lesson 13 Quiz: Structs

---
# Quiz 1
## Scenario: Fifteen Dishes, Forty-Five Variables

Dan replaces the loose-variable swamp — three `let` lines per dish — with one `MenuItem` struct: `name: String`, `price: u32`, `is_available: bool`, plus an `impl` block for behavior.

**Question 1:** Why does the field say `name: String` and not `name: &str`?
A. `&str` cannot hold dish names longer than 16 bytes
B. Structs should OWN their data — a `&str` field is a borrow, and a borrowed field forces you to tell the compiler exactly how long that loan lives (lifetimes). `String` sidesteps all of that: the struct keeps its own owned copy
C. `String` is always faster than `&str`
D. The compiler forbids references inside structs entirely

**Answer:** B
**Explanation:** A struct *can* hold `&str`, but then it needs lifetime annotations (Lesson 22's problem). Until then, the Lesson 12 rule: functions take `&str`, structs own `String`.

---

**Question 2:** Dan writes `let adobo = MenuItem { ... };` and later adds `adobo.price = 80;`. What happens?
A. It compiles — field assignment is always allowed; `mut` only matters for whole-struct reassignment
B. error[E0594] — the BINDING `adobo` is not declared mutable. Mutability is per-binding, whole instance or nothing: there is no per-field `mut`, and the `help:` line points the fix at the `let`, not the field
C. It compiles, but the new price is silently discarded
D. It panics at runtime when the line executes

**Answer:** B
**Explanation:** `let mut adobo` makes *all three* fields writable; plain `let` seals all three. The error message doesn't even blame the field — it blames the binding. The whole dish or nothing.

---

**Question 3:** Inside `impl MenuItem`, what is the real difference between `&self` and `&mut self` as a method's first parameter?
A. `&self` is for short methods, `&mut self` for long ones
B. `&self` is a SHARED borrow of the instance (read-only, many allowed at once); `&mut self` is the EXCLUSIVE borrow (one writer, zero readers) — methods run on Lesson 10's borrowing rules, no exceptions
C. `&mut self` copies the struct so changes don't affect the original
D. They are interchangeable; the compiler picks whichever fits

**Answer:** B
**Explanation:** `halo_halo.apply_discount(20)` is sugar for `MenuItem::apply_discount(&mut halo_halo, 20)` — a genuine exclusive borrow, which is also why it only compiles if `halo_halo` is bound with `mut`.

---

**Question 4:** `MenuItem::new("Adobo", 75)` uses `::` while `adobo.display_line()` uses a dot. What's the distinction?
A. `::` is legacy syntax; the dot replaced it
B. `new` has NO `self` parameter — it's an ASSOCIATED FUNCTION that belongs to the type and is called with `::` (exactly like `String::from`); `display_line` takes `&self`, making it a METHOD called on an instance with dot syntax
C. `::` is reserved for the standard library
D. Constructors are a built-in language feature with their own syntax

**Answer:** B
**Explanation:** No `self` = associated function, called on the type itself. `String::from` was an associated function all along — `new` is just Rust's constructor naming convention, not a keyword.

---

# Quiz 2
## Scenario: The Special That Stole a Field

Dan adds `category: String` to `MenuItem`, then builds a Sinigang Special with struct-update syntax: `MenuItem { name: String::from("Sinigang Special"), price: 120, ..sinigang }`. Afterwards he tries printing fields of the ORIGINAL `sinigang`.

**Question 5:** `println!("{}", sinigang.category);` after the update fails with error[E0382] "borrow of moved value". Why?
A. Struct-update syntax always deletes the entire original struct
B. `..sinigang` had to supply `category`, which is a `String` — not `Copy` — so it MOVED out of `sinigang` into the special, exactly like Lesson 9's `let s2 = s1;`. That single field of `sinigang` is now gone
C. `category` fields are private by default
D. `println!` cannot print `String` fields without `derive(Debug)`

**Answer:** B
**Explanation:** E0382 applies to individual fields, not just whole variables. Struct-update moves every non-`Copy` field it actually supplies — the rest of `sinigang` is untouched.

---

**Question 6:** In the same code, `println!("{}", sinigang.price);` AND `println!("{}", sinigang.name);` both still compile. Why?
A. Luck — moves are nondeterministic
B. Two different reasons: `price` is `u32`, which IS `Copy`, so `..` merely copied it; and `name` was listed EXPLICITLY in the new struct, so `..` never touched it. Only fields that `..` actually supplies can move
C. `println!` temporarily un-moves values
D. Numeric fields and the first field of a struct are immune to moves

**Answer:** B
**Explanation:** `Copy` fields are copied (original intact). Explicitly-listed fields aren't supplied by `..` at all. That's also the brain-twister's answer: on the three-field struct, `..sinigang` only supplies `is_available` — a `Copy` `bool` — so nothing moves and everything compiles.

---

**Question 7:** Dan forgets the attribute above the struct and writes `println!("{:?}", halo_halo);`. What happens, and what does `#[derive(Debug)]` actually do?
A. It prints anyway — `{:?}` works on every type out of the box
B. Compile error — `MenuItem` doesn't implement `Debug`. Adding `#[derive(Debug)]` makes the compiler GENERATE the `{:?}` / `{:#?}` printing code for the type — the error's `help:` line even suggests exactly that attribute
C. It prints the struct's memory address instead
D. It panics at runtime the first time the line runs

**Answer:** B
**Explanation:** Rust won't invent formatting for your type — `{}` (Display) and `{:?}` (Debug) both refuse until implemented. `derive` asks the compiler to write the implementation for you: one attribute line, generated code, free X-ray. (Lesson 20 opens the box of how an attribute can write code.)

---
**Next:** Proceed to Lesson 13 exercises.
