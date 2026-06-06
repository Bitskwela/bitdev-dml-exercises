# Survive the Ownership Wall

Dan lost sixty-eight minutes to `error[E0382]: borrow of moved value`. Your job tonight: hit the same wall on purpose, read it like a mentor's diagram instead of an enemy's insult, and walk out through three different doors. Open `act_1.rs` — one program, four stops, four `TODO` markers.

## Task 1: Meet E0382 in Person

Find `TODO(1)` in Part 1. Uncomment the `println!("Saving to the record: {}", order);` line and run `cargo check`. Do the four-part read on the error before touching anything:

1. **The headline** — `borrow of moved value: order`.
2. **The first arrow** — `----- value moved here`, pointing at the `print_order(order)` call.
3. **The second arrow** — `^^^^^ value borrowed here after move`, pointing at your println.
4. **The note and the patch** — the note names `print_order` as the key-taker; the `help:` line literally types `order.clone()` for you.

Then RE-COMMENT the line. Part 1 ships with the move left alone — the corpse is only a crime scene if you visit it.

## Task 2: Fix v1 — Pay for the Copy

Find `TODO(2)` in Part 2. Add `.clone()` to the `print_order(order)` call, then uncomment the save line below it. The clone — a real second String on the heap — moves into the function and is dropped there; the original never leaves `main`. Without the clone, the save line is E0382 all over again.

## Task 3: Fix v2 — Hand the Key Back, Then Watch a u32 Not Care

Two markers left:

- `TODO(3)`, below `main`: write the body of `print_and_return`. Print `"Kitchen receives: {}"` with the order, then make `order` the LAST LINE with no semicolon — an expression, not a statement. That tail expression is the return value: ownership moves back OUT to the caller, where Part 3 catches it by shadowing (the Lesson 4 trick).
- `TODO(4)`, in Part 4: call `print_price(price)` a SECOND time, then print `"Price is still ours: ₱{price}"`. Both lines compile — no move, no funeral, no E0382. `u32` is a `Copy` type: the function only ever received a photocopy.

---

## Sample Output

```text
=== PART 1: the wall ===
Kitchen receives: 2x sinigang, 1x extra rice

=== PART 2: fix v1 — clone() ===
Kitchen receives: 1x adobo, 1x rice
Saving to the record: 1x adobo, 1x rice

=== PART 3: fix v2 — return the key ===
Kitchen receives: 3x tortang talong
Saving to the record: 3x tortang talong

=== PART 4: Copy types don't move ===
Kitchen quotes:  ₱95
Kitchen quotes:  ₱95
Price is still ours: ₱95
```

---

## Reflection Questions

1. In Part 1, `print_order(order)` compiles fine on its own — the error only appears when you use `order` *afterward*. What exactly does a move invalidate: the text on the heap, or the binding in `main`?
2. Part 2 (clone) and Part 3 (return the key) both let you keep using the String. What does each fix cost, and when would you pick one over the other?
3. `String` moves but `u32` copies. What property of `u32` makes Rust willing to photocopy it silently — and why does Rust refuse to do the same for `String`?

---

## Challenge: The Clone Audit

Dan's first working pipeline clones everything in sight — which, per the policy, is FINE. It compiles, it ships, nobody is shamed:

```rust
let order = String::from("2x sinigang, 1x extra rice");
print_order(order.clone());              // clone #1
let receipt = label_paid(order.clone()); // clone #2
print_order(order.clone());              // clone #3
// elsewhere: fn label_paid(order: String) -> String { format!("[PAID] {}", order) }
```

Tonight's audit: remove exactly **one** clone by restructuring, the Part 3 way. Change `print_order` so it returns the String back (`fn print_order(order: String) -> String`), then delete clone #3 by catching the returned key with shadowing: `let order = print_order(order);`. Run it — the output must not change. (The same trick also clears clone #1, if you're feeling thorough.)

But clone #2 will not fall. `label_paid` consumes the order and its return slot is already occupied — by the receipt. Getting the original back too would mean returning BOTH Strings in a tuple, bolted onto a one-job function just to smuggle a key home. Leave clone #2 in place, with this comment above it: `// clone #2 stays — label_paid only needs to LOOK at the order, not own it. There has to be a way to lend without giving. (Lesson 10, apparently.)` That comment is tomorrow's cliffhanger.

---

## What You've Learned

- The three ownership rules in motion: one owner per value; assignment or a function call MOVES ownership for heap types like `String`; the value is dropped the moment its owner leaves scope.
- Two honest fixes for a move: `clone()` — pay for a real copy, per the policy *clone first, understand the move, optimize later* — and returning ownership back out through a tail expression.
- Why `Copy` types like `u32` never hit the wall, and how to read E0382: headline, moved-here arrow, borrowed-after-move arrow, the note naming the taker, the `help:` patch.
