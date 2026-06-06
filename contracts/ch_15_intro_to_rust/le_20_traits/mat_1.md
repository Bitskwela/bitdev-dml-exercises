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
