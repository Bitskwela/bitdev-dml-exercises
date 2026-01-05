### Move module activity

```move
module abilities::ability_demo {
    use std::vector;

    // TODO: Define Config struct with copy and drop abilities

    // TODO: Define Record struct with key and store abilities

    // TODO: Define RestrictedToken struct with no abilities

    // TODO: Function to create a RestrictedToken

    // TODO: Function to consume a RestrictedToken
}
```

## Tasks for Learners

- Create a struct called `Config` with `copy` and `drop` abilities:

  - Field `max_participants` of type `u64`
  - Field `is_active` of type `bool`

  ```move
  struct Config has copy, drop {
      max_participants: u64,
      is_active: bool,
  }
  ```

- Create a struct called `Record` with `key` and `store` abilities:

  - Field `id` of type `u64`
  - Field `data` of type `vector<u8>`

  ```move
  struct Record has key, store {
      id: u64,
      data: vector<u8>,
  }
  ```

- Create a struct called `RestrictedToken` with NO abilities:

  - Field `value` of type `u64`
  - No `has` clause means maximum restriction

  ```move
  struct RestrictedToken {
      value: u64,
  }
  ```

- Create a function `create_token` to create a `RestrictedToken`:

  ```move
  public fun create_token(value: u64): RestrictedToken {
      RestrictedToken { value }
  }
  ```

- Create a function `consume_token` to consume a `RestrictedToken` and return its value:

  ```move
  public fun consume_token(token: RestrictedToken): u64 {
      let RestrictedToken { value } = token;
      value
  }
  ```

### Breakdown for learners

- **Four Abilities in Move:**

  - `copy`: Value can be duplicated
  - `drop`: Value can be discarded implicitly
  - `store`: Value can be stored inside other structs or global storage
  - `key`: Value can be used as a key for global storage operations

- **Ability Syntax:** Use `has` keyword after struct name: `struct Name has ability1, ability2 { ... }`

- **Common Combinations:**

  - `copy, drop`: Freely copyable and droppable (simple data)
  - `key, store`: Can be stored globally (resources)
  - No abilities: Maximum restriction—must be explicitly handled

- **Restricted Types:** Structs without `drop` must be explicitly consumed via destructuring

- **Security Implication:** Omitting abilities prevents accidental copying or dropping of valuable assets
