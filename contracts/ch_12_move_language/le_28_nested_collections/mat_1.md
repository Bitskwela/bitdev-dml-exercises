# Nested Collections: Ronnie's Complex Inventory

## The Multi-Level Challenge

Ronnie ran a warehouse that supplied sari-sari stores across multiple barangays. His inventory system needed to track products organized by category, and each category had multiple items with varying quantities.

"Det, our simple list isn't cutting it anymore," Ronnie sighed. "I need categories, and each category has many products, and each product has stock levels across different warehouses!"

Det, his tech-savvy nephew, nodded. "Sounds like you need nested collections, Tito. Data structures inside data structures!"

## Vector of Vectors

The simplest nested structure is a vector containing other vectors:

```move
module warehouse::inventory {

    public struct ProductGrid has store, drop {
        // Each inner vector represents a row of product IDs
        // Outer vector holds multiple rows
        grid: vector<vector<u64>>,
    }

    public fun create_grid(): ProductGrid {
        ProductGrid {
            grid: vector::empty(),
        }
    }

    public fun add_row(grid: &mut ProductGrid) {
        vector::push_back(&mut grid.grid, vector::empty());
    }

    public fun add_product_to_row(
        grid: &mut ProductGrid,
        row_index: u64,
        product_id: u64
    ) {
        let row = vector::borrow_mut(&mut grid.grid, row_index);
        vector::push_back(row, product_id);
    }

    public fun get_product(grid: &ProductGrid, row: u64, col: u64): u64 {
        let row_vec = vector::borrow(&grid.grid, row);
        *vector::borrow(row_vec, col)
    }
}
```

## Building a 2D Matrix

```move
module warehouse::matrix {

    // Create a 3x3 matrix of zeros
    public fun create_3x3_matrix(): vector<vector<u64>> {
        let mut matrix = vector::empty();

        let mut i = 0;
        while (i < 3) {
            let mut row = vector::empty();
            let mut j = 0;
            while (j < 3) {
                vector::push_back(&mut row, 0);
                j = j + 1;
            };
            vector::push_back(&mut matrix, row);
            i = i + 1;
        };

        matrix
    }

    // Set value at position
    public fun set_value(
        matrix: &mut vector<vector<u64>>,
        row: u64,
        col: u64,
        value: u64
    ) {
        let row_vec = vector::borrow_mut(matrix, row);
        *vector::borrow_mut(row_vec, col) = value;
    }

    // Get value at position
    public fun get_value(matrix: &vector<vector<u64>>, row: u64, col: u64): u64 {
        let row_vec = vector::borrow(&matrix, row);
        *vector::borrow(row_vec, col)
    }
}
```

## Nested Maps with VecMap

For more complex lookups, you can nest VecMaps:

```move
module warehouse::category_inventory {
    use sui::vec_map::{Self, VecMap};

    public struct Warehouse has key {
        id: UID,
        // Category name -> (Product ID -> Quantity)
        inventory: VecMap<vector<u8>, VecMap<u64, u64>>,
    }

    public fun create_warehouse(ctx: &mut TxContext): Warehouse {
        Warehouse {
            id: object::new(ctx),
            inventory: vec_map::empty(),
        }
    }

    public fun add_category(warehouse: &mut Warehouse, category: vector<u8>) {
        if (!vec_map::contains(&warehouse.inventory, &category)) {
            vec_map::insert(
                &mut warehouse.inventory,
                category,
                vec_map::empty()
            );
        };
    }

    public fun add_product(
        warehouse: &mut Warehouse,
        category: vector<u8>,
        product_id: u64,
        quantity: u64
    ) {
        // Get the inner map for this category
        let products = vec_map::get_mut(&mut warehouse.inventory, &category);

        if (vec_map::contains(products, &product_id)) {
            // Update existing quantity
            let current = vec_map::get_mut(products, &product_id);
            *current = *current + quantity;
        } else {
            // Add new product
            vec_map::insert(products, product_id, quantity);
        };
    }

    public fun get_quantity(
        warehouse: &Warehouse,
        category: vector<u8>,
        product_id: u64
    ): u64 {
        let products = vec_map::get(&warehouse.inventory, &category);
        *vec_map::get(products, &product_id)
    }
}
```

## Complex Data: Structs in Collections

For real-world scenarios, nest structs within collections:

```move
module warehouse::full_inventory {
    use sui::vec_map::{Self, VecMap};

    public struct Product has store, copy, drop {
        id: u64,
        name: vector<u8>,
        price: u64,
        quantity: u64,
    }

    public struct Category has store {
        name: vector<u8>,
        products: vector<Product>,
    }

    public struct FullWarehouse has key {
        id: UID,
        categories: VecMap<vector<u8>, Category>,
    }

    public fun create_full_warehouse(ctx: &mut TxContext): FullWarehouse {
        FullWarehouse {
            id: object::new(ctx),
            categories: vec_map::empty(),
        }
    }

    public fun create_category(
        warehouse: &mut FullWarehouse,
        name: vector<u8>
    ) {
        let category = Category {
            name: copy name,
            products: vector::empty(),
        };
        vec_map::insert(&mut warehouse.categories, name, category);
    }

    public fun add_product_to_category(
        warehouse: &mut FullWarehouse,
        category_name: vector<u8>,
        product_id: u64,
        product_name: vector<u8>,
        price: u64,
        quantity: u64
    ) {
        let category = vec_map::get_mut(&mut warehouse.categories, &category_name);
        let product = Product {
            id: product_id,
            name: product_name,
            price: price,
            quantity: quantity,
        };
        vector::push_back(&mut category.products, product);
    }

    public fun get_product_count_in_category(
        warehouse: &FullWarehouse,
        category_name: vector<u8>
    ): u64 {
        let category = vec_map::get(&warehouse.categories, &category_name);
        vector::length(&category.products)
    }
}
```

## Multi-Warehouse Tracking

Ronnie needed to track stock across multiple warehouse locations:

```move
module warehouse::multi_location {
    use sui::vec_map::{Self, VecMap};

    public struct StockLevel has store, copy, drop {
        quantity: u64,
        last_updated: u64,
    }

    public struct MultiWarehouse has key {
        id: UID,
        // Location -> (Product ID -> Stock Level)
        locations: VecMap<vector<u8>, VecMap<u64, StockLevel>>,
    }

    public fun create_multi_warehouse(ctx: &mut TxContext): MultiWarehouse {
        MultiWarehouse {
            id: object::new(ctx),
            locations: vec_map::empty(),
        }
    }

    public fun add_location(mw: &mut MultiWarehouse, location: vector<u8>) {
        vec_map::insert(&mut mw.locations, location, vec_map::empty());
    }

    public fun update_stock(
        mw: &mut MultiWarehouse,
        location: vector<u8>,
        product_id: u64,
        quantity: u64,
        timestamp: u64
    ) {
        let loc_inventory = vec_map::get_mut(&mut mw.locations, &location);

        let stock = StockLevel {
            quantity: quantity,
            last_updated: timestamp,
        };

        if (vec_map::contains(loc_inventory, &product_id)) {
            let existing = vec_map::get_mut(loc_inventory, &product_id);
            *existing = stock;
        } else {
            vec_map::insert(loc_inventory, product_id, stock);
        };
    }

    public fun get_total_stock_for_product(
        mw: &MultiWarehouse,
        product_id: u64
    ): u64 {
        let mut total = 0;
        let locations = vec_map::keys(&mw.locations);
        let len = vector::length(&locations);

        let mut i = 0;
        while (i < len) {
            let location = vector::borrow(&locations, i);
            let loc_inventory = vec_map::get(&mw.locations, location);

            if (vec_map::contains(loc_inventory, &product_id)) {
                let stock = vec_map::get(loc_inventory, &product_id);
                total = total + stock.quantity;
            };

            i = i + 1;
        };

        total
    }
}
```

## Traversing Nested Collections

```move
// Iterate through all products in all categories
public fun count_all_products(warehouse: &FullWarehouse): u64 {
    let mut count = 0;
    let category_names = vec_map::keys(&warehouse.categories);
    let num_categories = vector::length(&category_names);

    let mut i = 0;
    while (i < num_categories) {
        let name = vector::borrow(&category_names, i);
        let category = vec_map::get(&warehouse.categories, name);
        count = count + vector::length(&category.products);
        i = i + 1;
    };

    count
}

// Find a product across all categories
public fun find_product_category(
    warehouse: &FullWarehouse,
    product_id: u64
): Option<vector<u8>> {
    let category_names = vec_map::keys(&warehouse.categories);
    let num_categories = vector::length(&category_names);

    let mut i = 0;
    while (i < num_categories) {
        let name = vector::borrow(&category_names, i);
        let category = vec_map::get(&warehouse.categories, name);

        let num_products = vector::length(&category.products);
        let mut j = 0;
        while (j < num_products) {
            let product = vector::borrow(&category.products, j);
            if (product.id == product_id) {
                return option::some(*name)
            };
            j = j + 1;
        };

        i = i + 1;
    };

    option::none()
}
```

## Best Practices for Nested Collections

Det summarized the key points for his Tito Ronnie:

1. **Keep nesting shallow** - More than 2-3 levels becomes hard to manage
2. **Use meaningful structs** - Wrap inner collections in named structs for clarity
3. **Consider gas costs** - Deep nesting means more storage operations
4. **Plan access patterns** - Design based on how you'll query the data
5. **Handle missing data** - Always check `contains()` before accessing nested maps

## Summary

"So I can organize products by category, then by location, then by individual items?" Ronnie asked.

Det smiled. "Exactly, Tito! Vector of vectors for grids, VecMap of VecMaps for hierarchical lookups, and structs inside collections for rich data. The key is matching your data structure to how you'll use it."

**Key Takeaways:**

- `vector<vector<T>>` creates 2D arrays or grids
- `VecMap<K, VecMap<K2, V>>` enables hierarchical key-value lookups
- Structs with collection fields organize complex related data
- Always check existence before accessing nested elements
- Keep nesting levels manageable for maintainability
