# Lesson 20 Quiz: Traits

---
# Quiz 1
## Scenario: Iba-Ibang Ulam, Isang Sandok

Dan has `print_menu_summary(&MenuItem)` and `print_sales_summary(&DailySales)` — twin bodies, different parameter types, a third copy looming for receipts. Kuya JM points at the serving rack: five ulam, one sandok.

**Question 1:** What exactly does `trait Summarize { fn summary(&self) -> String; }` declare?
A. A new struct with a `summary` field
B. A contract about behavior: any type may call itself a `Summarize`, provided it supplies a `summary` method with exactly this signature — WHAT you can do, never WHAT you are
C. A function that automatically summarizes any value
D. A module that groups related types together

**Answer:** B
**Explanation:** A required method declares name, parameters, and return type — no body. The body is the signer's problem, and the contract never mentions fields: struct or enum, two fields or twenty, the trait doesn't know and doesn't care.

---

**Question 2:** After writing the trait, Dan wonders: is `Summarize` now a type, like `MenuItem`?
A. Yes — `let x = Summarize { ... }` builds one
B. Yes — traits and structs are interchangeable
C. No — a trait is a contract that existing types sign via `impl Summarize for Type`. You never instantiate it; `MenuItem` and `DailySales` remain completely different types that happen to share a signed capability
D. No — a trait is just a comment convention with no compiler meaning

**Answer:** C
**Explanation:** Iba-ibang ulam, isang sandok: the types stay different, the capability is shared. The contract is enforced too — sign the trait but skip `summary` and E0046 (`not all trait items implemented`) stops the build at compile time, not at runtime in front of the customers.

---

**Question 3:** `short_label` has a body INSIDE the trait and calls `self.summary()` — yet it appears in neither `impl` block. What do `MenuItem` and `DailySales` get?
A. Nothing — a method must appear in the impl block to exist
B. A compile error: a trait method cannot call another trait method
C. Both types can call `.short_label()` for free — a default method is inherited by every signer, and because its body calls the required `summary`, each free label still comes out personalized
D. Only `MenuItem` gets it, because it signed the contract first

**Answer:** C
**Explanation:** A method with a body in the trait is a default method. That is the power move: implement one small required method, inherit a whole API built on top of it — libre, pero pwedeng palitan.

---

**Question 4:** Dan overrides `short_label` inside `impl Summarize for DailySales` ONLY — the `[KITA ...]` version Tita Malou wanted. What prints now?
A. Both types print the `[KITA ...]` version — the newest definition wins globally
B. `adobo.short_label()` still prints `[REPORT] Adobo — ₱75` (the trait default), while `tuesday.short_label()` prints the `[KITA ...]` override — Rust checks the type's own impl block first and falls back to the trait default only if nothing is there
C. Compile error — default methods cannot be overridden
D. Both keep the default; overriding requires defining a brand-new trait

**Answer:** B
**Explanation:** Defaults are overridable per type: the type's own `impl` wins, the default is the fallback. One type overrode, the other kept the freebie — same trait, same program, side by side.

---
