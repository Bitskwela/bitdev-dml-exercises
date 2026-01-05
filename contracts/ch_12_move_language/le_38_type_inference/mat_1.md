# Mat 1: Type Inference

## Scene

Jaymart stared at his screen, surrounded by walls of type annotations. Every variable, every function call—explicitly typed. "Det, my code looks like a legal document. There has to be a cleaner way."

Det rolled his chair over and scanned the code. "You're over-annotating. Move's compiler is smarter than you're giving it credit for. It can infer most of these types."

"But how do I know when to let the compiler figure it out versus when I need to be explicit?" Jaymart asked.

Det pointed to a line. "See this? The compiler knows `get_balance()` returns `u64`. You don't need to tell it again." He deleted the annotation. "Type inference works backwards from how values are used. The compiler traces the flow."

Jaymart leaned back. "So I should never annotate?"

"Not quite. Sometimes you need to be explicit—especially with generics or when the compiler has multiple valid choices. The art is knowing when."

---

## Topics

### 1. Compiler Type Inference

Move's compiler can automatically determine types based on context:

```move
module examples::inference_basics {
    public fun demonstrate_inference() {
        // Compiler infers u64 from the literal
        let amount = 100;

        // Compiler infers type from function return
        let balance = get_balance();  // Inferred as u64

        // Compiler infers from operations
        let total = amount + balance;  // u64 + u64 = u64

        // Compiler infers vector element type from usage
        let mut numbers = vector[];
        vector::push_back(&mut numbers, 42u64);  // Now knows it's vector<u64>
    }

    fun get_balance(): u64 {
        1000
    }
}
```

The compiler traces how values flow through your program to determine their types.

### 2. When to Annotate

Explicit type annotations are needed in specific situations:

```move
module examples::when_to_annotate {
    use std::vector;

    public fun annotation_required() {
        // REQUIRED: Empty collections with no usage context
        let empty_vec: vector<u64> = vector[];

        // REQUIRED: Numeric literals in ambiguous contexts
        let small: u8 = 255;
        let large: u128 = 1000000000000;

        // REQUIRED: Generic function calls without inference context
        let default: u64 = get_default<u64>();

        // REQUIRED: When compiler reports ambiguity error
        let parsed: u64 = parse_number(b"123");
    }

    public fun annotation_optional() {
        // OPTIONAL: Type is clear from assignment
        let balance = get_balance();  // Obviously u64

        // OPTIONAL: Type clear from operation
        let sum = 10u64 + 20;  // 20 inferred as u64

        // OPTIONAL: Vector type clear from elements
        let nums = vector[1u64, 2, 3];  // vector<u64>
    }

    fun get_default<T: drop>(): T { abort 0 }
    fun get_balance(): u64 { 100 }
    fun parse_number(_bytes: vector<u8>): u64 { 0 }
}
```

### 3. Explicit Types in Practice

Strategic use of explicit types improves code clarity:

```move
module examples::explicit_types {
    struct Wallet has drop {
        balance: u64,
        frozen: bool
    }

    public fun practical_examples() {
        // Let inference work for simple cases
        let wallet = create_wallet();
        let is_valid = wallet.balance > 0;

        // Be explicit for numeric precision
        let fee_rate: u128 = 15;  // Prevents overflow in calculations
        let max_value: u64 = 18446744073709551615;

        // Be explicit when destructuring for clarity
        let Wallet { balance: current_balance, frozen: is_frozen } = wallet;

        // Be explicit in function signatures (always required)
        // public fun transfer(from: address, to: address, amount: u64): bool
    }

    public fun generic_context<T: copy + drop>(items: vector<T>): T {
        // Must specify type when calling generic functions
        let first: T = *vector::borrow(&items, 0);
        first
    }

    fun create_wallet(): Wallet {
        Wallet { balance: 100, frozen: false }
    }
}
```

---

## Closing Scene

Jaymart refactored his code, stripping away unnecessary annotations while keeping the essential ones. The result was half as long and twice as readable.

"Much better," Det nodded approvingly. "Now the types that matter stand out, and the obvious ones stay out of the way."

"It's like the compiler and I are partners," Jaymart said. "I tell it what it can't figure out, and it handles the rest."

Det smiled. "That's exactly right. Trust the inference, but verify when it matters. The compiler will tell you when it needs help."

---

## Summary

- Move's compiler infers types from literals, function returns, and operations
- Explicit annotations required for: empty collections, ambiguous numerics, generic calls without context
- Explicit annotations optional when types are clear from context
- Function parameter and return types always require explicit annotation
- Use explicit types strategically for clarity and precision, not everywhere
- When in doubt, omit the annotation—the compiler will error if it needs one
