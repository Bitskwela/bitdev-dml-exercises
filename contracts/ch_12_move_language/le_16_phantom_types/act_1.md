## Smart contract activity

```move
module movestack::tokens {
    // TODO: Create marker structs for Gold and Silver

    // TODO: Create Token struct with phantom type parameter
    // struct Token<phantom Currency> has store, drop, copy { amount: u64 }

    public fun create_gold(amount: u64): Token<Gold> {
        // TODO: Return a Gold token
    }

    public fun create_silver(amount: u64): Token<Silver> {
        // TODO: Return a Silver token
    }

    public fun get_amount<Currency>(token: &Token<Currency>): u64 {
        // TODO: Return the token's amount
    }

    public fun merge<Currency>(a: Token<Currency>, b: Token<Currency>): Token<Currency> {
        // TODO: Combine two tokens of the same type
    }
}
```

## Tasks for Learners

Use phantom type parameters to create type-safe token wrappers. Phantom types exist only at compile time and enforce type safety without runtime overhead.

- Create marker structs for different currency types (empty structs used as type tags):

  ```move
  struct Gold {}
  struct Silver {}
  ```

- Create the Token struct with a phantom type parameter:

  ```move
  struct Token<phantom Currency> has store, drop, copy {
      amount: u64
  }
  ```

- Implement `create_gold` to return a Gold token:

  ```move
  public fun create_gold(amount: u64): Token<Gold> {
      Token { amount }
  }
  ```

- Implement `create_silver` to return a Silver token:

  ```move
  public fun create_silver(amount: u64): Token<Silver> {
      Token { amount }
  }
  ```

- Implement `get_amount` to read the token value for any currency type:

  ```move
  public fun get_amount<Currency>(token: &Token<Currency>): u64 {
      token.amount
  }
  ```

- Implement `merge` to combine two tokens of the same currency type:

  ```move
  public fun merge<Currency>(a: Token<Currency>, b: Token<Currency>): Token<Currency> {
      Token { amount: a.amount + b.amount }
  }
  ```

### Breakdown for learners

**Phantom type parameters** are type parameters that don't appear in any field of the struct. They're marked with the `phantom` keyword and exist only at compile time.

**Why use phantom types?**

- **Type safety**: `Token<Gold>` and `Token<Silver>` are different types—you can't accidentally mix them
- **Zero runtime cost**: Phantom types are erased at runtime; both are just `{ amount: u64 }`
- **Compile-time enforcement**: The compiler prevents type mismatches

**The `phantom` keyword:**

```move
struct Token<phantom Currency> has store, drop, copy {
    amount: u64  // Currency doesn't appear here
}
```

Without `phantom`, Move would require `Currency` to appear in a field. The `phantom` keyword tells Move this is intentional.

**Marker structs (type tags):**

Empty structs like `struct Gold {}` serve as type markers. They have no data—their only purpose is to distinguish types at compile time.

**Generic functions with phantom types:**

```move
public fun merge<Currency>(a: Token<Currency>, b: Token<Currency>): Token<Currency>
```

This function works with any currency, but both inputs must be the **same** currency type. Trying to merge `Token<Gold>` with `Token<Silver>` is a compile error.
