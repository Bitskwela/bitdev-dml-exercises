### Move module activity

```move
module movestack::config_storage {
    use std::signer;
    use std::string::{Self, String};

    /// Error codes
    const E_CONFIG_EXISTS: u64 = 1;
    const E_CONFIG_NOT_FOUND: u64 = 2;

    /// Config resource stored at each admin's address
    struct Config has key {
        app_name: String,
        max_connections: u64,
        is_maintenance: bool,
    }

    // TODO: Implement initialize function

    // TODO: Implement get_app_name function

    // TODO: Implement get_max_connections function

    // TODO: Implement update_max_connections function

    // TODO: Implement config_exists function
}
```

## Tasks for Learners

- Implement `initialize` function to create and publish a Config resource:

  - Get the signer's address using `signer::address_of`
  - Check that config doesn't already exist using `exists<T>`
  - Create and publish the Config using `move_to`

  ```move
  public entry fun initialize(
      account: &signer,
      app_name: String,
      max_connections: u64
  ) {
      let addr = signer::address_of(account);
      assert!(!exists<Config>(addr), E_CONFIG_EXISTS);
      let config = Config {
          app_name,
          max_connections,
          is_maintenance: false,
      };
      move_to(account, config);
  }
  ```

- Implement `get_app_name` function to read config data:

  - Use `borrow_global<T>` for immutable access
  - Return the `app_name` field

  ```move
  public fun get_app_name(addr: address): String acquires Config {
      assert!(exists<Config>(addr), E_CONFIG_NOT_FOUND);
      let config = borrow_global<Config>(addr);
      config.app_name
  }
  ```

- Implement `get_max_connections` function:

  ```move
  public fun get_max_connections(addr: address): u64 acquires Config {
      assert!(exists<Config>(addr), E_CONFIG_NOT_FOUND);
      let config = borrow_global<Config>(addr);
      config.max_connections
  }
  ```

- Implement `update_max_connections` function to modify config:

  - Use `borrow_global_mut<T>` for mutable access
  - Update the `max_connections` field

  ```move
  public entry fun update_max_connections(
      account: &signer,
      new_max: u64
  ) acquires Config {
      let addr = signer::address_of(account);
      assert!(exists<Config>(addr), E_CONFIG_NOT_FOUND);
      let config = borrow_global_mut<Config>(addr);
      config.max_connections = new_max;
  }
  ```

- Implement `config_exists` function to check if a config exists:

  ```move
  public fun config_exists(addr: address): bool {
      exists<Config>(addr)
  }
  ```

### Breakdown for learners

- **Global Storage Operations:**

  - `move_to(&signer, resource)`: Publishes a resource to the signer's address
  - `move_from<T>(address)`: Removes and returns a resource from an address
  - `borrow_global<T>(address)`: Returns an immutable reference to a resource
  - `borrow_global_mut<T>(address)`: Returns a mutable reference to a resource
  - `exists<T>(address)`: Checks if a resource exists at an address

- **`signer::address_of(signer)`:** Extracts the address from a signer reference

- **`acquires` Keyword:** Functions using `borrow_global`, `borrow_global_mut`, or `move_from` must declare `acquires ResourceType`

- **Access Control:** Only the signer can publish to their own address; use assertions to enforce rules

- **Immutable vs Mutable Borrow:** Use `borrow_global` for reading, `borrow_global_mut` for modifying
