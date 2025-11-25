# Map, Filter, and Reduce Activity

## Initial Code

```js
// Task 1: Extract and Transform with Map
function getProductNames(products) {
  // Add your code here
}

// Task 2: Filter by Condition
function filterLowStock(products, threshold) {
  // Add your code here
}

// Task 3: Calculate Total with Reduce
function calculateTotalValue(products) {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: `.map()` Method, `.filter()` Method, `.reduce()` Method, Arrow Functions, Array Transformation

---

### Task 1: Extract and Transform with Map

Create a function that takes an array of product objects (each with `name`, `price`, and `stock` properties) and returns a new array containing only the product names in uppercase. Use the `.map()` method.

```js
function getProductNames(products) {
  return products.map((product) => product.name.toUpperCase());
}
```

---

### Task 2: Filter by Condition

Create a function that takes an array of products and a threshold number. Return a new array containing only the products where `stock` is less than the threshold. Use the `.filter()` method.

```js
function filterLowStock(products, threshold) {
  return products.filter((product) => product.stock < threshold);
}
```

---

### Task 3: Calculate Total with Reduce

Create a function that calculates the total inventory value of all products. The value of each product is calculated as `price * stock`. Use the `.reduce()` method to sum up all the values.

```js
function calculateTotalValue(products) {
  return products.reduce(
    (total, product) => total + product.price * product.stock,
    0
  );
}
```

---

## Breakdown of the Activity

**Variables Defined:**

- `products`: An array of product objects, each containing `name`, `price`, and `stock` properties. Passed as a parameter to all functions.

- `product`: The current element being processed in the callback function. Represents a single product object during iteration.

- `threshold`: A numeric parameter representing the stock level below which products are considered "low stock".

- `total`: The accumulator in the `.reduce()` method. Stores the running sum of inventory values.

**Key Concepts:**

- `.map()` Method:
  Creates a new array by calling a function on every element. The callback receives each element and returns a transformed value. Original array is unchanged.

  ```js
  array.map((element) => transformedValue);
  ```

- `.filter()` Method:
  Creates a new array with elements that pass a test. The callback returns `true` to keep the element or `false` to exclude it.

  ```js
  array.filter((element) => condition);
  ```

- `.reduce()` Method:
  Reduces an array to a single value by applying a function to each element. Takes an accumulator and current value, plus an initial value.

  ```js
  array.reduce((accumulator, current) => newAccumulator, initialValue);
  ```

- Arrow Functions:
  A concise syntax for writing functions. `(param) => expression` is shorthand for `function(param) { return expression; }`.

- Chaining Methods:
  Array methods can be chained together because each returns a new array (except `.reduce()`). Example: `array.filter(...).map(...)`.

- Pure Functions:
  Functions that don't modify the original data and always return the same output for the same input. `.map()`, `.filter()`, and `.reduce()` are designed for pure functions.

**Key Functions:**

- `getProductNames(products)`:
  Demonstrates `.map()` to extract and transform a single property from each object. Uses `.toUpperCase()` to transform strings.

- `filterLowStock(products, threshold)`:
  Shows how `.filter()` creates a subset of an array based on a condition comparing object properties to a threshold value.

- `calculateTotalValue(products)`:
  Uses `.reduce()` to aggregate values across an array. Demonstrates calculating derived values (`price * stock`) and accumulating a sum.
