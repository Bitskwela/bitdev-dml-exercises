# Act 1: Type Inference

## Initial Code

```move
module inference_exercise::type_practice {
    use std::vector;

    struct Account has drop {
        id: u64,
        balance: u64,
        active: bool
    }

    // TODO: Fix the following functions by adding type annotations
    // ONLY where necessary. Remove unnecessary annotations.

    // Problem 1: This has TOO MANY annotations - simplify it
    public fun over_annotated(): u64 {
        let x: u64 = 10u64;
        let y: u64 = 20u64;
        let sum: u64 = x + y;
        let result: u64 = sum * 2;
        result
    }

    // Problem 2: This is MISSING required annotations - fix it
    public fun under_annotated() {
        let empty_list = vector[];
        let small_number = 255;  // Should be u8
        let big_number = 1000000000000;  // Should be u128
        vector::push_back(&mut empty_list, small_number);
    }

    // Problem 3: Fix the generic function call
    public fun generic_needs_type(): u64 {
        let value = default_value();
        value
    }

    // Problem 4: Clean up this function - remove unnecessary annotations
    public fun process_account(): bool {
        let account: Account = create_account();
        let balance: u64 = account.balance;
        let threshold: u64 = 100;
        let is_wealthy: bool = balance > threshold;
        is_wealthy
    }

    // Problem 5: Add annotations only where needed for this vector operation
    public fun vector_operations() {
        let numbers = vector[];
        vector::push_back(&mut numbers, 1);
        vector::push_back(&mut numbers, 2);
        let first = *vector::borrow(&numbers, 0);
        let doubled = first * 2;
    }

    // Helper functions
    fun default_value<T: drop>(): T { abort 0 }

    fun create_account(): Account {
        Account { id: 1, balance: 500, active: true }
    }
}
```

---

## Tasks

### Task 1: Simplify over_annotated

Remove unnecessary type annotations—keep only what's required.

```move
public fun over_annotated(): u64 {
    let x = 10u64;
    let y = 20;
    let sum = x + y;
    let result = sum * 2;
    result
}
```

### Task 2: Fix under_annotated

Add required annotations for empty vector and specific numeric types.

```move
public fun under_annotated() {
    let mut empty_list: vector<u8> = vector[];
    let small_number: u8 = 255;
    let _big_number: u128 = 1000000000000;
    vector::push_back(&mut empty_list, small_number);
}
```

### Task 3: Fix generic_needs_type

Specify the type parameter for the generic function call.

```move
public fun generic_needs_type(): u64 {
    let value = default_value<u64>();
    value
}
```

### Task 4: Clean up process_account

Remove annotations the compiler can infer.

```move
public fun process_account(): bool {
    let account = create_account();
    let balance = account.balance;
    let threshold = 100;
    let is_wealthy = balance > threshold;
    is_wealthy
}
```

### Task 5: Fix vector_operations

Add the minimum annotations needed for the vector.

```move
public fun vector_operations() {
    let mut numbers: vector<u64> = vector[];
    vector::push_back(&mut numbers, 1);
    vector::push_back(&mut numbers, 2);
    let first = *vector::borrow(&numbers, 0);
    let _doubled = first * 2;
}
```

---

## Breakdown

### How Type Inference Works

The compiler determines types by analyzing:

1. **Literal suffixes**: `10u64` explicitly marks the type
2. **Function return types**: If `get_balance()` returns `u64`, the variable is `u64`
3. **Operations**: Adding two `u64` values produces `u64`
4. **Usage context**: Passing to a function expecting `u8` implies `u8`

```move
let x = 10u64;    // Type known from suffix
let y = 20;       // Type inferred from x in (x + y)
let sum = x + y;  // Type inferred as u64
```

### When Annotations Are Required

| Situation              | Example              | Why Needed                |
| ---------------------- | -------------------- | ------------------------- |
| Empty collections      | `vector<u64>[]`      | No elements to infer from |
| Specific numeric types | `let x: u8 = 100`    | Default is u64            |
| Generic functions      | `func<u64>()`        | Compiler can't choose     |
| Ambiguous context      | When compiler errors | Multiple valid types      |

### When Annotations Are Optional

| Situation            | Example                          | Why Optional         |
| -------------------- | -------------------------------- | -------------------- |
| From function return | `let x = get_u64()`              | Return type known    |
| From operations      | `let sum = a + b`                | Operand types known  |
| From vector elements | `vector[1u64, 2, 3]`             | First element typed  |
| From usage           | `func(x)` where func expects u64 | Parameter type known |

### Best Practices

1. **Start without annotations**: Let the compiler infer
2. **Add when compiler complains**: It will tell you what's ambiguous
3. **Add for clarity**: When the inferred type isn't obvious to readers
4. **Always annotate function signatures**: Parameters and returns require types
5. **Use suffixes for numeric literals**: `100u8` is clearer than `let x: u8 = 100`

### Common Inference Failures

```move
// FAILS: Empty vector, no context
let v = vector[];  // What type?

// FAILS: Generic with no hints
let x = default<T>();  // What T?

// FAILS: Numeric in isolation
let n = 255;  // Could be u8, u64, u128...
// (Actually defaults to u64, but may not be what you want)
```

Add explicit types only in these cases—trust inference everywhere else.
