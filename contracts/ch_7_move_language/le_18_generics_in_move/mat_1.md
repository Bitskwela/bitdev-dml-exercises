## Background Story

Odessa enters the Library of Universal Forms—a vast space where code patterns shimmer in infinite variations. At its center stands Master Polymorph, the Keeper of Generics, surrounded by floating templates that adapt to any type.

"Look around you," Polymorph begins, gesturing at the morphing code. "Every piece of code you see can work with _any_ type. A container that holds integers, addresses, or custom structs. A function that works with any data. A pattern that adapts to whatever you need."

The master pulls down a template, and it splits into countless variations.

"This is the power of **generics**. Instead of writing the same code over and over for different types, you write it once with _type parameters_. The compiler fills in the blanks when you use it."

Polymorph shows a simple example:

```move
// Without generics: repetitive!
struct IntBox { value: u64 }
struct AddressBox { value: address }
struct BoolBox { value: bool }

// With generics: universal!
struct Box<T> { value: T }
```

"See? One definition, infinite possibilities."

The keeper's voice resonates with knowledge.

"Today, you'll master generics—the foundation of reusable code. You'll learn type parameters, generic functions, constraints, phantom types, and advanced generic patterns. By the end, you'll write code that works for any type while maintaining complete type safety."

The library pulses with possibility.

"Let's begin."

---

## 📚 Topics & Deep Lessons

### 1️⃣ **Generic Basics: Type Parameters**

Generics allow functions and structs to work with any type.

**What problem do generics solve?**

Without generics:

```move
// Need separate struct for each type
struct U64Box has key { value: u64 }
struct AddressBox has key { value: address }
struct BoolBox has key { value: bool }

// Need separate functions for each type
public fun create_u64_box(value: u64): U64Box { ... }
public fun create_address_box(value: address): AddressBox { ... }
public fun create_bool_box(value: bool): BoolBox { ... }
```

This is repetitive, error-prone, and unmaintainable!

**With generics:**

```move
// One struct for all types
struct Box<T> has key {
    value: T
}

// One function for all types
public fun create_box<T>(value: T): Box<T> {
    Box { value }
}

// Use with any type:
let int_box = create_box<u64>(42);
let addr_box = create_box<address>(@0x123);
let bool_box = create_box<bool>(true);
```

**Type parameter syntax:**

```move
struct Name<T> { ... }    // T is a type parameter
struct Name<T, U> { ... } // Multiple type parameters
struct Name<T: copy> { ... } // T with constraint
```

**Generic functions:**

```move
// Generic function signature
public fun swap<T>(a: T, b: T): (T, T) {
    (b, a)
}

// Usage with type inference
let (x, y) = swap(1, 2);        // Inferred: swap<u64>
let (a, b) = swap(@0x1, @0x2);  // Inferred: swap<address>

// Usage with explicit types
let (x, y) = swap<u64>(1, 2);
```

**Real-world analogy:**

Generics are like a universal container:

- A box that can hold anything
- A function that operates on anything
- A pattern that works with anything

You describe the _shape_ of the solution, not the specific types.

### 2️⃣ **Ability Constraints on Type Parameters**

Type parameters can require specific abilities.

**Why constraints matter:**

Not all operations work with all types:

```move
// Can't drop arbitrary types
public fun destroy<T>(value: T) {
    // value dropped here
}

// Error! What if T doesn't have `drop`?
```

**Solution: Ability constraints:**

```move
// T must have `drop` ability
public fun destroy<T: drop>(value: T) {
    // Safe: T can be dropped
}

// T must have `copy` ability
public fun duplicate<T: copy>(value: T): (T, T) {
    (copy value, value)
}

// T must have multiple abilities
public fun store_and_copy<T: store + copy>(value: T) {
    // Can store in global storage AND copy
}
```

**Common constraint patterns:**

```move
// No constraint: any type
struct Box<T> { value: T }

// Must be droppable
struct DropBox<T: drop> { value: T }

// Must be copyable
struct CopyBox<T: copy> { value: T }

// Must be storable (for global storage)
struct StorageBox<T: store> has key {
    value: T
}

// Multiple constraints
struct FullBox<T: copy + drop + store> has key {
    value: T
}
```

**Why abilities matter:**

```move
struct Token has key {
    value: u64
}
// Token has NO drop ability (can't be accidentally destroyed)

// This function won't accept Token
public fun destroy<T: drop>(value: T) { }

destroy(Token { value: 100 }); // ERROR: Token doesn't have drop!
```

**Constraint examples:**

```move
// Vector operations need drop
public fun pop_or_drop<T: drop>(vec: &mut vector<T>) {
    if (vector::length(vec) > 0) {
        let _ = vector::pop_back(vec); // Dropped
    }
}

// Cloning needs copy
public fun clone<T: copy>(value: &T): T {
    *value // Copies value
}

// Global storage needs store + key
public fun save<T: store>(account: &signer, value: T) {
    move_to(account, value);
}
```

### 3️⃣ **Generic Structs and Collections**

Building generic data structures.

**Generic container pattern:**

```move
module spell_library::containers {
    struct Box<T> has key, store {
        value: T
    }

    public fun new<T>(value: T): Box<T> {
        Box { value }
    }

    public fun get<T: copy>(box: &Box<T>): T {
        box.value
    }

    public fun destroy<T>(box: Box<T>): T {
        let Box { value } = box;
        value
    }
}
```

**Generic pair:**

```move
struct Pair<T, U> has key, store {
    first: T,
    second: U
}

public fun create_pair<T, U>(first: T, second: U): Pair<T, U> {
    Pair { first, second }
}

public fun swap<T, U>(pair: Pair<T, U>): Pair<U, T> {
    let Pair { first, second } = pair;
    Pair { first: second, second: first }
}
```

**Generic wrapper:**

```move
struct Wrapper<T: store> has key {
    inner: T
}

public fun wrap<T: store>(value: T): Wrapper<T> {
    Wrapper { inner: value }
}

public fun unwrap<T: store>(wrapper: Wrapper<T>): T {
    let Wrapper { inner } = wrapper;
    inner
}
```

**Generic collection:**

```move
struct Collection<T: store> has key {
    items: vector<T>,
    count: u64
}

public fun new_collection<T: store>(): Collection<T> {
    Collection {
        items: vector::empty(),
        count: 0
    }
}

public fun add<T: store>(
    collection: &mut Collection<T>,
    item: T
) {
    vector::push_back(&mut collection.items, item);
    collection.count = collection.count + 1;
}

public fun get<T: store + copy>(
    collection: &Collection<T>,
    index: u64
): T {
    *vector::borrow(&collection.items, index)
}
```

**Generic option pattern:**

```move
struct Option<T> {
    is_some: bool,
    value: T
}

public fun some<T>(value: T): Option<T> {
    Option { is_some: true, value }
}

public fun none<T: drop>(): Option<T> {
    // Need default value for T
    // This is conceptual; real Option<T> uses vector
}
```

### 4️⃣ **Phantom Type Parameters**

Type parameters that don't appear in struct fields.

**What are phantom types?**

Phantom type parameters are generic parameters that don't appear in any field:

```move
struct Coin<phantom CoinType> has key {
    value: u64  // CoinType not used in fields!
}
```

**Why use phantom types?**

For type-level distinctions without runtime overhead:

```move
// Different coin types
struct USD {}
struct EUR {}
struct BTC {}

// Same storage, different types
struct Coin<phantom T> has key { value: u64 }

// Type system prevents mixing:
let usd = Coin<USD> { value: 100 };
let eur = Coin<EUR> { value: 100 };

// ERROR: Can't add USD and EUR!
transfer(usd, eur); // Type mismatch!
```

**Phantom type patterns:**

**1. Currency markers:**

```move
struct Currency<phantom T> has key {
    amount: u64
}

public fun create_usd(amount: u64): Currency<USD> {
    Currency { amount }
}

public fun create_eur(amount: u64): Currency<EUR> {
    Currency { amount }
}

// Type-safe: can't mix currencies
public fun add<T>(a: Currency<T>, b: Currency<T>): Currency<T> {
    Currency { amount: a.amount + b.amount }
}
```

**2. Permission markers:**

```move
struct Read {}
struct Write {}
struct Execute {}

struct File<phantom Permission> has key {
    data: vector<u8>
}

public fun read_file(file: &File<Read>): vector<u8> {
    file.data
}

public fun write_file(file: &mut File<Write>, data: vector<u8>) {
    file.data = data;
}

// Can't write to read-only file!
let read_only: File<Read> = ...;
write_file(&mut read_only, data); // ERROR!
```

**3. State markers:**

```move
struct Pending {}
struct Active {}
struct Completed {}

struct Task<phantom State> has key {
    description: String,
    assignee: address
}

public fun start_task(task: Task<Pending>): Task<Active> {
    let Task { description, assignee } = task;
    Task { description, assignee }
}

public fun complete_task(task: Task<Active>): Task<Completed> {
    let Task { description, assignee } = task;
    Task { description, assignee }
}

// Can't complete pending task directly!
let pending: Task<Pending> = ...;
complete_task(pending); // ERROR: expected Task<Active>
```

**Phantom type benefits:**

- Zero runtime cost (types erased after compilation)
- Compile-time safety
- Clear intent in code
- Prevents invalid state transitions

### 5️⃣ **Advanced Generic Patterns**

Professional generic programming techniques.

**Pattern 1: Generic with witness**

```move
struct Witness<phantom T> has drop {}

struct Registry<phantom T> has key {
    items: vector<u64>
}

public fun create_registry<T>(
    _witness: Witness<T>
): Registry<T> {
    Registry { items: vector::empty() }
}

// Only creator of type T can create Registry<T>
module my_module {
    struct MyType {}

    public fun init() {
        let witness = Witness<MyType> {};
        let registry = create_registry(witness);
    }
}
```

**Pattern 2: Generic capability pattern**

```move
struct Cap<phantom T> has key, store {
    id: u64
}

public fun issue_cap<T>(): Cap<T> {
    Cap { id: generate_id() }
}

public fun verify_cap<T>(_cap: &Cap<T>, resource: &T) {
    // Cap<T> grants access to T
}
```

**Pattern 3: Generic delegation**

```move
struct Delegated<T: store> has key {
    delegatee: address,
    resource: T
}

public fun delegate<T: store>(
    delegatee: address,
    resource: T
): Delegated<T> {
    Delegated { delegatee, resource }
}

public fun revoke<T: store>(
    delegated: Delegated<T>
): T {
    let Delegated { delegatee: _, resource } = delegated;
    resource
}
```

**Pattern 4: Generic composability**

```move
struct Wrapper<T: store> has key, store {
    inner: T
}

// Can wrap anything
let wrapped_u64 = Wrapper { inner: 42u64 };
let wrapped_addr = Wrapper { inner: @0x123 };

// Can wrap wrapped things!
let double_wrapped = Wrapper {
    inner: Wrapper { inner: 42u64 }
};
```

**Pattern 5: Generic event logging**

```move
struct Event<T: copy + drop> has copy, drop {
    data: T,
    timestamp: u64
}

public fun emit_event<T: copy + drop>(data: T) {
    event::emit(Event {
        data,
        timestamp: get_timestamp()
    });
}
```

**Pattern 6: Generic factory**

```move
struct Factory<T: store> has key {
    template: T,
    count: u64
}

public fun create_factory<T: store + copy>(
    template: T
): Factory<T> {
    Factory {
        template,
        count: 0
    }
}

public fun produce<T: store + copy>(
    factory: &mut Factory<T>
): T {
    factory.count = factory.count + 1;
    copy factory.template
}
```

---

## 🎯 Activity / Exercises

### Exercise 1: Generic Container 📦

**Scenario:** Build a generic storage container with get/set operations.

**Boilerplate Code:**

```move
module spell_library::storage {
    struct Container<____> has key {
        value: T,
        owner: address
    }

    public fun create<T>(owner: address, value: T): Container<____> {
        Container {
            value: ____,
            owner: ____
        }
    }

    public fun get<T: ____>(container: &Container<T>): T {
        ____  // Return copy of value
    }

    public fun set<T>(container: &mut Container<T>, new_value: T) {
        container.____ = new_value;
    }

    public fun owner<T>(container: &Container<T>): address {
        container.____
    }

    public fun destroy<T>(container: Container<T>): T {
        let Container { value: ____, owner: _ } = container;
        ____
    }
}

#[test_only]
module spell_library::storage_tests {
    use spell_library::storage;

    #[test]
    fun test_u64_container() {
        let container = storage::create<____>(@0x123, 42);

        assert!(storage::get(&container) == ____, 1);
        assert!(storage::owner(&container) == ____, 2);

        let value = storage::destroy(container);
        assert!(value == 42, 3);
    }

    #[test]
    fun test_address_container() {
        let mut container = storage::create<address>(@0x123, @0x456);

        storage::set(&mut container, ____);
        assert!(storage::get(&container) == @0x789, 1);
    }
}
```

**Your Task:**

1. Add type parameter to Container struct
2. Implement create function with generics
3. Add copy constraint to get function
4. Complete set and destroy functions
5. Test with multiple types

---

### Exercise 2: Phantom Type Safety 👻

**Scenario:** Build a type-safe coin system using phantom types.

**Boilerplate Code:**

```move
module spell_library::coins {
    // Phantom type markers
    struct USD {}
    struct EUR {}
    struct BTC {}

    struct Coin<phantom ____> has key, store {
        value: u64
    }

    public fun mint_usd(amount: u64): Coin<____> {
        Coin { value: ____ }
    }

    public fun mint_eur(amount: u64): Coin<EUR> {
        Coin { value: amount }
    }

    public fun mint_btc(amount: u64): Coin<____> {
        Coin { value: ____ }
    }

    public fun value<T>(coin: &Coin<____>): u64 {
        coin.____
    }

    // Can only add same currency
    public fun add<T>(a: Coin<T>, b: Coin<____>): Coin<T> {
        Coin { value: a.____ + b.value }
    }

    public fun split<T>(coin: Coin<T>, amount: u64): (Coin<T>, Coin<____>) {
        assert!(coin.value >= ____, 100);

        let remaining = coin.value - amount;
        let Coin { value: _ } = coin;

        (
            Coin { value: ____ },
            Coin { value: ____ }
        )
    }

    public fun destroy<T>(coin: Coin<T>): u64 {
        let Coin { value } = coin;
        ____
    }
}

#[test_only]
module spell_library::coin_tests {
    use spell_library::coins;

    #[test]
    fun test_same_currency() {
        let usd1 = coins::mint_usd(100);
        let usd2 = coins::mint_usd(50);

        let total = coins::add(usd1, ____);
        assert!(coins::value(&total) == ____, 1);
    }

    #[test]
    fun test_split_currency() {
        let btc = coins::mint_btc(100);
        let (part1, part2) = coins::split(____, 30);

        assert!(coins::value(&part1) == ____, 1);
        assert!(coins::value(&part2) == ____, 2);
    }

    #[test]
    #[expected_failure]
    fun test_mix_currency_fails() {
        let usd = coins::mint_usd(100);
        let eur = coins::mint_eur(50);

        // This should fail: can't mix USD and EUR!
        coins::add(usd, eur);
    }
}
```

**Your Task:**

1. Define phantom type parameter
2. Implement mint functions for each currency
3. Complete type-safe add function
4. Implement split with validation
5. Verify type safety prevents mixing currencies

---

### Exercise 3: Generic Collection 📚

**Scenario:** Build a generic collection with add/remove/find operations.

**Boilerplate Code:**

```move
module spell_library::collection {
    struct Collection<T: ____> has key {
        items: vector<T>,
        count: u64
    }

    public fun new<T: store>(): Collection<____> {
        Collection {
            items: vector::____(),
            count: 0
        }
    }

    public fun add<T: store>(
        collection: &mut Collection<T>,
        item: T
    ) {
        vector::push_back(&mut collection.____, item);
        collection.count = collection.____ + 1;
    }

    public fun remove<T: store>(
        collection: &mut Collection<T>,
        index: u64
    ): T {
        assert!(index < collection.____, 100);

        collection.count = collection.count - 1;
        vector::____(&mut collection.items, index)
    }

    public fun get<T: store + ____>(
        collection: &Collection<T>,
        index: u64
    ): T {
        *vector::borrow(&collection.____, ____)
    }

    public fun length<T: store>(collection: &Collection<____>): u64 {
        collection.____
    }

    public fun is_empty<T: store>(collection: &Collection<T>): bool {
        collection.count == ____
    }

    public fun destroy<T: store + drop>(collection: Collection<T>) {
        let Collection { items: _, count: _ } = collection;
        // items dropped automatically
    }
}

#[test_only]
module spell_library::collection_tests {
    use spell_library::collection;

    struct Item has store, copy, drop {
        id: u64,
        name: vector<u8>
    }

    #[test]
    fun test_collection() {
        let mut coll = collection::new<____>();

        assert!(collection::is_empty(&coll), 1);

        collection::add(&mut coll, Item { id: 1, name: b"First" });
        collection::add(&mut ____, Item { id: 2, name: b"Second" });

        assert!(collection::length(&coll) == ____, 2);

        let item = collection::get(&coll, ____);
        assert!(item.id == ____, 3);

        let removed = collection::remove(&mut coll, 0);
        assert!(removed.id == ____, 4);
        assert!(collection::length(&coll) == ____, 5);

        collection::destroy(coll);
    }
}
```

**Your Task:**

1. Add store constraint to Collection
2. Implement new, add, remove functions
3. Add copy constraint for get function
4. Complete length and is_empty
5. Test full collection lifecycle

---

## ✅ Full Answers

### Exercise 1: Complete Solution

```move
module spell_library::storage {
    struct Container<T> has key {
        value: T,
        owner: address
    }

    public fun create<T>(owner: address, value: T): Container<T> {
        Container { value, owner }
    }

    public fun get<T: copy>(container: &Container<T>): T {
        container.value
    }

    public fun set<T>(container: &mut Container<T>, new_value: T) {
        container.value = new_value;
    }

    public fun owner<T>(container: &Container<T>): address {
        container.owner
    }

    public fun destroy<T>(container: Container<T>): T {
        let Container { value, owner: _ } = container;
        value
    }
}
```

### Exercise 2: Complete Solution

```move
module spell_library::coins {
    struct USD {}
    struct EUR {}
    struct BTC {}

    struct Coin<phantom T> has key, store {
        value: u64
    }

    public fun mint_usd(amount: u64): Coin<USD> {
        Coin { value: amount }
    }

    public fun mint_eur(amount: u64): Coin<EUR> {
        Coin { value: amount }
    }

    public fun mint_btc(amount: u64): Coin<BTC> {
        Coin { value: amount }
    }

    public fun value<T>(coin: &Coin<T>): u64 {
        coin.value
    }

    public fun add<T>(a: Coin<T>, b: Coin<T>): Coin<T> {
        Coin { value: a.value + b.value }
    }

    public fun split<T>(coin: Coin<T>, amount: u64): (Coin<T>, Coin<T>) {
        assert!(coin.value >= amount, 100);

        let remaining = coin.value - amount;
        let Coin { value: _ } = coin;

        (
            Coin { value: amount },
            Coin { value: remaining }
        )
    }

    public fun destroy<T>(coin: Coin<T>): u64 {
        let Coin { value } = coin;
        value
    }
}
```

### Exercise 3: Complete Solution

```move
module spell_library::collection {
    struct Collection<T: store> has key {
        items: vector<T>,
        count: u64
    }

    public fun new<T: store>(): Collection<T> {
        Collection {
            items: vector::empty(),
            count: 0
        }
    }

    public fun add<T: store>(
        collection: &mut Collection<T>,
        item: T
    ) {
        vector::push_back(&mut collection.items, item);
        collection.count = collection.count + 1;
    }

    public fun remove<T: store>(
        collection: &mut Collection<T>,
        index: u64
    ): T {
        assert!(index < collection.count, 100);
        collection.count = collection.count - 1;
        vector::remove(&mut collection.items, index)
    }

    public fun get<T: store + copy>(
        collection: &Collection<T>,
        index: u64
    ): T {
        *vector::borrow(&collection.items, index)
    }

    public fun length<T: store>(collection: &Collection<T>): u64 {
        collection.count
    }

    public fun is_empty<T: store>(collection: &Collection<T>): bool {
        collection.count == 0
    }

    public fun destroy<T: store + drop>(collection: Collection<T>) {
        let Collection { items: _, count: _ } = collection;
    }
}
```

---

## 💡 Answers & Explanation

### Exercise 1 Explanation: Generic Container

**Type parameters:**

```move
struct Container<T> has key { value: T }
// T can be any type
```

**Constraints matter:**

```move
public fun get<T: copy>(container: &Container<T>): T
// Need copy to return value
```

### Exercise 2 Explanation: Phantom Types

**Phantom type safety:**

```move
struct Coin<phantom T> { value: u64 }
// T only used for type checking
```

**Prevents mixing:**

```move
public fun add<T>(a: Coin<T>, b: Coin<T>): Coin<T>
// Both must be same type T
```

### Exercise 3 Explanation: Generic Collection

**Store constraint:**

```move
struct Collection<T: store>
// T must be storable
```

**Vector operations:**

```move
vector::push_back(&mut collection.items, item);
vector::remove(&mut collection.items, index);
```

---

## 🧪 Unit Tests

```move
#[test_only]
module spell_library::generics_lesson_tests {
    use spell_library::storage_tests;
    use spell_library::coin_tests;
    use spell_library::collection_tests;

    #[test]
    fun run_all_storage_tests() {
        storage_tests::test_u64_container();
        storage_tests::test_address_container();
    }

    #[test]
    fun run_all_coin_tests() {
        coin_tests::test_same_currency();
        coin_tests::test_split_currency();
    }

    #[test]
    #[expected_failure]
    fun verify_type_safety() {
        coin_tests::test_mix_currency_fails();
    }

    #[test]
    fun run_all_collection_tests() {
        collection_tests::test_collection();
    }
}
```

---

## 🌟 Closing Story

Master Polymorph stands with Odessa in the Library of Universal Forms, now infinite with possibility. Every template, every pattern, ready to adapt to any type.

> "You've mastered generics," Polymorph says, voice resonating with satisfaction. "Your code is no longer repetitive. You write once, use everywhere. Type parameters make your code universal. Constraints ensure safety. Phantom types add compile-time guarantees."

> "This is the foundation of reusable libraries. One Box works for all types. One Collection stores anything. One function processes everything. Generics make your code flexible yet safe."

The keeper gestures to the morphing templates.

> "Remember: use generics to eliminate repetition. Add constraints to ensure safety. Use phantom types for type-level distinctions. Make your code universal."

Polymorph's form shimmers with infinite possibility.

> "Your next lesson: design patterns. You'll learn the professional patterns that define great Move code—witness, hot potato, capability, singleton, registry. Generics made your code reusable. Patterns will make it elegant."

The library fades into pure abstraction.

> "Go. Write universal code. Embrace type parameters. Trust the compiler."

---

**Next Lesson:** Move Design Patterns - professional patterns for production Move development.
