## Dan's Story: The Third Paste

Dorm, 11:47 PM. Dan had three practice projects open — `sukli_drill`, `gcash_practice`, `senior_orders` — and he had just found the same bug in two of them. That afternoon he fixed the senior discount in `senior_orders`: he'd written `total * 20 / 100`, which charges Lola Cion *20% of her bill* instead of taking 20% *off*. Now, at midnight, the exact same line stared back at him from `gcash_practice`. He had copy-pasted the sukli-and-discount block all week, and the fix lived in exactly one of the three copies.

> **Dan:** Kuya, paano mo nilalagay yung sukli computation sa isang lugar lang? Na-paste ko na siya sa tatlong files, tapos yung bug na inayos ko kanina, buhay pa rin sa dalawa.
>
> **Kuya JM:** Kapag inulit mo ng tatlong beses, function na 'yan. Walang debate, walang extension. Rule 'yan sa team namin.
>
> **Dan:** Alam ko naman ang functions. `def` lang yan sa Python.
>
> **Kuya JM:** Rust's `fn` looks similar, pero dalawa ang malaking difference. Una — required ang types sa parameters. Pangalawa — walang `return` keyword most of the time. Yung *huling expression* ng function, yung walang semicolon, yun mismo ang sinasauli niya.

Dan deleted the pasted blocks in all three files and wrote the sukli math exactly once. *Write once, call forever.*

---

## The Concept: `fn`, Mandatory Types, and the Expression That Returns Itself

### The `fn` Syntax — Parameter Types Are Mandatory

In Python, type hints are decoration. The interpreter reads them, shrugs, and runs anyway:

```python
def compute_change(paid, total):      # no types? Python: "bahala na"
    return paid - total               # works until someone passes a string
```

In Rust, parameter types are load-bearing. Leave one out and the program does not exist:

```rust
fn compute_change(paid: u32, total: u32) -> u32 {
    paid - total
}
```

Four parts: `fn`, a name, a typed parameter list, and an arrow to the return type. Because every parameter declares its type, the compiler checks *every single call site* in the program. Pass a `String` where a `u32` belongs and you find out at compile time, in your dorm — not at the counter in front of a customer.

### `->` Declares the Return Type

`-> u32` says what comes back. No arrow means the function returns nothing meaningful:

```rust
fn greet_customer(name: &str) {        // no `->` = returns ()
    println!("Welcome po, {}!", name); // side effect only, no value
}
```

`println!` is a side effect; nothing flows back to the caller. The function's type is honest about that.

### Expressions vs Statements — the One Idea to Actually Internalize

Rust divides all code into two camps:

| Kind | Example | Produces a value? |
|------|---------|-------------------|
| Statement | `let x = 5;` | No — it *does* something |
| Expression | `5 + 3` | Yes — `8` |
| Expression | `compute_change(200, 100)` | Yes — `100` |
| Block expression | `{ let a = 2; a + 3 }` | Yes — `5` |
| Expression + `;` | `paid - total;` | **No** — value discarded, leaves `()` |

A function body is just a big block, and a block evaluates to its last semicolon-less line. That bare final expression IS the return value — no `return` keyword needed (it exists, but it's for early exits). A semicolon takes an expression, throws its value in the trash, and turns it into a statement. Which sets up the classic newcomer trap — a reflex semicolon on the last line:

```rust
fn compute_change_broken(paid: u32, total: u32) -> u32 {
    paid - total;    // <- that semicolon discards the value
}
```

The signature promised `u32`; the body now ends with nothing. The compiler's actual response:

```text
error[E0308]: mismatched types
  --> src\main.rs:23:52
   |
23 | fn compute_change_broken(paid: u32, total: u32) -> u32 {
   |    ---------------------                           ^^^ expected `u32`, found `()`
   |    |
   |    implicitly returns `()` as its body has no tail or `return` expression
24 |     paid - total; // that semicolon turns the value into ()
   |                 - help: remove this semicolon to return this value
```

Read it like Kuya JM taught: the compiler didn't just reject the code — the `help:` line diagnosed the disease and prescribed the cure. *Remove this semicolon to return this value.*

### The Unit Type `()`

`()` is Rust's way of writing "nothing meaningful here." It's what a function returns when it returns nothing — no arrow in the signature means `-> ()` implicitly, and a trailing semicolon on your last line means the body produces `()` whether you wanted it to or not.

### Naming: `snake_case`, Always

Rust functions and variables are `snake_case`: `compute_change`, `apply_senior_discount`, `receipt_line`. Write `computeChange` and the compiler still compiles it — but it throws `warning: ... should have a snake case name` at you, and so will every Rust programmer who reads your code. Save camelCase for your JavaScript era.

---

## Key Takeaways

- **`fn` declares a function.** Name in `snake_case`, parameters in parentheses, return type after `->`.
- **Parameter types are mandatory** — not optional hints like Python's. The compiler uses them to check every call site before the program ever runs.
- **Rust is expression-based.** The last expression in a function body — written *without* a semicolon — is the return value.
- **A semicolon discards a value.** Put one on your last line and the function returns `()` instead — `error[E0308]: expected u32, found ()`, with a `help:` line that names the exact fix.
- **The rule of three:** kapag inulit mo ng tatlong beses, function na 'yan. One definition, many calls, zero out-of-sync bugs.

---

## What's Next?

Dan now has functions — but his functions are obedient calculators. They take numbers in, push numbers out, and never make a *decision*. In Rust, `if` is an expression too, and that changes how branching feels. Tomorrow, rain empties the streets of Marikina, Tita Malou sells out of sinigang by 1 PM, and Dan rebuilds the tiniest piece of Luto's rule engine: *rainy day → push sinigang*.

**Next Lesson: Control Flow** — `if`/`else` as expressions, branching on the weather, and the moment the computer agrees with Dan again.
