## Dan's Story: The Hour Against the Wall

Dorm, 7:02 PM, the evening after the drag race. Dan — still slightly invincible from beating Python forty-five times over — sat down to write the most innocent code of his week: make a `String` order, pass it to a function, use it again.

```rust
let order = String::from("2x sinigang, 1x extra rice");
print_order(order);
println!("Saving to the record: {}", order); // <- the compiler said NO
```

`error[E0382]: borrow of moved value: order`. Moved? Nothing moved — the variable was right there, four lines up. Over the next hour Dan retyped the program from scratch (same error), renamed the variable (the error politely renamed itself), and made a backup with `let backup = order;` (now BOTH variables were dead). At minute sixty-three he screenshotted the error and vented to the barkada group chat. Jasper answered in eleven seconds:

> **Jasper:** HAHAHA bro you're doing Rust?? I tried it last sem. Rage-quit in one weekend. The borrow checker is toxic, it fights you over literally nothing. Come back to Python bro.

Dan stared at the message — and something in his chest did a hard one-eighty. Jasper had hit this exact wall and *quit*. Which meant the wall was real, and getting past it was worth something. He closed the chat and called Kuya JM.

> **Kuya JM:** E0382? I fought that same error for a week when we started the rewrite at work — and I get paid to do this. You're right on schedule. Okay: yung cash drawer sa carinderia ni Tita. How many keys?
>
> **Dan:** One. Mama guards it like a family heirloom.
>
> **Kuya JM:** One drawer, one key, one owner. If she *gave* me the key — not lent, GAVE, mine now — can she ever open that drawer again?
>
> **Dan:** No... it's not hers anymore. She'd just be a lady pulling a locked handle. Oh. OH. `print_order(order)` — I gave the function the key. My last line is Mama pulling the locked handle.
>
> **Kuya JM:** Exactly. And the compiler caught her *before* the customers did. Now scroll to the bottom of the error — the `help:` line literally types `order.clone()` for you. Your policy from now on, memorize it: **clone first, understand the move, optimize later.** Nobody gets shamed for a clone in this family.

Dan added eight characters. `cargo check` went green. Sixty-eight minutes for one method call. In his notes: *Day 1 of Act 2. The wall has a door. Jasper never found it.*

---

## The Concept: One Value, One Owner

Ownership is the idea the entire language is built on — it's *why* Rust can be as fast as C without C's crashes, and as safe as Python without Python's janitor.

### Stack vs Heap

The **stack** is the fast, tidy place: data is pushed and popped automatically as functions are called and return, and everything on it must have a fixed compile-time size — exactly true for a `u32`, a `bool`, a `char`. Stack data is so small and regimented that copying it costs about one CPU instruction. This is the world Act 1 lived in, and it's why Act 1 never hurt.

The **heap** is the flexible, expensive place: space for data whose size is only known at runtime — like the text inside a `String`, which grows every time a customer adds extra rice. Heap memory is requested from the allocator, reached through a pointer, and — the unpaid bill — must eventually be *given back*. Python's answer is a garbage collector, a janitor that costs memory and pauses. C's answer is "the programmer will free it manually," and forty years of crashes prove programmers forget. Rust's answer is ownership.

### The Three Ownership Rules

Checked entirely at compile time — no janitor, no manual `free`, no runtime cost:

1. **Every value has exactly one owner.** One drawer, one key. `let order = String::from(...)` makes `order` the owner.
2. **Assigning the value to another variable, or passing it to a function, MOVES ownership** (for heap-backed types like `String`). The key changes hands; the old binding is dead.
3. **When the owner goes out of scope, the value is dropped** — its heap memory freed, automatically, exactly once. The compiler knows the precise line where every value dies.

Rule 3 is the payoff: because there is always exactly one owner, the compiler always knows exactly who frees what, and when. No leaks, no double frees, no use-after-free — all eliminated *before the program runs*.

### Moves vs Copy

A `String` is two pieces: a small stack trio — pointer, length, capacity — and the actual text on the heap. A move copies only the trio into the new binding and stamps the old one INVALID; the heap text never moves and is never duplicated. Cheap, instant, final. Why must the old binding die? If two bindings pointed at the same heap text, rule 3 would free the same memory *twice* as each left scope — a double free, a classic C catastrophe. E0382 is the compiler standing in front of the dead binding saying *you can't use this one anymore.*

Stack-only types take the other road. `u32`, `i64`, `bool`, `char`, `f64` are marked with the **`Copy`** trait: so cheap to duplicate that Rust just copies them, and both bindings stay valid. No heap part, no drawer, no key, nothing to fight over — which is why eight lessons of passing `u32` pesos around never hit this wall. `String` doesn't get to be `Copy` because copying it means duplicating heap memory — a real allocation, a real cost — and Rust refuses to hide real costs behind an innocent-looking `=`.

### `clone()` — the Honest Escape Hatch

If you want the expensive copy, ask for it by name:

```rust
print_order(order.clone());   // the CLONE moves in; the original stays yours
println!("{}", order);        // perfectly legal
```

Some corners of the internet treat `.clone()` like an admission of failure. Ignore them. The course policy, verbatim: **clone first, understand the move, optimize later.** A clone is explicit, correct, and visible — the compiler itself suggests it. Some clones can later be replaced by something cheaper (that's literally the next lesson), but a working program with three honest clones beats a rage-quit with zero.

### Reading E0382 Line by Line

E0382 will be the most frequent visitor of your early Rust career, so learn its anatomy. Here is Dan's, in full:

```text
error[E0382]: borrow of moved value: `order`
 --> src/main.rs:4:42
  |
2 |     let order = String::from("2x sinigang, 1x extra rice");
  |         ----- move occurs because `order` has type `String`, which does not implement the `Copy` trait
3 |     print_order(order);
  |                 ----- value moved here
4 |     println!("Saving to the record: {}", order);
  |                                          ^^^^^ value borrowed here after move
  |
note: consider changing this parameter type in function `print_order` to borrow instead if owning the value isn't necessary
 --> src/main.rs:7:23
  |
7 | fn print_order(order: String) {
  |    -----------        ^^^^^^ this parameter takes ownership of the value
  |    |
  |    in this function
help: consider cloning the value if the performance cost is acceptable
  |
3 |     print_order(order.clone());
  |                      ++++++++

For more information about this error, try `rustc --explain E0382`.
error: could not compile `order_record` (bin "order_record") due to 1 previous error
```

1. **The headline.** `borrow of moved value: order`. Look it up anytime with `rustc --explain E0382` — you are never the first.
2. **The two story arrows.** `-----` marks *where the value moved* ("value moved here"); `^^^^^` marks *where you used it after* ("value borrowed here after move"). The handover, then the locked-handle pull.
3. **The note** points a third arrow *inside* `print_order`: "this parameter takes ownership of the value" — naming exactly which function took your key.
4. **The `help:` line** is a literal patch: `print_order(order.clone());` with `++++++++` marking the characters to add.

What moved, where it moved, who took it, and a fix to copy-paste. Dan spent an hour treating that as an enemy's insult. It was a mentor's diagram.

---

## Key Takeaways

- **Stack vs heap:** stack data is fixed-size and nearly free to copy; heap data (`String`'s text) is sized at runtime and must eventually be freed — and *who frees it* is the question every language must answer. Rust's answer is ownership: compile-time checked, zero runtime cost.
- **The three rules:** one owner per value; assignment or a function call *moves* ownership for heap types; the value is dropped — freed exactly once — when its owner leaves scope.
- **A move copies only the stack trio** (pointer, length, capacity) and invalidates the old binding. The invalidation is what makes a double free impossible.
- **`Copy` types don't move.** `u32`, `bool`, `char` are photocopied on assignment; both bindings stay valid. That's why Act 1's pesos never hit this wall.
- **`clone()` is the honest escape hatch** — an explicit deep copy with its own heap allocation. Policy: *clone first, understand the move, optimize later.* Never shame a clone.
- **Read E0382 as a diagram:** headline → moved-here arrow → borrowed-after-move arrow → the note naming the taker → the `help:` patch.

---

## What's Next?

Dan won the night, but look at the scoreboard honestly: one clone he chose, one round-trip return he tolerated — and functions that only need to **read** a value still force him to either give it away or photocopy it. There's an obvious third option in the real carinderia, and Kuya JM named it before hanging up: you don't give the key away — you *lend* it.

**Next Lesson: Borrowing** — the `&` symbol, lending a value without losing it, why the compiler tracks every loan like the strictest lister in the palengke, and the deletion of the last clone. The wall keeps turning into doors.
