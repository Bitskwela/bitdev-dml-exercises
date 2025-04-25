# Arrays and the Rising Chaos Continues

## Scene

Neri’s day begins in the lively streets of San Juan. It’s the weekend, and she heads to the palengke (_wet market_) to buy groceries. The vendors are bustling, calling out prices for freshly caught fish, ripe mangoes, and crunchy vegetables. However, something is off.

The digital payment terminals at the stalls are glitching again. As Neri attempts to buy her favorite bangus (_milkfish_) and some calamansi, she notices that the payments are either being overcharged or duplicated. Vendors are writing down transactions on scratch paper, struggling to keep track of who owes what.

One vendor, Mang Ramon, sighs, “**Kung meron lang tayong paraan para ma-track nang maayos ang mga transaksyon, hindi tayo magulo nang ganito.**”

(_If only we had a proper way to track transactions, we wouldn’t be in such chaos._)

Neri thinks for a moment and remembers something from her Solidity training: arrays. Arrays could simplify this chaos by organizing data, like keeping a running list of all transactions or payments.

## Solidity Topics: Arrays

An array in Solidity is a data structure that allows you to store multiple values of the same type. Arrays are useful for keeping track of sequential data like transactions, IDs, or even names.

### Types of Arrays:

- Fixed-Size Arrays: The size is defined at the time of declaration.

  **Example:** `uint256[5] public fixedArray;`

- Dynamic Arrays: The size is not predefined and can grow or shrink.

  **Example:** `uint256[] public dynamicArray;`

### Common Operations

- Adding Elements: Use the `push()` function for dynamic arrays.

- Accessing Elements: Use the index, starting from 0.

  **Example:** `array[0]` retrieves the first element.

- Modifying Elements: Assign a new value to a specific index.

  **Example:** `array[0] = 100;`

#### Why Arrays Are Useful:

- Store repetitive or sequential data (e.g., all sales made in a day).
- Retrieve, modify, or delete items quickly using their index.

### How to use Arrays in Solidity

- Declare an Array

  - **Example:**

    ```solidity
    uint256[] public payments;
    ```

- Add item to an array

  - **Example:**

    ```solidity
    payments.push(100); // Add a payment of 100
    ```

- Retrieve an element from the array

  - **Example:**

    ```solidity
    uint256 firstPayment = payments[0];
    ```

- Loop through an array

  - **Example:**

    ```solidity
    for (uint256 i = 0; i < payments.length; i++) {
    // Process payments[i]
    }
    ```
