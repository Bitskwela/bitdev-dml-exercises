# Activity: Your First Move Module

## Objective

Create your first Move module that demonstrates the basic structure of Move code and introduces the concept of resources.

## Scenario

Neri is ready to write her first Move code. Det has set up a fresh development environment, and Jaymart is watching over her shoulder, eager to learn alongside her. "Let's start simple," Det says. "Create a module that can track a counter value. But remember—in Move, we need to think about how that counter is stored and who owns it."

## Starter Code

```move
module movestack::counter {
    // TODO: Define a Counter struct with a 'value' field
    // The Counter should be a resource (hint: use the 'key' ability)

    // TODO: Create a function to initialize a new counter
    // The counter should be stored at the caller's address

    // TODO: Create a function to get the current counter value
    // This should read from the caller's stored counter
}
```

## Tasks

1. **Define the Counter struct**

   - Create a struct called `Counter` with a single `u64` field named `value`
   - Give it the `key` ability so it can be stored in global storage

2. **Create an initialization function**

   - Write a public entry function called `initialize` that takes a `&signer` parameter
   - Inside the function, create a new `Counter` with `value: 0`
   - Use `move_to` to store the counter at the signer's address

3. **Create a getter function**
   - Write a public function called `get_value` that takes an `address` parameter
   - Use `borrow_global` to read the Counter at that address
   - Return the counter's value

## Expected Behavior

After completing this activity:

- A user can call `initialize` to create their own Counter stored at their address
- Anyone can call `get_value` with an address to see that account's counter value
- The Counter cannot be copied or dropped—it's a true resource

## Hints

<details>
<summary>Hint 1: Struct with key ability</summary>

To make a struct a resource that can be stored globally, use:

```move
struct Counter has key {
    value: u64,
}
```

</details>

<details>
<summary>Hint 2: move_to syntax</summary>

The `move_to` function stores a resource at a signer's address:

```move
public entry fun initialize(account: &signer) {
    let counter = Counter { value: 0 };
    move_to(account, counter);
}
```

</details>

<details>
<summary>Hint 3: borrow_global syntax</summary>

To read a resource, use `borrow_global` with the `acquires` annotation:

```move
public fun get_value(addr: address): u64 acquires Counter {
    let counter = borrow_global<Counter>(addr);
    counter.value
}
```

</details>
