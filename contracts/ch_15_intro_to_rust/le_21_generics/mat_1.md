## Dan's Story: The Copy-Paste Temptation

Tuesday, 9:40 PM, dorm. LutoCLI's weekly report module is open — the screen where Tita Malou will someday press one thing and see her week. First feature, done in one clean pass: best sales day, from the week's sinigang plate counts.

```rust
// LutoCLI weekly report, v0.1 — works perfectly
fn largest_u32(list: &[u32]) -> u32 {
    let mut biggest = list[0];
    for &item in list {
        if item > biggest {
            biggest = item;
        }
    }
    biggest
}
```

Second feature: highest dish rating. The suki ratings live in `f64` — ratings, not money; the `u32` house rule from Lesson 5 is safe. Dan looked at `largest_u32`, selected it, **Ctrl+C**. The plan assembled itself, fully formed and shameless: paste, rename to `largest_f64`, swap `u32` for `f64` twice, done in five seconds. His thumb was over the V when the laptop chirped — Kuya JM, video call.

> **Kuya JM:** Anong nakatambay diyan sa clipboard mo? ...Alam mo kung ano nahanap namin sa lumang codebase ng reconciliation service? Five copies of the same rounding function — same body, iba-iba lang ang number type. May bug pala sa logic. The fix landed in three of them. Yung other two kept quietly shaving centavos for weeks. Payment company, Dan. *Centavos with an audience.*
>
> **Dan:** Okay, but that's five copies. I'm making two.
>
> **Kuya JM:** Lahat ng five copies, nagsimula sa two. Sa kusina ni Tita Malou — may sandok ba para sa sinigang, tapos ibang sandok para sa nilaga, tapos ibang sandok para sa lugaw?
>
> **Dan:** ...One ladle. Many pots.

Then the reveal. Kuya JM had Dan scroll his own LutoCLI code and read the types out loud: `Vec<String>`... `Option<u32>`... `HashMap<String, u32>`. All with angle brackets. So — does the standard library hide a `Vec_u32` and a separate `Vec_String`? It does not. The Rust team wrote `Vec<T>` **once**; the brackets are the "many pots" part. They're called **generics**, and Dan had been a generics *customer* since Lesson 14 — the `Option<T>` fine print even promised it: *placeholders like `T` get their full lesson in Lesson 21.* Tonight, the customer becomes an author.

---

## The Concept: Write It Once, Use It for Any Type

### The Signature, Piece by Piece

Tonight's whole lesson in one line:

```rust
fn largest<T: PartialOrd + Copy>(list: &[T]) -> T
```

Walk it left to right. **`fn largest`** — a function, nothing new. **`<T>`** — the declaration: "this function works *for some type T*, to be chosen by whoever calls it"; declaring the placeholder here is what lets you use `T` everywhere after. **`T: PartialOrd + Copy`** — the **trait bounds**: not *any* type may apply — `T` must have signed the `PartialOrd` contract *and* the `Copy` contract, and `+` stacks the requirements. **`(list: &[T])`** — a borrowed slice (Lesson 11) whose element type is the blank. **`-> T`** — returns one element, by value. Call it with `&[u32]` and `T` becomes `u32` for that call; call it with `&[f64]` and `T` becomes `f64`. One ladle, many pots.

### Trait Bounds Are the Contract

A trait (Lesson 20) is a contract a type signs. A **trait bound** is a function *demanding* that contract before it agrees to work with you — the *basta* in "basta masasandok." `largest` demands exactly two signatures, and each clause maps to a specific line of the body.

**`PartialOrd` is what makes `>` legal.** Comparison operators aren't free — they're trait methods, just like `println!("{}")` turned out to be `Display`. Delete `PartialOrd` from the bound and the compiler refuses on the spot:

```text
error[E0369]: binary operation `>` cannot be applied to type `T`
  --> src\main.rs:16:17
   |
16 |         if item > biggest {
   |            ---- ^ ------- T
   |            |
   |            T
   |
help: consider further restricting type parameter `T` with trait `PartialOrd`
   |
13 | fn largest<T: Copy + std::cmp::PartialOrd>(list: &[T]) -> T {
   |                    ++++++++++++++++++++++

For more information about this error, try `rustc --explain E0369`.
error: could not compile `one_ladle` (bin "one_ladle") due to 1 previous error
```

The span arrows label both sides of `item > biggest` as `T` — "I know nothing about this type, so I can't promise it's comparable" — and the `help:` line literally writes the missing bound for you, `+`s and all. The compiler isn't saying *no*; it's saying *put it in the contract*. (Why `PartialOrd` and not its stricter sibling `Ord`? Floats. `NaN` compares equal to nothing, not even itself, so `f64` never signed the full `Ord` contract. `PartialOrd` is the contract that `u32` *and* `f64` both actually signed.)

**`Copy` is what makes `-> T` legal.** The function returns an element *by value* out of a *borrowed* slice, and Lessons 9-10 taught you exactly why that's suspicious: you can't move a value out of something you only borrowed. Drop `Copy` and ownership law answers with its own error — **E0508: cannot move out of type `[T]`, a non-copy slice**. For `Copy` types — cheap stack values like `u32` and `f64` — "taking" an element just duplicates it: no move, no theft. One contract, two clauses, and the discipline generics force is this: **the signature must declare everything the body needs.** No hidden assumptions. The compiler reads the contract, not your intentions.

### Generic Structs — Blanks in Your Own Types

Dan's report needs labeled values — a number with a caption, a note with a caption — and writing `TaggedU32` and `TaggedString` would be the clipboard crime all over again:

```rust
struct Tagged<T> {
    label: String, // always a String — not every field must be generic
    value: T,      // the blank: whatever the caller decides
}

impl<T> Tagged<T> {
    fn new(label: &str, value: T) -> Tagged<T> {
        Tagged { label: label.to_string(), value }
    }
}
```

Two things to notice. First, the `<T>` right after `impl` is the *declaration* of the placeholder, and the `Tagged<T>` after it is a *use* — same rule as the function: declare the blank before you fill code with it. Second, once a caller fills the blank, `Tagged<u32>` and `Tagged<String>` are **two different concrete types**, as different from each other as `u32` and `String` themselves. The blank is flexible at the definition; it is locked at every use. This is exactly how `Option<T>` has worked since Lesson 14 — you've just moved from reading the pattern to owning it.

### `where` Clauses — the Same Contract, Readable

Stack enough bounds inside the angle brackets and signatures start to look like regex. Rust offers a second spelling — identical meaning, different layout:

```rust
fn weekly_report<T, U>(data: &[T], labels: &[U]) -> String
where
    T: PartialOrd + Copy,
    U: std::fmt::Display,
{
    // signature reads like a contract: parties first, terms below
}
```

For one type parameter it's a matter of taste. Kuya JM's team style guide at work: one bound, inline; two or more, `where`. The compiler accepts both spellings as the same function.

### Monomorphization — Why the Ladle Costs Nothing

"Flexible AND fast" should sound suspicious until someone explains the trick. At compile time, the compiler finds every concrete type your generic is used with and **stamps out a separate, fully concrete copy per type**: your one `largest<T>` source becomes `largest::<u32>` and `largest::<f64>` in machine code — as if Dan had done the copy-paste after all, except *the compiler* did it, from one source of truth, and it cannot forget to update a copy. This is **monomorphization**, and it means that by the time your program runs, *there are no generics left* — no type lookups, no indirection, no runtime cost. Zero. The Lesson 8 drag race — ten million additions in eleven milliseconds on a secondhand laptop — would post the same time with generics in the loop, because at runtime the generic code *is* the concrete code. You pay with a slightly longer compile and a slightly bigger binary; you are paid back with abstractions that cost nothing when Tita Malou presses the button. That's what "zero-cost abstraction" means — a mechanism, not a slogan.

---

## Key Takeaways

- **Generics let you write a function or struct once**, with a type parameter `<T>` as a blank each caller fills in. One ladle, many pots — no `largest_u32`/`largest_f64` twins drifting out of sync.
- **You've been using generics since Lesson 14:** `Vec<T>`, `Option<T>`, `HashMap<K, V>` — each written exactly once by the standard library. Today you moved from customer to author.
- **Trait bounds are the contract:** `T: PartialOrd + Copy` declares everything the body needs. `PartialOrd` makes `>` legal (drop it: E0369, and the `help:` line writes the missing bound for you). `Copy` makes returning by value out of a borrowed slice legal (drop it: E0508, ownership law from Lessons 9-10).
- **Generic structs put the blank in your data:** `Tagged<T>` defines the shape once; `Tagged<u32>` and `Tagged<String>` are then two fully distinct concrete types. `impl<T>` declares the placeholder before using it.
- **`where` clauses are the same contract, formatted to breathe** — identical meaning, kinder to readers once bounds multiply.
- **Monomorphization makes generics free at runtime:** one concrete copy stamped out per type used, at compile time. No lookups, no overhead — the Lesson 8 race results stand. Zero-cost abstraction is a mechanism, not a slogan.
- **Demand only what the body uses.** A thinner contract means more types can use your ladle.

---

## What's Next?

The weekly report now has one ladle where two were almost born, and Dan's clipboard conscience is clean. Act 3 has been generous lately — traits clicked, generics turned out to be old friends with a new name. Which is exactly when the folklore says the last monster appears. Tomorrow Dan writes the most innocent-looking function of the entire course — take two `&str`, return the longer one — and the compiler answers with **E0106, missing lifetime specifier**: the error from Jasper's rage-quit war story, the final boss he still brings up in the group chat. Here's the spoiler future Dan would send back: it's not a monster, it's a *label* — and it goes in angle brackets too, `<'a>`. After tonight, reading a placeholder inside `< >` is a skill you already have.

**Next Lesson: Lifetimes** — E0106 decoded, the borrow checker's last secret, and the day the compiler completes its long turn from wall to mentor.
