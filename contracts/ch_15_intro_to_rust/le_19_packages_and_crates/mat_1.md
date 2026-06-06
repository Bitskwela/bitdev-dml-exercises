## Dan's Story: The Twenty-Third Floor

Modules organize code *inside* one program — Lesson 18 settled that. But staring at his LutoCLI roadmap, Dan saw the limit: his peso formatting and his discount math will be needed in the kita checker he's building now, in LutoCLI at the capstone, in every Luto tool after that. Was he really going to copy-paste his own functions between projects forever? He sent the question to Kuya JM and got back: *"Hatid mo na lang dito sa office bukas."* So: LRT-2 from Santolan, MRT down to Ayala, a VISITOR badge at the lobby turnstile, and an elevator to the twenty-third floor.

> **Dan:** Kuya, ang lamig dito. Parang meat locker na may free coffee.
>
> **Kuya JM:** That's the BPO experience, paps. Halika — fifteen minutes before my standup, may ipapakita ako.

JM pulled a second chair to his desk and opened the team's repository: payment reconciliation, six months into the Rust rewrite.

```text
recon/
├── pesocore/        <- shared library crate
├── matcher/         <- service: pairs payments with invoices
├── reporter/        <- service: end-of-day summaries
└── alerts/          <- service: yells when money goes missing
```

> **Kuya JM:** Lahat ng currency math namin — rounding rules, formatting, tolerances — minsan lang sinulat, minsan lang tine-test. Pag may bug sa pera, isang lugar lang ang hahanapan. A module shares code inside ONE program. `pesocore` is a **crate** — a whole separate project whose only job is to be borrowed by other programs.

JM clicked into `matcher`'s `Cargo.toml` and pointed at one line — `pesocore = { path = "../pesocore" }`. Isang linya, the entire relationship.

> **Dan:** Kuya. My peso formatting. My senior discount function. I was literally planning to copy-paste myself.
>
> **Kuya JM:** And then one copy gets the bug fix and the other doesn't, and two tools print different sukli for the same order. Gawin mong library: `cargo new lutolib --lib`. Yung serde at rand na nakikita mo sa forums? Galing sa crates.io — ang **palengke ng code**, more than a hundred thousand stalls, isang `cargo add` ang layo. Pero palengke nga siya: check mo muna ang tindahan bago ka bumili.
>
> **Dan:** Pero Kuya, the carinderia desktop has no internet. Kung dependent ako sa palengke...
>
> **Kuya JM:** Good instinct, wrong worry. Dependencies are a build-time thing — pag na-compile mo na, buo na ang binary. For LutoCLI? Standard library muna. Master your own kitchen first.

*Lutolib.* Dan wrote it on his palm with his finger and spent the whole ride home sketching two folders, side by side.

---

## The Concept: Packages, Crates, and the Palengke

### A Package vs a Crate

A **crate** is one compilation unit — the thing `rustc` compiles in one go. Every program you've built in this course was a crate and nobody told you. A **package** is what `cargo new` actually creates: a `Cargo.toml` plus the crate (or crates) it owns — at most one library crate, any number of binary crates. In practice, one package wraps exactly one crate, so people use the words interchangeably at the kape machine. The compiler never confuses them, and now neither will you.

| Term | What it is | In today's project |
|---|---|---|
| **Crate** | One compilation unit: binary (runnable) or library (borrowable) | `lutolib` is a library crate; `kita-checker` is a binary crate |
| **Package** | `Cargo.toml` + the crates it owns; the folder `cargo new` makes | the `lutolib/` folder; the `kita-checker/` folder |
