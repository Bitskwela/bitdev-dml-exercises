module patrol::constrained_registry {
    use std::vector;
    use std::signer;

    // CopyableCache: stores items that can be copied and dropped
    struct CopyableCache<T: copy + drop> has key {
        items: vector<T>,
        last_accessed: T
    }

    // PersistentStore: stores data that can persist in storage
    struct PersistentStore<T: store> has key, store {
        data: T,
        backup: vector<T>
    }

    // FlexibleBox: maximum flexibility with copy, drop, and store
    struct FlexibleBox<T: copy + drop + store> has key, copy, drop, store {
        contents: T
    }

    // Initialize a cache for copyable/droppable types
    public fun create_cache<T: copy + drop>(account: &signer, initial: T) {
        move_to(account, CopyableCache<T> {
            items: vector::empty<T>(),
            last_accessed: initial
        });
    }

    // Add item to cache and update last_accessed
    public fun cache_item<T: copy + drop>(
        account: &signer, 
        item: T
    ) acquires CopyableCache {
        let addr = signer::address_of(account);
        let cache = borrow_global_mut<CopyableCache<T>>(addr);
        
        vector::push_back(&mut cache.items, copy item);
        cache.last_accessed = item;
    }

    // Return a copy of the last accessed item
    public fun get_last_accessed<T: copy + drop>(addr: address): T acquires CopyableCache {
        let cache = borrow_global<CopyableCache<T>>(addr);
        cache.last_accessed
    }

    // Get all cached items (returns copy)
    public fun get_all_items<T: copy + drop>(addr: address): vector<T> acquires CopyableCache {
        let cache = borrow_global<CopyableCache<T>>(addr);
        cache.items
    }

    // Initialize a persistent store
    public fun create_store<T: store>(account: &signer, initial_data: T) {
        move_to(account, PersistentStore<T> {
            data: initial_data,
            backup: vector::empty<T>()
        });
    }

    // Add to backup in persistent store
    public fun backup_data<T: store + copy>(account: &signer) acquires PersistentStore {
        let addr = signer::address_of(account);
        let store = borrow_global_mut<PersistentStore<T>>(addr);
        vector::push_back(&mut store.backup, copy store.data);
    }

    // Create a flexible box
    public fun create_box<T: copy + drop + store>(
        account: &signer, 
        value: T
    ) {
        move_to(account, FlexibleBox<T> { contents: value });
    }

    // Duplicate a flexible box (demonstrates copy ability)
    public fun duplicate_box<T: copy + drop + store>(
        box: FlexibleBox<T>
    ): (FlexibleBox<T>, FlexibleBox<T>) {
        let copy1 = copy box;
        (copy1, box)
    }

    // Get contents from box (copy)
    public fun peek_box<T: copy + drop + store>(box: &FlexibleBox<T>): T {
        box.contents
    }

    // Check if cache exists for a type
    public fun cache_exists<T: copy + drop>(addr: address): bool {
        exists<CopyableCache<T>>(addr)
    }

    // Check if store exists for a type
    public fun store_exists<T: store>(addr: address): bool {
        exists<PersistentStore<T>>(addr)
    }
}
