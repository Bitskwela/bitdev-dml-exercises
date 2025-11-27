// Task 1: Extract and Transform with Map
function getProductNames(products) {
  return products.map((product) => product.name.toUpperCase());
}

// Task 2: Filter by Condition
function filterLowStock(products, threshold) {
  return products.filter((product) => product.stock < threshold);
}

// Task 3: Calculate Total with Reduce
function calculateTotalValue(products) {
  return products.reduce(
    (total, product) => total + product.price * product.stock,
    0
  );
}
