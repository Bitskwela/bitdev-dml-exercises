# Multi-Module Projects

## Scene: The Tangled Codebase

Ronnie stares at his screen, scrolling through a Move file that's grown to over a thousand lines. Token logic, staking functions, reward calculations, admin controls—everything crammed into a single massive module.

"This is getting out of hand," Ronnie mutters. "Every time I change the reward formula, I'm scared I'll break the staking logic."

Det rolls her chair over, taking a quick look. "Classic monolith problem. You've got everything in one module—that's why it's becoming unmaintainable."

"But Move modules are self-contained, right? How do I split this up?"

Det grabs a marker and sketches on the whiteboard. "Think of your project as a team. Each module should have one job. Your token module handles token operations. Your staking module handles staking. Your rewards module calculates rewards. They communicate through well-defined interfaces."

"But how do they talk to each other?"

"That's where dependencies come in," Det explains. "One module can `use` another module's public functions and types. The staking module can call the token module's transfer function. The rewards module can read staking data through public getters."

Ronnie nods slowly. "So I'm breaking the monolith into specialized pieces."

"Exactly. And here's the key—you need to think about the dependency direction. If module A uses module B, that's a one-way street. B can't turn around and use A, or you'll have a circular dependency. Move won't compile it."

"So I need to plan the architecture?"

Det smiles. "Now you're thinking like a systems designer. Your core modules at the bottom, with nothing depending on them. Higher-level modules build on top. It's like a pyramid—stable foundation, specialized functionality on top."

---

## Topics

### Why Split Into Multiple Modules?

Large projects benefit from modular organization:

```
my_project/
├── sources/
│   ├── token.move        # Core token logic
│   ├── staking.move      # Staking functionality
│   ├── rewards.move      # Reward calculations
│   └── admin.move        # Admin controls
└── Move.toml
```

**Benefits of multi-module design:**

- **Separation of concerns**: Each module has a single responsibility
- **Easier testing**: Test modules in isolation
- **Better maintainability**: Changes are localized
- **Code reuse**: Share common modules across projects
- **Clear interfaces**: Public functions define the API

### Module Dependencies with `use`

Modules import functionality from other modules using `use`:

```move
module movestack::token {
    use std::signer;

    struct Token has key {
        balance: u64
    }

    public fun mint(account: &signer, amount: u64) {
        move_to(account, Token { balance: amount });
    }

    public fun balance_of(addr: address): u64 acquires Token {
        if (exists<Token>(addr)) {
            borrow_global<Token>(addr).balance
        } else {
            0
        }
    }

    public fun transfer_internal(from: address, to: address, amount: u64) acquires Token {
        let from_token = borrow_global_mut<Token>(from);
        from_token.balance = from_token.balance - amount;

        let to_token = borrow_global_mut<Token>(to);
        to_token.balance = to_token.balance + amount;
    }
}

// Staking module depends on Token module
module movestack::staking {
    use std::signer;
    use movestack::token;  // Import the token module

    struct StakeInfo has key {
        staked_amount: u64,
        stake_time: u64
    }

    public entry fun stake(account: &signer, amount: u64) acquires StakeInfo {
        let addr = signer::address_of(account);

        // Call token module's function
        let balance = token::balance_of(addr);
        assert!(balance >= amount, 1);

        // Create stake record
        if (exists<StakeInfo>(addr)) {
            let stake = borrow_global_mut<StakeInfo>(addr);
            stake.staked_amount = stake.staked_amount + amount;
        } else {
            move_to(account, StakeInfo {
                staked_amount: amount,
                stake_time: 0
            });
        }
    }
}
```

### Dependency Direction and Hierarchy

Dependencies must flow in one direction—no circular references:

```
┌─────────────────────────────────────────────────┐
│                    admin.move                    │  ← Highest level
│            (uses staking, rewards, token)        │
└─────────────────────────────────────────────────┘
                         │
         ┌───────────────┴───────────────┐
         ▼                               ▼
┌─────────────────┐             ┌─────────────────┐
│  staking.move   │             │  rewards.move   │  ← Mid level
│  (uses token)   │             │  (uses token)   │
└─────────────────┘             └─────────────────┘
         │                               │
         └───────────────┬───────────────┘
                         ▼
              ┌─────────────────┐
              │   token.move    │  ← Base level (no deps)
              │  (core types)   │
              └─────────────────┘
```

```move
// ❌ CIRCULAR DEPENDENCY - Will NOT compile
module movestack::module_a {
    use movestack::module_b;  // A uses B

    public fun call_b() {
        module_b::do_something();
    }
}

module movestack::module_b {
    use movestack::module_a;  // B uses A - CIRCULAR!

    public fun call_a() {
        module_a::call_b();   // This creates a cycle
    }
}
```

### Sharing Types Across Modules

Use `friend` modules or public types to share internal access:

```move
module movestack::types {
    // Shared type definitions
    struct UserInfo has store, drop, copy {
        level: u64,
        points: u64
    }

    public fun new_user(): UserInfo {
        UserInfo { level: 1, points: 0 }
    }

    public fun add_points(user: &mut UserInfo, points: u64) {
        user.points = user.points + points;
    }
}

module movestack::game {
    use movestack::types::{Self, UserInfo};
    use std::signer;

    struct Player has key {
        info: UserInfo
    }

    public entry fun register(account: &signer) {
        let user_info = types::new_user();
        move_to(account, Player { info: user_info });
    }

    public entry fun earn_points(account: &signer, points: u64) acquires Player {
        let player = borrow_global_mut<Player>(signer::address_of(account));
        types::add_points(&mut player.info, points);
    }
}

module movestack::rewards {
    use movestack::types::UserInfo;
    use movestack::game;

    // This module can work with UserInfo because it has `store` ability
    public fun calculate_reward(points: u64): u64 {
        points * 10  // 10 tokens per point
    }
}
```

### Project Structure Best Practices

```
my_defi_project/
├── Move.toml
└── sources/
    ├── core/
    │   ├── token.move       # Base token implementation
    │   └── errors.move      # Shared error codes
    ├── features/
    │   ├── staking.move     # Staking logic
    │   ├── rewards.move     # Reward distribution
    │   └── governance.move  # Voting mechanisms
    └── admin/
        └── admin.move       # Admin controls
```

**Organization principles:**

1. **Core modules**: No external dependencies, define base types
2. **Feature modules**: Depend on core, implement business logic
3. **Admin modules**: Depend on features, provide management interface

---

## Closing Scene

Ronnie finishes reorganizing his code into five clean modules. The token logic is isolated, staking has its own file, and the reward calculations are completely separate.

"This is so much better," Ronnie says, running the compiler. "Each module is focused, and I can see exactly how they connect."

Det nods approvingly. "And now when you need to update the reward formula, you touch one file. The staking logic stays untouched."

"The dependency graph makes sense too. Token at the bottom, everything else builds on top."

"That's modular thinking," Det says. "In Move, well-organized modules aren't just about clean code—they're about safety. The compiler enforces the boundaries you set. No module can reach into another's private data. The structure protects you."

Ronnie saves his files. "Small modules, clear dependencies, no cycles. Got it."

---

## Summary

- **Multi-module projects** split code into focused, single-responsibility modules
- Use `use module_address::module_name` to import dependencies
- Dependencies flow one direction—**no circular references** allowed
- Place core types and utilities in base modules with no dependencies
- Higher-level modules import from lower-level ones
- Share types using the `store` ability and public constructors
- `friend` modules can grant special access for trusted modules
- Organize source files in logical directories (core/, features/, admin/)
- The compiler enforces module boundaries—private stays private
- Good module design improves maintainability, testability, and security
