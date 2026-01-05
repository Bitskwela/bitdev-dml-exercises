# Loops in Move

## Opening Scene

Salvo was hunched over his laptop in the corner of the barangay tech hub, frustration evident on his face. Rows of repetitive code filled his screen—the same validation logic copied over and over for each beneficiary record.

"Kuya Salvo, your screen looks like a broken record," Neri teased as she walked in carrying two cups of coffee. She handed one to him and peered at his code.

"I'm checking 500 beneficiary records for the quarterly audit," Salvo groaned. "I've been writing the same code block repeatedly. There has to be a better way."

Neri pulled up a chair. "There absolutely is. You need loops—Move's way of repeating operations efficiently. Let me show you how to turn 500 lines of code into just a few."

Salvo's eyes widened with hope. "Please, before I lose my sanity."

---

## Topics

### The While Loop

"The most straightforward loop in Move is `while`," Neri began. "It keeps executing as long as a condition remains true."

```move
module audit::processor {
    public fun count_eligible(records: &vector<u64>, threshold: u64): u64 {
        let count = 0;
        let i = 0;
        let len = vector::length(records);

        while (i < len) {
            let value = *vector::borrow(records, i);
            if (value >= threshold) {
                count = count + 1;
            };
            i = i + 1;
        };

        count
    }
}
```

Salvo studied the structure. "So the loop checks `i < len` before each iteration?"

"Exactly," Neri confirmed. "When the condition becomes false, the loop stops. Always make sure your condition will eventually become false, or you'll create an infinite loop!"

```move
public fun sum_allocations(amounts: &vector<u64>): u64 {
    let total = 0;
    let index = 0;

    while (index < vector::length(amounts)) {
        total = total + *vector::borrow(amounts, index);
        index = index + 1;
    };

    total
}
```

### The Infinite Loop with Break

"Sometimes you don't know when to stop until you're inside the loop," Neri continued. "Move has `loop` for that—it runs forever until you explicitly `break` out."

```move
public fun find_first_match(records: &vector<u64>, target: u64): u64 {
    let i = 0;
    let len = vector::length(records);
    let result = 0;

    loop {
        if (i >= len) {
            break
        };

        let value = *vector::borrow(records, i);
        if (value == target) {
            result = i;
            break
        };

        i = i + 1;
    };

    result
}
```

"So `break` is the escape hatch," Salvo observed.

"Right! Without a `break`, the loop runs forever. Move will actually warn you if it can't verify your loop terminates."

### Break with Value

Neri's expression grew excited. "Here's the clever part—`break` can return a value! This makes `loop` an expression, just like `if`."

```move
public fun find_senior_index(ages: &vector<u64>): u64 {
    let i = 0;
    let len = vector::length(ages);

    let found_index = loop {
        if (i >= len) {
            break len  // Return len if not found (sentinel value)
        };

        let age = *vector::borrow(ages, i);
        if (age >= 60) {
            break i  // Return the index where senior was found
        };

        i = i + 1;
    };

    found_index
}
```

Salvo leaned in. "So the loop itself produces a value that we can assign?"

"Yes! All `break` statements in the same loop must return the same type," Neri explained.

```move
public fun calculate_until_limit(values: &vector<u64>, limit: u64): u64 {
    let i = 0;
    let sum = 0;

    loop {
        if (i >= vector::length(values)) {
            break sum
        };

        let value = *vector::borrow(values, i);
        let new_sum = sum + value;

        if (new_sum > limit) {
            break sum  // Return sum before exceeding limit
        };

        sum = new_sum;
        i = i + 1;
    }
}
```

### Continue Statement

"What if I want to skip certain iterations but keep looping?" Salvo asked.

"That's what `continue` is for," Neri replied. "It immediately jumps to the next iteration, skipping the rest of the current one."

```move
public fun sum_valid_entries(entries: &vector<u64>): u64 {
    let i = 0;
    let total = 0;
    let len = vector::length(entries);

    while (i < len) {
        let value = *vector::borrow(entries, i);
        i = i + 1;

        // Skip zero values
        if (value == 0) {
            continue
        };

        // Skip values over threshold
        if (value > 10000) {
            continue
        };

        total = total + value;
    };

    total
}
```

"Notice I increment `i` before the `continue` checks," Neri pointed out. "If you put the increment at the end, `continue` would skip it and cause an infinite loop!"

```move
public fun count_qualified(
    ages: &vector<u64>,
    incomes: &vector<u64>
): u64 {
    let i = 0;
    let count = 0;
    let len = vector::length(ages);

    while (i < len) {
        let age = *vector::borrow(ages, i);
        let income = *vector::borrow(incomes, i);
        i = i + 1;

        // Skip minors
        if (age < 18) {
            continue
        };

        // Skip high income
        if (income > 50000) {
            continue
        };

        count = count + 1;
    };

    count
}
```

### Combining Loop Patterns

"In real applications, you'll often combine these patterns," Neri said, writing a more complex example.

```move
public fun process_batch(
    records: &vector<u64>,
    batch_size: u64
): vector<u64> {
    let results = vector::empty<u64>();
    let i = 0;
    let processed = 0;
    let len = vector::length(records);

    while (i < len) {
        // Stop after processing batch_size items
        if (processed >= batch_size) {
            break
        };

        let value = *vector::borrow(records, i);
        i = i + 1;

        // Skip invalid entries
        if (value == 0) {
            continue
        };

        vector::push_back(&mut results, value * 2);
        processed = processed + 1;
    };

    results
}
```

---

## Closing Scene

Salvo's face had transformed from frustration to amazement. He rapidly refactored his code, watching 500 repetitive lines collapse into a single elegant loop.

"This is incredible, Ate Neri," he said, running his revised audit script. "What took me hours to write now fits on one screen."

Neri smiled, sipping her now-cold coffee. "Loops are one of programming's most powerful tools. They let you process any amount of data with the same small block of code."

"And the `break` with value—that's genius," Salvo added. "I can search through records and return exactly what I found."

"Just remember the golden rule," Neri cautioned. "Every loop must eventually terminate. Always ensure your condition changes, or you have a guaranteed `break`."

Salvo nodded, saving his work. "No infinite loops. Got it. The blockchain would not appreciate that."

"The blockchain validators definitely would not," Neri laughed. "Now, shall we test that audit on the real data?"

---

## Summary

### While Loop

- Syntax: `while (condition) { ... }`
- Executes as long as the condition is true
- Ensure the condition eventually becomes false to avoid infinite loops

### Loop with Break

- `loop { ... }` creates an infinite loop
- Use `break` to exit the loop
- Move requires that loops can be proven to terminate

### Break with Value

- `break value` exits the loop and returns the value
- Makes `loop` an expression that can be assigned to variables
- All `break` statements in a loop must return the same type

### Continue Statement

- `continue` skips the rest of the current iteration
- Jumps immediately to the next loop iteration
- Place increment statements before `continue` to avoid infinite loops

### Best Practices

- Always ensure loops terminate
- Update loop counters carefully when using `continue`
- Use `break` with value for search operations
- Combine `break` and `continue` for complex processing logic
