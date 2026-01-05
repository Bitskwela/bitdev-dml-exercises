# Constants and Named Addresses

## Scene: The Configuration Dilemma

Loy reviews the deployment scripts for MoveStack's test network. Neri hovers nearby, watching the configuration values get hardcoded throughout the codebase.

"This is going to bite us," Loy says, shaking his head. "Every time we need to change a limit, we hunt through ten different files. Last week I missed one MAX_SUPPLY value and the whole testnet deploy failed."

Ronnie joins the conversation, tablet in hand. "Constants solve this. Define a value once at the top of your module, reference it everywhere. Change it in one place, and the entire codebase updates."

"What about addresses?" Neri asks. "I've been hardcoding @0x1 and @0x2 everywhere, and honestly I'm losing track of which address is which."

"Named addresses," Ronnie replies. "Instead of @0x1, you use @movestack or @admin. The Move.toml maps the name to the actual address. When you deploy to mainnet, you just update the mapping—no code changes needed."

Loy pulls up a configuration module on his screen. "Let's refactor MoveStack's config. We'll define error codes as constants, set system limits, and use named addresses properly. No more magic numbers scattered across the codebase."

"Clean configuration is happy configuration," Neri says, rolling up her sleeves.

---

## 📚 Topics & Deep Lessons

### 1️⃣ **Constants: Values That Never Change**

Constants are compile-time values that remain fixed throughout your module's lifecycle:

```move
module movestack::config {
    // Error code constants - use SCREAMING_SNAKE_CASE
    const EINVALID_AMOUNT: u64 = 1;
    const EUNAUTHORIZED: u64 = 2;
    const ELIMIT_EXCEEDED: u64 = 3;

    // System limit constants
    const MAX_SUPPLY: u64 = 1_000_000_000;
    const MIN_STAKE: u64 = 100;
    const MAX_VALIDATORS: u64 = 100;

    // Use constants in your code
    public fun validate_amount(amount: u64) {
        assert!(amount > 0, EINVALID_AMOUNT);
        assert!(amount <= MAX_SUPPLY, ELIMIT_EXCEEDED);
    }
}
```

**Key properties of constants:**

- **Compile-time evaluation**: Constants are embedded directly into the bytecode
- **No storage cost**: Unlike state, constants don't cost gas to read
- **Module-scoped**: Constants are private to the module by default
- **Naming convention**: Use `SCREAMING_SNAKE_CASE` for clarity

### 2️⃣ **Types of Constants**

Move supports several constant types:

```move
module movestack::constant_types {
    // Integer constants (most common)
    const MAX_U8: u8 = 255;
    const MAX_U64: u64 = 18446744073709551615;
    const MAX_U128: u128 = 340282366920938463463374607431768211455;

    // Boolean constants
    const IS_TESTNET: bool = true;
    const FEATURE_ENABLED: bool = false;

    // Address constants
    const ADMIN_ADDRESS: address = @0x1;
    const TREASURY_ADDRESS: address = @movestack;

    // Vector constants (byte strings)
    const MODULE_NAME: vector<u8> = b"movestack";
}
```

### 3️⃣ **Error Code Patterns**

Well-organized error codes make debugging easier:

```move
module movestack::errors {
    // Group error codes by category
    // 1-99: Input validation errors
    const EINVALID_INPUT: u64 = 1;
    const EEMPTY_VALUE: u64 = 2;
    const EOUT_OF_RANGE: u64 = 3;

    // 100-199: Authorization errors
    const EUNAUTHORIZED: u64 = 100;
    const ENOT_OWNER: u64 = 101;
    const EPAUSED: u64 = 102;

    // 200-299: State errors
    const EALREADY_EXISTS: u64 = 200;
    const ENOT_FOUND: u64 = 201;
    const EINVALID_STATE: u64 = 202;

    // Use with assert!
    public fun only_owner(caller: address, owner: address) {
        assert!(caller == owner, ENOT_OWNER);
    }
}
```

### 4️⃣ **Named Addresses: Readable Deployments**

Named addresses replace cryptic hex values with meaningful names:

```toml
# Move.toml
[addresses]
movestack = "0x1234567890abcdef"
admin = "0xABCDEF1234567890"
treasury = "0xFEDCBA0987654321"
```

Now in your code:

```move
module movestack::treasury {
    use std::signer;

    const TREASURY: address = @treasury;
    const ADMIN: address = @admin;

    public fun is_admin(account: &signer): bool {
        signer::address_of(account) == ADMIN
    }

    public fun get_treasury_address(): address {
        TREASURY
    }
}
```

**Benefits:**

- **Readability**: `@treasury` is clearer than `@0xFEDCBA0987654321`
- **Deployment flexibility**: Change addresses in Move.toml, not in code
- **Environment-specific**: Different addresses for testnet vs mainnet

### 5️⃣ **Self-Referential Module Address**

Every module knows its own address:

```move
module movestack::self_aware {
    use std::signer;

    // @movestack is this module's address
    const MODULE_ADDR: address = @movestack;

    public fun is_module_call(caller: &signer): bool {
        signer::address_of(caller) == MODULE_ADDR
    }

    // Access the module's address programmatically
    public fun get_module_address(): address {
        @movestack
    }
}
```

### 6️⃣ **Constants vs State: When to Use Each**

| Use Constants For               | Use State For                        |
| ------------------------------- | ------------------------------------ |
| Error codes                     | User balances                        |
| System limits                   | Configuration that admins can change |
| Mathematical values (π, e)      | Counters and accumulators            |
| Fixed addresses                 | Dynamic addresses                    |
| Feature flags (at compile time) | Feature flags (runtime toggleable)   |

```move
module movestack::comparison {
    // CONSTANT: Never changes, embedded in bytecode
    const MAX_SUPPLY: u64 = 1_000_000_000;

    // STATE: Can change at runtime
    struct Config has key {
        current_supply: u64,
        is_paused: bool,
    }
}
```

---

## Closing Scene

Neri commits the refactored configuration module. Every error code has a constant. Every limit is defined once. Every address has a name.

"Deploy to testnet," she says confidently.

Loy runs the deployment script. It completes in seconds—no hunting for magic numbers, no address mismatches.

"When we go to mainnet," Loy says, "we just update Move.toml with the production addresses. Zero code changes."

Ronnie nods approvingly. "Configuration done right. Now let's document it so everyone knows what these constants mean."

---

## Summary

- **Constants** are compile-time values defined with `const`
- Use **SCREAMING_SNAKE_CASE** for constant names
- Group **error codes** by category (1-99, 100-199, etc.)
- **Named addresses** like `@movestack` replace hex addresses
- Define address mappings in **Move.toml** for deployment flexibility
- Constants have **zero storage cost**—they're embedded in bytecode
- Use constants for **fixed values**, state for **dynamic values**
