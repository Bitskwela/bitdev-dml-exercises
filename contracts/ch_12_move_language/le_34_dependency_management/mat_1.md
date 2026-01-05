# Dependency Management

## Scene: The Import That Wouldn't Resolve

Loy is working on his first real DeFi project when he hits a wall. He's trying to use the Aptos coin module, but the compiler keeps throwing errors.

"Dex, I need help," Loy calls out. "I'm trying to `use aptos_framework::coin` but the compiler says it doesn't exist. I thought it was built-in!"

Dex walks over, already knowing the problem. "It's not built-in—it's an external package. You need to add it as a dependency in your `Move.toml`."

"A dependency?" Loy frowns. "Like npm packages in JavaScript?"

"Exactly like that," Dex confirms. "Move has a package system. The Aptos Framework, the standard library, third-party modules—they're all packages you import. Without declaring them, the compiler has no idea where to find them."

Loy opens his `Move.toml`. "So I just... add the Aptos Framework here?"

"Right. And there are three ways to add dependencies: from Git repositories, from local paths, or from a package registry. Each has its use case." Dex pulls up a chair. "Let me show you how production projects manage their dependencies."

---

## Topics

### Types of Dependencies

Move supports three dependency sources:

```toml
[dependencies]
# 1. Git dependency (most common for frameworks)
AptosFramework = { git = "https://github.com/aptos-labs/aptos-core.git", subdir = "aptos-move/framework/aptos-framework", rev = "mainnet" }

# 2. Local dependency (for monorepos or local development)
MyLibrary = { local = "../my-library" }

# 3. Address-only dependency (when package is already on-chain)
# SomePackage = { addr = "0x1" }
```

### Git Dependencies

Git dependencies are the standard way to include external packages:

```toml
[dependencies]
# Basic git dependency
AptosFramework = {
    git = "https://github.com/aptos-labs/aptos-core.git",
    subdir = "aptos-move/framework/aptos-framework",
    rev = "mainnet"
}

# With specific commit hash (recommended for production)
AptosStdlib = {
    git = "https://github.com/aptos-labs/aptos-core.git",
    subdir = "aptos-move/framework/aptos-stdlib",
    rev = "abc123def456"
}

# With branch name (useful for development)
MoveStdlib = {
    git = "https://github.com/aptos-labs/aptos-core.git",
    subdir = "aptos-move/framework/move-stdlib",
    rev = "devnet"
}
```

**Git dependency fields:**

| Field    | Required | Description                 |
| -------- | -------- | --------------------------- |
| `git`    | Yes      | Repository URL              |
| `subdir` | No       | Path within repo to package |
| `rev`    | Yes      | Branch, tag, or commit hash |

### Version Management Best Practices

**Use specific commits for production:**

```toml
[dependencies]
# ✅ Good: Pinned to exact commit
AptosFramework = {
    git = "https://github.com/aptos-labs/aptos-core.git",
    subdir = "aptos-move/framework/aptos-framework",
    rev = "a1b2c3d4e5f6"
}

# ⚠️ Risky: Branch can change
AptosFramework = {
    git = "https://github.com/aptos-labs/aptos-core.git",
    subdir = "aptos-move/framework/aptos-framework",
    rev = "main"
}
```

**Why pin versions?**

- **Reproducibility**: Same code builds the same way every time
- **Security**: Prevents supply-chain attacks from malicious updates
- **Stability**: No surprise breaking changes

### Local Dependencies

Local dependencies are perfect for multi-package projects:

```
my_project/
├── packages/
│   ├── core/
│   │   ├── Move.toml
│   │   └── sources/
│   └── token/
│       ├── Move.toml      # References core locally
│       └── sources/
└── Move.toml              # Main project
```

**Core package Move.toml:**

```toml
[package]
name = "Core"
version = "1.0.0"

[addresses]
core = "0x1"
```

**Token package Move.toml:**

```toml
[package]
name = "Token"
version = "1.0.0"

[addresses]
token = "0x2"

[dependencies]
Core = { local = "../core" }
```

**Using the local dependency:**

```move
module token::my_token {
    use core::utils;  // From local Core package

    public fun process() {
        utils::do_something();
    }
}
```

### Dev Dependencies

Dev dependencies are only included during testing:

```toml
[dependencies]
AptosFramework = { git = "...", subdir = "...", rev = "..." }

[dev-dependencies]
# Only available in test mode
AptosTestHelpers = { local = "../test-helpers" }
```

**Use cases for dev-dependencies:**

- Mock modules for testing
- Test utilities and helpers
- Debug-only functionality

### Address Overrides from Dependencies

When depending on a package, you may need to override its addresses:

```toml
[dependencies]
AptosFramework = { git = "...", subdir = "...", rev = "..." }

[addresses]
aptos_framework = "0x1"  # Override framework address
std = "0x1"              # Override stdlib address
```

### Dependency Resolution

When you have multiple dependencies with shared sub-dependencies:

```
YourProject
├── AptosFramework (depends on MoveStdlib)
└── ThirdPartyLib (also depends on MoveStdlib)
```

Move uses **version unification**—all packages must agree on the same version of shared dependencies.

---

## Closing Scene

Loy adds the Aptos Framework dependency and runs the compiler. This time, everything resolves correctly.

"It works!" Loy says excitedly. "I can finally use `aptos_framework::coin`!"

Dex nods. "Dependencies are the backbone of any serious Move project. You'll rarely write everything from scratch—the Aptos Framework gives you coins, accounts, tables, and so much more."

"Should I always use the latest version?" Loy asks.

Dex shakes his head firmly. "Never in production. Always pin to a specific commit. One breaking change in a dependency, and your whole dApp could fail. Trust me, I learned that the hard way."

Loy makes a mental note. "Pin versions. Got it."

---

## Summary

- **Git dependencies** are specified with `git`, `subdir`, and `rev` fields
- **Local dependencies** use `local = "../path"` for monorepo setups
- **Always pin to specific commits** in production for reproducibility
- **`rev`** can be a branch name, tag, or commit hash
- **Dev-dependencies** are only included during test compilation
- **Address overrides** let you set addresses for imported packages
- Move uses **version unification** for shared sub-dependencies
- Common dependencies include `AptosFramework`, `AptosStdlib`, and `MoveStdlib`
