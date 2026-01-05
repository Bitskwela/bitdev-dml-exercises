## Smart contract activity

```toml
# Move.toml - Fix this package configuration

[package]
name = "TokenProject"
# TODO: Add version field

[addresses]
# TODO: Define the named address 'tokenproject' with value "0xcafe"
# TODO: Define the named address 'admin' with value "0x1"

[dev-addresses]
# TODO: Override 'tokenproject' to "0x0" for testing
# TODO: Override 'admin' to "0x0" for testing

[dependencies]
# Dependencies will be covered in the next lesson
```

```move
module tokenproject::managed_token {
    use std::signer;

    // TODO: Define a constant ADMIN_ADDRESS using the @admin named address

    struct TokenInfo has key {
        name: vector<u8>,
        total_supply: u64,
    }

    public fun initialize(account: &signer, name: vector<u8>) {
        // TODO: Assert that signer address equals ADMIN_ADDRESS
        move_to(account, TokenInfo {
            name,
            total_supply: 0
        });
    }

    public fun get_admin(): address {
        // TODO: Return the admin address using the @ syntax
    }
}
```

## Tasks for Learners

Configure a Move package with proper structure and named addresses.

- Add the version field to the package section:

  ```toml
  [package]
  name = "TokenProject"
  version = "1.0.0"
  ```

- Define the named addresses in the addresses section:

  ```toml
  [addresses]
  tokenproject = "0xcafe"
  admin = "0x1"
  ```

- Override addresses for development testing:

  ```toml
  [dev-addresses]
  tokenproject = "0x0"
  admin = "0x0"
  ```

- Define the ADMIN_ADDRESS constant using the named address:

  ```move
  const ADMIN_ADDRESS: address = @admin;
  ```

- Add the admin check in the initialize function:

  ```move
  public fun initialize(account: &signer, name: vector<u8>) {
      assert!(signer::address_of(account) == ADMIN_ADDRESS, 1);
      move_to(account, TokenInfo {
          name,
          total_supply: 0
      });
  }
  ```

- Implement get_admin to return the named address:

  ```move
  public fun get_admin(): address {
      @admin
  }
  ```

### Breakdown for learners

**The `Move.toml` file** is the manifest for every Move package. It defines your project's identity and configuration.

**Package section fields:**

- `name`: The package name (used for identification)
- `version`: Semantic version like "1.0.0"
- `authors`: Optional list of author names/emails

**Named addresses:**

- Defined in `[addresses]` section as `name = "0xHEX"`
- Referenced in Move code using `@name` syntax
- Allow module deployment to different addresses without code changes

**Dev-addresses:**

- Override production addresses during development/testing
- Typically set to `"0x0"` for local testing
- Only apply when running tests or dev commands

**Using `@` in Move code:**

- `@admin` → resolves to the address defined for "admin"
- `@0x1` → literal hex address
- Can be used in constants, function returns, and comparisons

**Why named addresses matter:**

- **Flexibility**: Same code deploys to different addresses
- **Readability**: `@treasury` is clearer than `@0x742d35cc`
- **Maintainability**: Change address in one place (Move.toml)
