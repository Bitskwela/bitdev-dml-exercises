# Track the Rice Through the Lunch Rush

Build Tita Malou's rice tracker: one honest `mut` counter, a price that transforms through shadowing — including a type change `mut` could never pull off — and one `const` house rule.

## Task 1: Finish the Lunch Rush (`mut`)

Open `act_1.rs`. Part 2 already handles the 7:30 AM jeepney batch — the `let mut` and the first `-=` are the worked example. Two more batches hit the counter: the 11:45 AM office crowd from the barangay hall (**12 cups**) and the 12:30 PM tricycle drivers, extra-rice gang (**9 cups**). Update `cups_of_rice` with `-=` and print after each batch — every one of those updates compiles for exactly one reason: the three letters in `let mut`.

## Task 2: Payday Price (shadowing)

The 15th — quincena. In Part 3, shadow `price` with a brand-new `let` binding worth `price + 10`. Same name, new binding — not mutation. Print the payday price.

## Task 3: The Price Tag (type-changing shadow)

Shadow `price` AGAIN — into a `String` this time, via `format!("P{} (payday)", price)` — and print it. This is the move `mut` cannot make: mutation keeps the type locked at `u32`; shadowing creates a new binding that is free to be anything.

## Task 4: Senior Discount (`const`)

In Part 4, bind `regular_price` (80 pesos, `u32`) and compute the senior price using `SENIOR_DISCOUNT_PCT` with integer math — multiply first, then divide by 100. No decimals anywhere.

## Task 5: Break It, Read It, Fix It

Deliberately earn the error. Delete the `mut` from your working `cups_of_rice` line and run `cargo check`. You will get E0384 — on purpose, on your terms. Do the ritual, top to bottom:

1. Read the **error code** and headline. What rule was broken, in plain words?
2. Find both **span arrows** — which line gets `------`, which gets `^^^^^`, and what is each one telling you?
3. Read the **`help:`** line. What exact fix does the compiler propose, and where do the `+++` characters say it goes? Then restore the `mut` and confirm green. (Part 1's commented-out lines are the same exercise in a sandbox — uncomment, read, re-comment.)

---

## Sample Output

```text
=== Tita Malou's Rice Tracker ===
(rice in cups, money in whole pesos)

Opening rice: 50 cups
After jeepney drivers:  46 cups left
After the office crowd: 34 cups left
After the lunch rush:   25 cups left

Base price:   P70
Payday price: P80
Price tag:    P80 (payday)

Senior price: P64 (20% off P80)
```

---

## Reflection Questions

1. Rust could have made variables mutable by default, like Python. What bug class does immutable-by-default eliminate, and why is a compile error better than a silent overwrite?
2. The third `price` binding is a `String`, not a `u32`. Why can shadowing change the type when `mut` never can?
3. In the E0384 message, what do the `------` and `^^^^^` arrows each point at, and what makes the `help:` line different from an ordinary error message?

---

## Challenge: The Price Tag Conversion

Start from this and finish it with shadowing — the variable must be named `price` the whole way through:

```rust
let price: u32 = 80;
// TODO: using shadowing (NOT mut), turn `price` into a String
// that reads exactly: P80 (payday)
// TODO: in a comment, explain why `let mut price: u32` could
// never produce this String under the same name.
println!("{}", price);
```

Your explanation should land on the core distinction: `mut` allows a new *value* in the *same* binding, so the type is locked at `u32` forever. Shadowing creates a brand-new binding that merely reuses the name — same nameplate, different drawer.

---

## What You've Learned

- `mut` is the explicit, visible opt-in to change — the value can move, but the type never does
- Shadowing creates a new binding under an old name, and the new binding can change type — `u32` to `String` and beyond
- E0384 reads as three labeled parts — error code, span arrows, `help:` line — and the `help:` line usually hands you the literal fix
