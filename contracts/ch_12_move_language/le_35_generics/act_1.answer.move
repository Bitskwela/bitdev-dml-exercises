module patrol::generic_storage {
    use std::vector;
    use std::signer;

    // Generic Container struct that can hold items of any type T
    struct Container<T> has key {
        items: vector<T>,
        capacity: u64
    }

    // Generic Wrapper struct for wrapping single values
    struct Wrapper<T> has copy, drop, store {
        value: T
    }

    // Initialize a container for storing items of type T
    public fun init_container<T: store>(account: &signer, max_capacity: u64) {
        move_to(account, Container<T> {
            items: vector::empty<T>(),
            capacity: max_capacity
        });
    }

    // Wrap any value in a Wrapper struct
    public fun wrap<T>(value: T): Wrapper<T> {
        Wrapper { value }
    }

    // Extract the value from a Wrapper
    public fun unwrap<T>(wrapper: Wrapper<T>): T {
        let Wrapper { value } = wrapper;
        value
    }

    // Add an item to the container with capacity checking
    public fun add_item<T: store>(account: &signer, item: T) acquires Container {
        let addr = signer::address_of(account);
        let container = borrow_global_mut<Container<T>>(addr);
        
        assert!(vector::length(&container.items) < container.capacity, 1);
        vector::push_back(&mut container.items, item);
    }

    // Get the count of items in a container
    public fun get_item_count<T: store>(addr: address): u64 acquires Container {
        let container = borrow_global<Container<T>>(addr);
        vector::length(&container.items)
    }

    // === Additional utility functions ===

    // Check if container has space
    public fun has_space<T: store>(addr: address): bool acquires Container {
        let container = borrow_global<Container<T>>(addr);
        vector::length(&container.items) < container.capacity
    }

    // Get remaining capacity
    public fun remaining_capacity<T: store>(addr: address): u64 acquires Container {
        let container = borrow_global<Container<T>>(addr);
        container.capacity - vector::length(&container.items)
    }

    // Create a pair of wrapped values
    public fun wrap_pair<A, B>(first: A, second: B): (Wrapper<A>, Wrapper<B>) {
        (Wrapper { value: first }, Wrapper { value: second })
    }
}
