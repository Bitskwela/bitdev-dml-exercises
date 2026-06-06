## Dan's Story: The Utang Notebook

Nine in the morning, the quiet hour at the carinderia. Dan opened last night's clone-littered project and called Kuya JM.

> **Dan:** Kuya, ako na ang clone king. Five clones para lang gumana ang order board. It runs, pero parang niluto ko ang isang ulam sa limang kaldero.
>
> **Kuya JM:** Balik tayo sa cash drawer. Ownership says: hand someone the key, hindi na sayo. Pero your mom never GIVES AWAY the drawer key, diba? She lets you *borrow* it for the sukli, and you give it back. Sa Rust, that's a **reference**. One ampersand: `&`. No move, no funeral, no clone.

But the clone that survived all of last night — `add_note` — has to *change* the order. Borrowing just to read won't cut it. JM pointed at the counter, where Tita Malou had the utang notebook open: writing a new line while a suki read his own column upside down over her shoulder.

> **Kuya JM:** How many people can read that notebook at the same time? And how many hands write in it?
>
> **Dan:** Lahat ang nakakabasa — reading doesn't bother anyone. Pero one hand lang ang sumusulat. Hers. Always hers. Kapag dalawang kamay ang sumusulat, magulo ang records.
>
> **Kuya JM:** Naks. You just recited Rust's borrowing rules word for word. Any number of readers, OR exactly one writer — never both at once. The compiler enforces what your mom enforces with one glare.

Dan changed `print_order` to take `&String` and deleted a clone — green. Then the boss fight: `add_note(order: &mut String)`. The note landed on the *real* order. Five clones, four, three, two, one — **zero**. *The ampersand isn't giving anything away. It's a borrower's signature in Ma's notebook.*

---

## The Concept: Borrowing — Read with `&`, Write with `&mut`

### `&T` — Shared References: Many Readers

A **reference** lets a function use a value without taking ownership. At the call site, `&order1` says *"I'm lending this"*; in the signature, `&String` says *"I only borrow."*

```rust
fn print_order(order: &String) {   // "I only need to LOOK at it"
    println!("ORDER UP: {}", order);
}

let order1 = String::from("Sinigang na Baboy + rice");
print_order(&order1);   // lending, not giving
println!("{}", order1); // still the owner. No E0382. No clone.
```

A plain `&T` is **read-only**, and *any number* can exist at the same time — like the suki reading his tab over Tita Malou's shoulder. Eyes don't garble records, so the notebook doesn't care how many are on it.

### `&mut T` — Exclusive References: One Writer

To borrow something *for writing*, you need a **mutable (exclusive) reference** — and `mut` must be signed at **three sites**: the owner (`let mut order2`), the lender (`&mut order2`), and the signature (`&mut String`). Nobody mutates by surprise.

```rust
fn add_note(order: &mut String) {  // "I need to CHANGE it"
    order.push_str(" — extra rice");
}

let mut order2 = String::from("Adobo + rice");
add_note(&mut order2);  // lend the pen — briefly
```

The price of write access: **exactly one** `&mut` to a value at a time. One notebook, one pen, one hand.

### The Aliasing Rule: Many Readers XOR One Writer

At any moment, a value may have **any number of `&T`** (readers) *or* **exactly one `&mut T`** (a writer) — but **never both at once**. It's an XOR, enforced at compile time. Break it and the compiler hands you E0502:

```rust
let mut order = String::from("Adobo + rice");

let reader = &order;              // shared borrow starts here...
order.push_str(" — extra rice");  // ...a write while `reader` is live
println!("{}", reader);           // ...and `reader` is still used here
```

```text
error[E0502]: cannot borrow `order` as mutable because it is also borrowed as immutable
 --> src\main.rs:5:5
  |
4 |     let reader = &order;              // shared borrow starts here...
  |                  ------ immutable borrow occurs here
5 |     order.push_str(" — extra rice");  // ...a write while `reader` is live
  |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ mutable borrow occurs here
6 |     println!("{}", reader);           // ...and `reader` is still used here
  |                    ------ immutable borrow later used here
```

Three arrows, three facts: where the reader was born, where the write barged in, and — the crucial third arrow — where the reader is *still used afterward*. A borrow lives from its creation to its **last use**, not to the closing brace: delete line 6 and this compiles, because `reader`'s borrow would already be over. Sometimes the entire fix for E0502 is reordering two lines. (Two overlapping writers is the sibling crime: **E0499**, "cannot borrow as mutable more than once at a time.")

Why so strict, even single-threaded? When you append to a `String` that's out of capacity, its text **relocates** in memory — a reader still pointing at the old spot would be reading basura. In C, that bug class (use-after-realloc) compiles silently and corrupts quietly. Rust makes it unrepresentable: while anyone is reading, nobody relocates anything.

### References Never Own — So Nothing Is Dropped

When a reference goes out of scope, **nothing is freed and nothing is dropped** — you can't drop what you never owned. The borrower handing back the notebook doesn't burn the notebook. The String still dies exactly once, at the end of its *owner's* scope. References add readers and writers; they never add funerals.

### Dangling References: a Compile Error, Not a Crash

A reference can never outlive the value it points to. In C you can return a pointer to a function's local variable — it compiles without complaint and aims at freed memory; maybe it crashes three weeks later, in production. In Rust, the equivalent code is rejected *at compile time*: the compiler proves, before the binary exists, that every reference's owner is still alive at every use. The dangling pointer isn't caught, or handled, or debugged — it is **never compiled**.

---

## Key Takeaways

- **A reference (`&`) borrows a value without taking ownership.** The function uses it and hands it back — no move, no E0382, no clones.
- **`&T` is shared: read-only, any number at once.** `&mut T` is exclusive: read-and-write, exactly ONE — with `mut` signed by the owner, the lender, and the signature.
- **The aliasing rule is an XOR:** many readers OR one writer, never both. Violations are E0502 (reader vs writer) and E0499 (writer vs writer), caught at compile time.
- **A borrow lasts until its last use,** not the closing brace. Reordering lines or `{ }` scoping are both honest fixes.
- **References never own, so nothing is dropped** when they go out of scope. The value dies exactly once, with its owner.
- **Dangling references don't compile.** What C ships as a time-bomb pointer, Rust refuses to build at all.

---

## What's Next?

Dan closed the laptop with zero clones and a new respect for his mom's notebook discipline. Then Tita Malou made her next request without knowing it was a Rust lesson: *"Anak, yung menu board — 'Sinigang na Baboy' is too long for the small chalkboard. Just write 'Sinigang.'"* Dan needs the first part of a `String` — without cloning it (he just spent a whole lesson deleting clones) and without chopping up the original. What he needs is a **view** into a piece of a String: no copy, no new owner, just a window.

**Next Lesson: Slices** — `&str`, string slices, and taking a view of data without copying anything. The menu board gets its short names, and `print_order` gets its final form.
