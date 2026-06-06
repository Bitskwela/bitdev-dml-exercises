# Lesson 12 Quiz: Strings

---
# Quiz 1
## Scenario: Two Errors, Two Types

Dan glues a receipt with `header + line` and the compiler says no twice — E0369, then E0382. Kuya JM's video-call verdict: String is the pot you own; `&str` is looking into someone else's pot.

**Question 1:** What is the actual difference between `String` and `&str`?
A. `String` is for long text, `&str` is for short text
B. `String` OWNS its text — heap-allocated and growable; `&str` BORROWS a read-only view of text owned elsewhere, like a literal baked into the binary
C. They are two spellings of the same type
D. `&str` is the mutable one, `String` is read-only

**Answer:** B
**Explanation:** The pot and the look. A `String` is your own pot — fill it, grow it, all day. A `&str` is a view into someone else's pot: you can read everything, but you can't grow what you're only looking at. Literals like `"Adobo ₱75\n"` are `&'static str` — views into text baked into the compiled binary.

---

**Question 2:** Dan writes `let receipt = header + line;` where `header` is a `String`, then prints `header` on the next line. What happens, and why does `format!` not have this problem?
A. Both compile — `+` copies its operands
B. E0382: `+` MOVES the left side (it takes your pot, stirs in the right side, and returns the same pot), so `header` is gone; `format!` only BORROWS its arguments and returns a brand-new String, so nothing moves
C. E0382, because `format!` also moves its arguments — neither works
D. `+` fails at runtime with a panic, not at compile time

**Answer:** B
**Explanation:** `+` is a move wearing a math costume — it consumes the left `String` and only borrows the right `&str`. Reuse the left side and E0382 finds you. `format!` has `println!` syntax, borrows every argument, and hands back a new `String`. Walang namamatay — which is why this course retires `+` today.

---

**Question 3:** What is the difference between `push_str` and `push` when growing a `String`?
A. `push_str` appends a `&str` (a borrowed view, still alive afterwards); `push` appends exactly ONE `char`, written in single quotes
B. They are aliases — both append strings
C. `push` appends a `&str`; `push_str` appends a `char`
D. `push_str` moves its argument into the String, killing it

**Answer:** A
**Explanation:** `receipt.push_str("Adobo ₱75\n")` appends a borrowed `&str` — the argument survives. `receipt.push('\n')` appends a single `char` — single quotes, not double. Both require the pot to be `mut`: you're changing what you own, and Lesson 4's rules never stopped applying.

---

**Question 4:** Dan needs a receipt line like `Adobo              ₱ 75` and then needs `dish1` again for the next receipt. Which is the course-approved build, and why?
A. `let line = dish1 + " ₱75";` — `+` is the standard tool
B. `let line = format!("{:<18} ₱{:>3}\n", dish1, 75);` — readable template, borrows `dish1` so it stays usable, and returns a new owned `String` to push_str into the receipt
C. `let line = dish1.clone() + " ₱75";` — clone everything to be safe
D. `receipt[i] = dish1;` — index assignment

**Answer:** B
**Explanation:** Build lines with `format!`, assemble them with `push_str` — the pair that builds every receipt, report, and menu board for the rest of the course. `+` wouldn't even compile here (`&str + &str` is E0369), and cloning to survive a `+` is solving a problem `format!` doesn't have.

---

# Quiz 2
## Scenario: The Peso Sign's Two Stowaways

Kuya JM: "Type `"Halo-Halo ₱95"` and print `.len()`. Count the characters with your eyes first. Slowly." Dan counts thirteen. The terminal says 15.

**Question 5:** Why do `.len()` and `.chars().count()` disagree on `"Halo-Halo ₱95"` — 15 vs 13?
A. `.len()` counts the quotes too
B. A trailing newline is hiding in the literal
C. `.len()` counts BYTES and `.chars().count()` counts CHARACTERS — the string is UTF-8, and `₱` is one character encoded as THREE bytes, so 12 ASCII bytes + 3 peso bytes = 15
D. It's a rounding bug in `.len()`

**Answer:** C
**Explanation:** Rust strings are UTF-8: a character takes one to four bytes — `H` is one, `₱` is three. The two counts agree on pure-ASCII text and silently disagree the moment a `₱` walks in. If your receipt-width math uses `.len()`, your columns drift on every line with a peso sign — count characters when you mean characters.

---

**Question 6:** `first_word` was written in Lesson 11 with the signature `fn first_word(s: &str) -> &str`. Dan calls `first_word(&receipt)` where `receipt` is a `String`. What happens?
A. E0308: mismatched types — a `&String` is not a `&str`
B. It compiles unchanged — Rust quietly coerces `&String` into `&str` at the call site, so the function written for literals works on Dan's owned receipt too
C. It compiles, but only because `String` and `&str` are secretly the same type
D. It compiles after Rust clones the String into a `&str`

**Answer:** B
**Explanation:** Deref coercion: `&String` becomes `&str` automatically at the call site — no clone, no edit, no ceremony. That's why a `&str` parameter accepts everything: literals, slices, and `&String`s alike. The function answered (`**`, the receipt's first word) without a single change.

---

**Question 7:** The course rule is "functions take `&str`, structs own `String`." What's the reasoning?
A. `&str` is faster to type, and structs can't hold references at all
B. Borrow to read, own to keep: a `&str` parameter welcomes every kind of string without taking ownership, while data that must LIVE somewhere long-term needs an owner holding a growable `String`
C. It's purely a style convention with no technical consequence
D. Functions are forbidden from receiving `String` by the compiler

**Answer:** B
**Explanation:** A function usually just reads its string argument, so it should borrow the most welcoming type — `&str` accepts literals, slices, and coerced `&String`s. But when data needs a long-term home (like the `MenuItem` structs arriving next lesson), the owner holds a `String` — owned, growable, alive as long as its owner. Borrow to read, own to keep.

---
**Next:** Proceed to Lesson 12 exercises.
