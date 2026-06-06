# Lesson 16 Quiz: Error Handling

---
# Quiz 1
## Scenario: The Ghost on Row 113

Dan calls Ate Rina at 11 PM and replays the Sunday crash in Rust — and `let total: u32 = "120".parse::<u32>();` won't even compile.

**Question 1:** Rust splits all failure into two categories. Which pairing is correct?
A. `panic!` for bad user input; `Result` for programmer bugs
B. `panic!` for unrecoverable programmer bugs — impossible states where continuing makes things worse; `Result` for expected, recoverable failures like a blank cell or garbage in a price column
C. Both kinds arrive the same way: a runtime traceback, whenever it feels like it
D. `panic!` is deprecated; everything must be a `Result`

**Answer:** B
**Explanation:** A panic says "the bug is in the code, not the input." Expected bad input is not a bug — it's Tuesday — so it gets a `Result` and a written-down decision. In Python both failures arrived identically at runtime; Rust makes you sort them at compile time.

---

**Question 2:** When should Dan reach for `Result<T, E>` instead of `Option<T>`?
A. Never — they are interchangeable
B. When the value might be missing and absence is the whole story
C. When the caller would ask "okay, but *bakit*?" — `Result`'s `Err(E)` carries the reason a thing failed; `Option`'s `None` carries nothing because absence IS the answer
D. `Result` is for numbers, `Option` is for strings

**Answer:** C
**Explanation:** `Option` answers "is there a value at all?" (may sinigang pa ba — meron o wala). `Result` answers "did it work — and if not, WHY?" Both are plain enums, so `match` exhaustiveness guards them equally.

---

**Question 3:** What does `"120".parse::<u32>()` actually return?
A. A bare `u32` — the string is obviously a number
B. `Result<u32, ParseIntError>` — never a bare number, because the string could have been `"abc"` or `""`, and the compiler refuses to let you pretend otherwise (E0308)
C. `Option<u32>` — `None` if parsing fails
D. `0` if parsing fails

**Answer:** B
**Explanation:** `.parse()` cannot promise a number, so it hands you a box: the value or the reason it isn't one. The blank cell that ambushed Dan at runtime in Python is, in Rust, a compile error until you've answered for it.

---

**Question 4:** Inside `parse_price`, what exactly does the `?` in `s.trim().parse::<u32>()?` do?
A. Silently converts the error into a default value of zero
B. Panics with a nicer message if the parse fails
C. If `Ok(v)`, unwraps to `v` and keeps going; if `Err(e)`, returns that `Err` from the enclosing function immediately — an early return that hands the error to the caller unopened
D. Retries the parse until it succeeds

**Answer:** C
**Explanation:** `?` is an early return, nothing more. That's also why it only compiles inside functions whose return type can receive the error — slapping `?` in a bare `main` earns a compile error instead of a surprise.

---

# Quiz 2
## Scenario: Zero Unwraps Before Lunch

LutoCLI prep. A teammate ships `let price: u32 = input.trim().parse::<u32>().unwrap();` for the field where Tita Malou types each price by hand.

**Question 5:** A customer order comes in and Tita Malou types `"1S0"` — a typo. What happens, and why is `unwrap()` the wrong tool here?
A. Nothing — `unwrap()` returns 0 on bad input
B. The program panics and dies mid-lunch-rush, in front of the user: `unwrap()` turned recoverable bad input into an unrecoverable crash, betting the input was clean — and hand-typed input always loses that bet eventually
C. The compiler catches the typo before the program runs
D. Rust automatically asks her to retype it

**Answer:** B
**Explanation:** `unwrap()` rips the box open and panics on `Err`. A typo is expected, recoverable input — it deserves a `match` with a polite message, not a funeral. This is the Sunday failure mode in miniature: choose who gets the error.

---

**Question 6:** Same form, two fields. The *tip* field left blank simply means walang tip; the *price* field with garbage means the order can't be recorded and the user needs to be told. Which handling fits each?
A. `unwrap()` for both — fastest to type
B. Full `match` for both — always use maximum ceremony
C. Tip: `unwrap_or(0)` — a sensible default genuinely exists; Price: a full `match` (or `?` up to a caller with context) — bad input there deserves a real message, not a silent zero
D. Tip: `panic!`; Price: `unwrap_or(0)`

**Answer:** C
**Explanation:** Match the tool to the situation. A blank tip has a true default, so the tolerant one-liner is honest. A garbage price silently becoming P0 would corrupt the day's report — that failure needs visible handling.

---

**Question 7:** The house rule says `unwrap()` is fine in prototypes labeled `// PROTOTYPE:` but BANNED from LutoCLI's final code, where the `unwrap` grep count must be zero. Why allow it at all, and why the label?
A. The label makes the code run faster in release mode
B. `unwrap()` is a compile error without the comment
C. In a quick experiment a crash costs nothing, so `unwrap()` is legitimate there — and the label makes the bet visible and greppable, so no "hope the input is clean" wager survives into code Tita Malou runs
D. There is no reason; the rule is arbitrary

**Answer:** C
**Explanation:** Every `unwrap()` is a small bet that the input is clean, and Dan has personally watched that bet lose on a Sunday. The label is the point: hope is allowed only when it's written down, temporary, and removed before the code faces a real user.

---
**Next:** Proceed to Lesson 16 exercises.
