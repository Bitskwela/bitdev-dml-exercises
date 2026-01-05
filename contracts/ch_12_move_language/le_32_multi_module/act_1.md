## Smart contract activity

```move
// File: sources/coin.move
module movestack::coin {
    use std::signer;

    struct Coin has key {
        value: u64
    }

    public fun mint(account: &signer, amount: u64) {
        move_to(account, Coin { value: amount });
    }

    public fun balance(addr: address): u64 acquires Coin {
        if (exists<Coin>(addr)) {
            borrow_global<Coin>(addr).value
        } else {
            0
        }
    }

    // TODO: Add a public function to deduct from balance
    // This will be called by the shop module
}

// File: sources/shop.move
module movestack::shop {
    // TODO: Import the coin module

    struct Item has key {
        name: vector<u8>,
        price: u64
    }

    // TODO: Create a buy function that:
    // 1. Checks buyer has enough coins using coin::balance
    // 2. Deducts the price using coin::deduct
    // 3. Transfers ownership of the item
}

// File: sources/inventory.move
module movestack::inventory {
    // TODO: Import both coin and shop modules

    struct PlayerInventory has key {
        items: vector<vector<u8>>,
        total_spent: u64
    }

    // TODO: Create functions to:
    // 1. Initialize a player's inventory
    // 2. Purchase an item (uses shop module)
    // 3. Track total spending
}
```

## Tasks for Learners

Build a multi-module project with proper dependencies. The coin module is the base, shop depends on coin, and inventory depends on both.

- Add a `deduct` function to the coin module that decreases a balance:

  ```move
  public fun deduct(addr: address, amount: u64) acquires Coin {
      let coin = borrow_global_mut<Coin>(addr);
      assert!(coin.value >= amount, 1);
      coin.value = coin.value - amount;
  }
  ```

- Import the coin module in shop and create a buy function:

  ```move
  module movestack::shop {
      use std::signer;
      use movestack::coin;

      struct Item has key, store {
          name: vector<u8>,
          price: u64
      }

      public fun create_item(seller: &signer, name: vector<u8>, price: u64) {
          move_to(seller, Item { name, price });
      }

      public fun get_price(seller_addr: address): u64 acquires Item {
          borrow_global<Item>(seller_addr).price
      }

      public entry fun buy(buyer: &signer, seller_addr: address) acquires Item {
          let buyer_addr = signer::address_of(buyer);
          let item = borrow_global<Item>(seller_addr);
          let price = item.price;

          // Check balance using coin module
          let balance = coin::balance(buyer_addr);
          assert!(balance >= price, 2);

          // Deduct coins using coin module
          coin::deduct(buyer_addr, price);
      }
  }
  ```

- Import coin and shop modules in inventory and create management functions:

  ```move
  module movestack::inventory {
      use std::signer;
      use std::vector;
      use movestack::coin;
      use movestack::shop;

      struct PlayerInventory has key {
          items: vector<vector<u8>>,
          total_spent: u64
      }

      public entry fun initialize(account: &signer) {
          move_to(account, PlayerInventory {
              items: vector::empty(),
              total_spent: 0
          });
      }

      public entry fun purchase_item(
          buyer: &signer,
          seller_addr: address,
          item_name: vector<u8>
      ) acquires PlayerInventory {
          let buyer_addr = signer::address_of(buyer);

          // Get price from shop module
          let price = shop::get_price(seller_addr);

          // Execute purchase through shop module
          shop::buy(buyer, seller_addr);

          // Update inventory
          let inventory = borrow_global_mut<PlayerInventory>(buyer_addr);
          vector::push_back(&mut inventory.items, item_name);
          inventory.total_spent = inventory.total_spent + price;
      }

      public fun get_total_spent(addr: address): u64 acquires PlayerInventory {
          borrow_global<PlayerInventory>(addr).total_spent
      }
  }
  ```

### Breakdown for learners

**Multi-module projects** organize code into separate files with clear responsibilities and dependencies.

**The dependency hierarchy:**

```
inventory.move (top level)
    ├── uses shop.move
    └── uses coin.move

shop.move (middle level)
    └── uses coin.move

coin.move (base level)
    └── no project dependencies
```

**Importing modules with `use`:**

```move
use movestack::coin;           // Import entire module
use movestack::coin::balance;  // Import specific function
```

**Calling cross-module functions:**

```move
// Call with module prefix
let bal = coin::balance(addr);

// Call imported function directly
let bal = balance(addr);
```

**Key rules for multi-module projects:**

| Rule                 | Explanation                                            |
| -------------------- | ------------------------------------------------------ |
| No circular deps     | If A uses B, then B cannot use A                       |
| Dependency direction | Higher-level modules import lower-level ones           |
| Public visibility    | Only `public` functions can be called cross-module     |
| Type sharing         | Types need `store` ability to be used in other modules |

**Why this structure works:**

- `coin` is the foundation—it knows nothing about shop or inventory
- `shop` builds on coin to add purchasing logic
- `inventory` orchestrates both to provide player management
- Each module can be tested independently
- Changes to inventory don't affect coin or shop
