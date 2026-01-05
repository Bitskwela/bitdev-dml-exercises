## Smart contract activity

```toml
# Move.toml - Configure dependencies for a DeFi project

[package]
name = "DeFiVault"
version = "1.0.0"

[addresses]
defi_vault = "0xcafe"
aptos_framework = "0x1"
std = "0x1"

[dependencies]
# TODO: Add AptosFramework git dependency
# Repository: https://github.com/aptos-labs/aptos-core.git
# Subdir: aptos-move/framework/aptos-framework
# Rev: mainnet

# TODO: Add a local dependency called "CoreUtils" from "../core_utils"

[dev-addresses]
defi_vault = "0x0"

[dev-dependencies]
# TODO: Add a local dev dependency called "TestHelpers" from "../test_helpers"
```

```move
module defi_vault::vault {
    // TODO: Import coin module from aptos_framework
    // TODO: Import signer from std

    struct Vault<phantom CoinType> has key {
        balance: u64,
    }

    public fun create_vault<CoinType>(account: &signer) {
        // TODO: Use signer::address_of to get address
        let _addr = todo!();
        move_to(account, Vault<CoinType> { balance: 0 });
    }

    public fun deposit<CoinType>(
        account: &signer,
        amount: u64
    ) acquires Vault {
        // TODO: Get vault and update balance
        let addr = todo!();
        let vault = borrow_global_mut<Vault<CoinType>>(addr);
        vault.balance = vault.balance + amount;
    }
}
```

## Tasks for Learners

Configure a Move project with external and local dependencies.

- Add the AptosFramework git dependency:

  ```toml
  [dependencies]
  AptosFramework = { git = "https://github.com/aptos-labs/aptos-core.git", subdir = "aptos-move/framework/aptos-framework", rev = "mainnet" }
  ```

- Add the local CoreUtils dependency:

  ```toml
  CoreUtils = { local = "../core_utils" }
  ```

- Add the dev dependency for testing:

  ```toml
  [dev-dependencies]
  TestHelpers = { local = "../test_helpers" }
  ```

- Add the required imports in the Move module:

  ```move
  use aptos_framework::coin;
  use std::signer;
  ```

- Complete the create_vault function:

  ```move
  public fun create_vault<CoinType>(account: &signer) {
      let _addr = signer::address_of(account);
      move_to(account, Vault<CoinType> { balance: 0 });
  }
  ```

- Complete the deposit function:

  ```move
  public fun deposit<CoinType>(
      account: &signer,
      amount: u64
  ) acquires Vault {
      let addr = signer::address_of(account);
      let vault = borrow_global_mut<Vault<CoinType>>(addr);
      vault.balance = vault.balance + amount;
  }
  ```

### Breakdown for learners

**Git dependencies** are the standard way to include blockchain frameworks and external libraries.

**Git dependency format:**

```toml
PackageName = { git = "URL", subdir = "PATH", rev = "VERSION" }
```

- `git`: The repository URL
- `subdir`: Path to the Move package within the repo
- `rev`: Branch name, tag, or commit hash

**Local dependencies** link packages within the same project or filesystem:

```toml
PackageName = { local = "../relative/path" }
```

**Dev-dependencies** are only compiled during testing:

- Useful for mock modules and test utilities
- Not included in production builds
- Defined in `[dev-dependencies]` section

**Common Aptos dependencies:**

| Package          | Purpose                                         |
| ---------------- | ----------------------------------------------- |
| `AptosFramework` | Core blockchain features (coin, account, table) |
| `AptosStdlib`    | Extended standard library                       |
| `MoveStdlib`     | Basic Move types (vector, option, string)       |

**Using imported modules:**

```move
use aptos_framework::coin;        // Import coin module
use std::signer;                  // Import signer module
use aptos_std::table;             // Import table module
```

**Version management:**

- Use `mainnet`, `testnet`, or `devnet` for stable releases
- Use specific commit hashes for production deployments
- Avoid `main` branch in production (can change unexpectedly)
