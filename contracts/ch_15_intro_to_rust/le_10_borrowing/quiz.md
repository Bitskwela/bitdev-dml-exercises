# Lesson 10 Quiz: Borrowing

---
# Quiz 1
## Scenario: The Utang Notebook

Kuya JM's fix for Dan's five clones is one character long: `&`. Tita Malou's utang notebook explains the rest — everyone can read it at once, but only one hand ever writes in it.

**Question 1:** Dan changes `print_order` to take `&String` and calls it with `print_order(&order1)`. What happens to the ownership of `order1`?
A. It moves into the function and is handed back to Dan when the function returns
B. Nothing — the function only BORROWS the String; ownership never leaves `order1`, so the next line can still use it with no E0382 and no clone
C. The String is cloned automatically behind the scenes
D. `order1` is dropped as soon as `print_order` returns

**Answer:** B
**Explanation:** A reference borrows; it never takes. At the call site `&order1` says "I'm lending this," and in the signature `&String` says "I only borrow." The function reads, returns, the borrow ends — Lesson 9's funeral never happens, so the clone is unnecessary.

---

**Question 2:** What is the difference between `&T` and `&mut T`?
A. They are interchangeable styles of writing the same reference
B. `&T` is a shared, read-only reference and ANY NUMBER may exist at once; `&mut T` is an exclusive read-and-write reference and exactly ONE may exist at a time
C. `&T` is for numbers and `&mut T` is for Strings
D. `&mut T` is just a faster version of `&T`

**Answer:** B
**Explanation:** Shared references are the suki reading his tab over Tita Malou's shoulder — eyes don't garble records, so any number may look. `&mut T` is the one hand holding the pen: write access costs exclusivity, and `mut` must be signed at all three sites — the owner (`let mut`), the lender (`&mut x`), and the signature (`&mut T`).

---

**Question 3:** At any single moment, what mix of references may one value have?
A. Any number of readers AND any number of writers, as long as the program is single-threaded
B. Any number of shared references (`&T`) XOR exactly one exclusive reference (`&mut T`) — many readers OR one writer, never both at once
C. At most one reader and one writer at a time
D. Unlimited references of every kind — the rule only applies to threads

**Answer:** B
**Explanation:** This is the aliasing rule, enforced at compile time: E0502 for reader-vs-writer, E0499 for writer-vs-writer. It bites even single-threaded code for a real reason — appending to a full `String` RELOCATES its text in memory, and a stale reader would be reading garbage. Rust makes that situation unrepresentable.

---

**Question 4:** A reference goes out of scope at the end of a function. What happens to the String it points to?
A. It is dropped and its heap memory is freed
B. Nothing — references never own, so nothing is freed or dropped; the String still dies exactly once, at the end of its OWNER's scope
C. It is moved back to the caller
D. It becomes permanently immutable

**Answer:** B
**Explanation:** You can't drop what you never owned — the borrower handing back the notebook doesn't burn the notebook. References add readers and writers; they never add funerals. Ownership (and the single drop) stays with the owner, exactly as Lesson 9 taught.

---

# Quiz 2
## Scenario: Reading the Verdicts

Dan uncomments three lines and the compiler answers:

```text
error[E0502]: cannot borrow `order2` as mutable because it is also borrowed as immutable
  |
4 |     let reader = &order2;
  |                  ------- immutable borrow occurs here
5 |     add_note(&mut order2);
  |              ^^^^^^^^^^^ mutable borrow occurs here
6 |     println!("{}", reader);
  |                    ------ immutable borrow later used here
```

**Question 5:** Dan deletes line 6 (`println!("{}", reader);`) — and the code compiles, even though the shared borrow on line 4 and the `&mut` on line 5 are both still there. Why?
A. The compiler only checks lines that print something
B. A borrow lives from its creation to its LAST USE, not to the closing brace — without line 6, `reader`'s borrow is already over before the write on line 5, so readers and writer never overlap
C. Deleting any line forces Rust to recompile in a more permissive mode
D. `println!` is special: it locks every variable it mentions until the program ends

**Answer:** B
**Explanation:** The third arrow — "immutable borrow later used here" — is the load-bearing one. Borrows end at their last use, which is why sometimes the entire fix for E0502 is reordering two lines. Note the `&mut` was hiding inside the `add_note` call: the rule applies no matter who is holding the pen.

---

**Question 6:** Next, Dan writes `let first = &mut tab; let second = &mut tab;` and uses both writers afterward. The compiler answers with E0499: "cannot borrow `tab` as mutable more than once at a time." Which fix keeps BOTH writes and compiles?
A. Delete one of the two writes — E0499 has no other fix
B. Wrap writer #1 in a `{ }` block so its borrow provably ends at the closing brace — pen down — before writer #2 begins
C. Declare `tab` as `static` so the rule no longer applies
D. Take a third `&mut` to balance out the first two

**Answer:** B
**Explanation:** E0499 is E0502's sibling: writer-vs-writer, dalawang kamay sa isang notebook. Scope braces end the first borrow early, so the two writers no longer overlap. Reordering so writer #1's last use comes before writer #2 begins also works — same principle, borrows end at their last use.

---

**Question 7:** In C, returning a pointer to a function's local variable compiles without complaint — and the pointer aims at freed memory, maybe crashing weeks later in production. What does Rust do with the equivalent code?
A. Compiles it but prints a warning the first time it runs
B. Rejects it at COMPILE time — the compiler proves every reference's owner is still alive at every use, so a dangling reference is never compiled and the shipped binary cannot contain one
C. Inserts a runtime null check before every dereference
D. Keeps the local variable alive with a garbage collector so the pointer stays valid

**Answer:** B
**Explanation:** A reference can never outlive the value it points to — checked before the binary exists. This is Rust's quiet superpower over C: the dangling pointer isn't caught, handled, or debugged; it is never compiled. The binary Dan someday hands Tita Malou on a USB stick cannot contain one.

---
**Next:** Proceed to Lesson 10 exercises.
