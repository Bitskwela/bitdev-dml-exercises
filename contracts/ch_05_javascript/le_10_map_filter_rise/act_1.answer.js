// Task 1: Extract and Transform with Map
function getProductNames(products) {
  // .map() creates a NEW array by transforming each element
  // Original array is NOT modified (immutable operation)

  // Arrow function: (product) => product.name.toUpperCase()
  // For each product in the array:
  // 1. Get the name property
  // 2. Convert it to uppercase with .toUpperCase()
  // 3. Return that value (arrow functions auto-return when no braces)

  return products.map((product) => product.name.toUpperCase());

  // EXAMPLE:
  // Input: [{ name: "Apple", price: 50 }, { name: "Banana", price: 30 }]
  // Output: ["APPLE", "BANANA"]

  // EQUIVALENT TRADITIONAL LOOP:
  // const names = [];
  // for (let i = 0; i < products.length; i++) {
  //   names.push(products[i].name.toUpperCase());
  // }
  // return names;

  // WHY USE MAP?
  // - More concise and readable
  // - Functional programming style (no mutations)
  // - Chainable with other array methods
}

// Task 2: Filter by Condition
function filterLowStock(products, threshold) {
  // .filter() creates a NEW array with only elements that pass the test
  // The callback returns true/false for each element
  // True = include in result, False = exclude

  return products.filter((product) => product.stock < threshold);

  // BREAKDOWN:
  // For each product, check if product.stock < threshold
  // If true, include this product in the returned array
  // If false, skip this product

  // EXAMPLE:
  // products = [
  //   { name: "Rice", stock: 5 },
  //   { name: "Eggs", stock: 20 },
  //   { name: "Sugar", stock: 3 }
  // ]
  // threshold = 10
  // Result: [{ name: "Rice", stock: 5 }, { name: "Sugar", stock: 3 }]

  // EQUIVALENT TRADITIONAL LOOP:
  // const lowStock = [];
  // for (let i = 0; i < products.length; i++) {
  //   if (products[i].stock < threshold) {
  //     lowStock.push(products[i]);
  //   }
  // }
  // return lowStock;
}

// Task 3: Calculate Total with Reduce
function calculateTotalValue(products) {
  // .reduce() collapses an array into a SINGLE value
  // Most powerful but also most complex array method

  // Parameters:
  // 1. Callback function: (accumulator, currentElement) => newAccumulator
  // 2. Initial value: 0 (starting value for accumulator)

  return products.reduce(
    (total, product) => total + product.price * product.stock,
    0,
  );

  // STEP-BY-STEP EXECUTION:
  // products = [
  //   { name: "Apple", price: 50, stock: 10 },
  //   { name: "Banana", price: 30, stock: 20 }
  // ]
  //
  // Iteration 1:
  //   total = 0 (initial value)
  //   product = { name: "Apple", price: 50, stock: 10 }
  //   return 0 + (50 * 10) = 500
  //
  // Iteration 2:
  //   total = 500 (from previous iteration)
  //   product = { name: "Banana", price: 30, stock: 20 }
  //   return 500 + (30 * 20) = 1100
  //
  // Final result: 1100

  // EQUIVALENT TRADITIONAL LOOP:
  // let total = 0;
  // for (let i = 0; i < products.length; i++) {
  //   total = total + products[i].price * products[i].stock;
  // }
  // return total;

  // COMMON REDUCE USE CASES:
  // - Sum/multiply all numbers
  // - Find max/min value
  // - Group array items into categories
  // - Transform array into object
}
