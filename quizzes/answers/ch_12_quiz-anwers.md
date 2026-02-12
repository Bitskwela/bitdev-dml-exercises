# Chapter 12 — Quiz Answer Key (with Questions)

Source: `quiz.md`

1. Q1 — Which programming language is designed specifically for resource-oriented smart contract development on blockchains like Sui and Aptos?

   - Answer: **B** — Move

2. Q2 — Which keyword is used to define a smart contract unit in Move?

   - Answer: **B** — `module`

3. Q3 — What are the four abilities in Move?

   - Answer: **B** — `copy, drop, store, key`

4. Q4 — Which unsigned integer type is most commonly used in Move for balances and amounts?

   - Answer: **C** — `u64`

5. Q5 — In Move, a struct without any abilities cannot be copied, dropped, or stored.

   - Answer: **True**

6. Q6 — Move allows multiple resources of the same type to be stored under a single address.

   - Answer: **False**

7. Q7 — Which ability allows a struct to be stored as a top-level resource in global storage?

   - Answer: **A** — `key`

8. Q8 — The 'store' ability allows a struct to be stored inside other structs.

   - Answer: **True**

9. Q9 — Which function is used to store a resource under an address in global storage?

   - Answer: **C** — `move_to`

10. Q10 — Constants in Move can be modified after the module is deployed.

    - Answer: **False**

11. Q11 — When you assign a value to a new variable in Move, what happens to the original variable by default?

    - Answer: **B** — `move` (original is moved)

12. Q12 — Primitive types like u64 and bool have the 'copy' ability by default.

    - Answer: **True**

13. Q13 — What is the syntax for an immutable reference in Move?

    - Answer: **A** — `&T`

14. Q14 — A mutable reference (&mut T) allows you to modify the referenced value.

    - Answer: **True**

15. Q15 — Which annotation must be added to a function that accesses global storage resources?

    - Answer: **D** — `acquires`

16. Q16 — In Move, you can have multiple mutable references to the same value at the same time.

    - Answer: **False**

17. Q17 — Which control flow construct is used for conditionals in Move?

    - Answer: **B** — `if/else`

18. Q18 — The 'while' and 'loop' keywords are used for iteration in Move.

    - Answer: **True**

19. Q19 — Which keyword immediately stops execution and reverts all state changes in Move?

    - Answer: **C** — `abort`

20. Q20 — The assert! macro aborts execution if its condition evaluates to false.

    - Answer: **True**

21. Q21 — Which type is used to represent a value that may or may not exist in Move?

    - Answer: **A** — `Option<T>`

22. Q22 — Vectors in Move can grow dynamically using vector::push_back.

    - Answer: **True**

23. Q23 — Which function adds an element to the end of a vector?

    - Answer: **B** — `vector::push_back`

24. Q24 — Tables in Move can be iterated directly using a for loop.

    - Answer: **False**

25. Q25 — Which visibility modifier allows only declared friend modules to call a function?

    - Answer: **C** — `public(friend)`

26. Q26 — Entry functions can be called directly by blockchain transactions.

    - Answer: **True**

27. Q27 — What is the syntax for declaring a generic type parameter in Move?

    - Answer: **D** — `<T>`

28. Q28 — Generic type parameters can be constrained with abilities like 'T: copy + drop'.

    - Answer: **True**

29. Q29 — Which keyword marks a type parameter that is only used at the type level, not in fields?

    - Answer: **A** — `phantom`

30. Q30 — The witness pattern uses a struct that can only be created once to prove authorization.

    - Answer: **True**

31. Q31 — Which attribute marks a function as a unit test in Move?

    - Answer: **B** — `#[test]`

32. Q32 — #[expected_failure] is used to test that a function aborts with a specific error.

    - Answer: **True**

33. Q33 — Which function is typically used to emit events in Move?

    - Answer: **C** — `event::emit`

34. Q34 — Events in Move are stored on-chain and can be queried from within smart contracts.

    - Answer: **False**

35. Q35 — Which design pattern uses structs as permission tokens to grant access to restricted operations?

    - Answer: **A** — Capability pattern

36. Q36 — Minimizing global storage reads and writes is a key gas optimization technique.

    - Answer: **True**

37. Q37 — What is the primary security benefit of Move's linear type system?

    - Answer: **D** — Prevention of resource duplication and loss

38. Q38 — Move's borrow checker prevents data races by enforcing strict aliasing rules.

    - Answer: **True**

39. Q39 — A struct without any abilities is called a **\_\_** and cannot be copied or dropped.

    - Answer: **resource**

40. Q40 — The function **\_\_** is used to get an immutable reference to a resource in global storage.
    - Answer: **borrow_global**

---

Would you like these expanded with short explanations or exported as CSV/PDF?
