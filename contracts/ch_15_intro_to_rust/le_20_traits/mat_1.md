## Dan's Story: Iba-Ibang Ulam, Isang Sandok

Tuesday, 2:30 PM — the dead hour. The lunch crowd had come, conquered, and gone, and Dan had the corner table to himself, three pieces of paper laid out beside the laptop like evidence: a lunch receipt, the daily report page from the notebook, and the cardboard menu board — "ADOBO — 75" in Tita Malou's marker handwriting. LutoCLI would need all three as types, and staring at them Dan saw it: three completely different things, one identical need. Each had to be able to *print itself as a one-line summary*.

So he did the obvious thing — `print_menu_summary(&MenuItem)` and `print_sales_summary(&DailySales)`. Two functions, identical job, identical shape, different parameter type — and a third already looming for receipts. Python Dan would have written *one* function and passed in anything with a `.summary()` method. Duck typing, bahala na. But a Rust function takes exactly one type, and Dan could feel the copy-paste future stretching ahead: one `print_whatever_summary` per type, forever.

While stewing on that, he tried something small. The menu board shouldn't look like a debug dump, so he typed the most innocent line in programming — `println!("{}", adobo);` — and `cargo check` said no: `error[E0277]: MenuItem doesn't implement std::fmt::Display`. There it was again — that word. *Trait.* It had been haunting error messages since Act 2, always in passing, like a name overheard at someone else's table. Not today. He called Kuya JM.

> **Kuya JM:** Nasa carinderia ka, diba? Tingnan mo ang serving rack. Limang ulam ang nakasalang — ilang sandok?
>
> **Dan:** ...Isa. *Isa lang.*
>
> **Kuya JM:** Ayan ang sagot. Iba-ibang ulam, isang sandok. The sandok has no idea kung adobo ba o monggo ang nasa tray, and it doesn't care. Isa lang ang tanong niya: kaya ka bang sandukin? **A trait says WHAT you can do, not WHAT you are.** Gawa ka ng contract — `trait Summarize` — tapos papipirmahin mo ang bawat type. After that, isa na lang ang function mo, at tatanggapin niya kahit sinong pumirma.

Twenty minutes later the contract existed, both types had signed, and a single `print_summary` served them both. Then something clicked sideways: the error had called `Display` a *trait* — so `{}` had been a trait this whole time. And `#[derive(Debug)]`... *Debug is a trait too?!* Naks, said Kuya JM — `Debug`, `Clone`, `PartialEq`, traits lahat yan; `#[derive]` just writes the `impl` block for you. Seven lessons of stickers, and Dan had been signing contracts since Lesson 13. Today he finally read one before signing.

---

## The Concept: Traits — Shared Behavior as a Contract

### Defining a Trait

```rust
trait Summarize {
    fn summary(&self) -> String;
}
```

A **trait** is a contract about behavior. This one says: *any type may call itself a `Summarize`, provided it supplies a `summary` method with exactly this signature.* For a **required method** like this one, the trait declares the name, parameters, and return type — and no body. The body is the signer's problem. Notice what the contract *doesn't* mention: fields. Struct or enum, two fields or twenty — what you can DO, not what you ARE.

### Signing the Contract: `impl Trait for Type`

```rust
impl Summarize for MenuItem {
    fn summary(&self) -> String {
        format!("{} — ₱{}", self.name, self.price)
    }
}
```

Compare with Lesson 13: `impl MenuItem` (no `for`) holds a type's *own* methods. `impl Summarize for MenuItem` fulfills a named contract — and a second block, `impl Summarize for DailySales`, signs the other type onto the *same* trait, each signer bringing its own body. The behavior is shared in *name and shape*, not implementation. And the contract is enforced, not suggested: sign the trait but skip `summary`, and the compiler hands you `error[E0046]: not all trait items implemented` — at compile time, at your desk. Python's duck typing checks the same thing at runtime, in front of the customers.

### Default Methods — Libre, Pero Pwedeng Palitan

```rust
trait Summarize {
    fn summary(&self) -> String;          // required — every signer writes this
    fn short_label(&self) -> String {     // default — every signer gets this FREE
        format!("[REPORT] {}", self.summary())
    }
}
```

Three things to see: **(1)** implementors get `short_label` without writing a line — both `impl` blocks stay exactly as they are. **(2)** A default method can call a required one — `short_label` is written against `self.summary()`, so implement one small required method and inherit a whole API built on top of it. **(3)** Defaults are overridable, per type: write your own `short_label` inside an `impl` block and yours wins, for that type only. The resolution rule: Rust looks in the type's own `impl` first and falls back to the trait's default only if nothing is there.

### Trait Bounds: One Function, Any Signer

```rust
fn print_summary(item: &impl Summarize) {
    println!("• {}", item.summary());
}
```

`&impl Summarize` reads as: *a reference to any type, basta it implements `Summarize`.* This is a **trait bound** — the parameter is bounded by the contract instead of pinned to one type. `MenuItem` passes. `DailySales` passes. `u32` gets rejected at compile time, because `u32` never signed. The fine print: inside `print_summary`, the *only* things you can do with `item` are the things the contract promises — `item.summary()` compiles, `item.price` does not, even when the caller passed a `MenuItem`. The function knows the sandok, not the ulam. One sentence for tomorrow: `fn print_summary<T: Summarize>(item: &T)` means *exactly* the same thing in generic syntax, and that `<T>` machinery is Lesson 21 in its entirety.

### The Box Lesson 13 Promised: `#[derive]` Writes Trait Impls

| You type | What it unlocks | The trait behind it | Who writes the `impl` |
|---|---|---|---|
| `#[derive(Debug)]` | `{:?}` and `{:#?}` | `std::fmt::Debug` | the compiler |
| `#[derive(Clone)]` | `.clone()` | `Clone` | the compiler |
| `#[derive(PartialEq)]` | `==` and `!=` | `PartialEq` | the compiler |
| `impl fmt::Display for ...` | `{}` in `println!` | `std::fmt::Display` | **you** |

You have been implementing traits since Lesson 13 — you just outsourced the typing. `#[derive(Debug)]` is the compiler writing `impl Debug for MenuItem` on your behalf: a real `impl Trait for Type` block, the same kind you wrote by hand today, generated into your program. Deriving works when the implementation is mechanical — print all the fields, clone all the fields, compare all the fields. No judgment calls, so a machine can do it.

### `impl fmt::Display` — Earning the `{}`

```rust
use std::fmt;

impl fmt::Display for MenuItem {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{} — ₱{}", self.name, self.price)
    }
}
```

The moving parts: `fmt` is `Display`'s single required method — sign it and `{}` works. `f` is the destination, whatever the text is being written *into* (the terminal via `println!`, a `String` via `format!`). `write!` is `println!`'s cousin — same format syntax, but it writes into `f` and produces the `fmt::Result` the signature demands; as the last expression (no semicolon — Lesson 6 rules), that result is the return value. Why isn't this derivable like `Debug`? Because `Debug` answers a programmer's question — *what is in this thing?* — so an honest dump is always correct, while `Display` answers a human's question — *what should this look like?* Menu board, hindi X-ray: presentation is a decision you sign by hand. Once the impl exists, `println!("{}", adobo)`, `format!("{adobo}")`, and even a free `.to_string()` all just work.

---

## Key Takeaways

- **A trait is a contract about behavior.** `trait Summarize { fn summary(&self) -> String; }` declares what a signer can DO and says nothing about its fields — iba-ibang ulam, isang sandok. Each type signs with `impl Summarize for Type`, and the compiler enforces completeness with E0046: duck typing's runtime surprise, moved to compile time.
- **Default methods are free behavior:** a body in the trait is inherited by every implementor, may call required methods, and can be overridden per type — the type's own `impl` wins, the default is the fallback.
- **`&impl Summarize` is a trait bound:** one function for every signer, and inside it only contract methods exist. `fn f<T: Summarize>(x: &T)` is the same bound in generic clothes — that's tomorrow.
- **`#[derive]` auto-writes trait impls.** `Debug` (`{:?}`), `Clone` (`.clone()`), `PartialEq` (`==`) — you've been implementing traits since Lesson 13 with the compiler as ghostwriter.
- **`Display` is the trait behind `{}`** — deliberately not derivable, because human-facing output is a judgment call. One `impl fmt::Display`, one `write!(f, ...)`, and `println!("{}")` plus a free `.to_string()` both wake up.

---

## What's Next?

That evening, still riding the Display high, Dan started the best-sellers section of the daily report. Finding the priciest dish was easy — `fn largest_u32(list: &[u32]) -> u32`, straight out of Lesson 8 muscle memory. Then he remembered the other list: each dish's average customer rating, and ratings — unlike pesos — live in `f64`. His cursor was already on `largest_u32`, fingers on Ctrl+C, the new name pre-typed in his head: `largest_f64`. Same body, two type names changed — the exact twin-function smell from this afternoon, except this time the duplication isn't in the *behavior*. It's in the *types*. If one function can serve any type that can *summarize*, can one function serve any type that can be *compared*?

**Next Lesson: Generics** — type parameters, trait bounds doing real work, and the day `largest_f64` gets deleted before it's even born.
