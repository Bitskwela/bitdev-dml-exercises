// Task 1: Print Numbers with For Loop
function printNumbers(start, end) {
  // A for loop is perfect when you know the exact range (start to end)
  // Initialization: let i = start (begin at the start value)
  // Condition: i <= end (continue until we reach end, inclusive)
  // Increment: i++ (add 1 to i after each iteration)
  for (let i = start; i <= end; i++) {
    console.log(i);
  }

  // Why use 'let' instead of 'var'?
  // - let has block scope (stays within this loop)
  // - var has function scope (can cause bugs in nested loops)
}

// Task 2: Sum Array Elements with While Loop
function sumArray(numbers) {
  let sum = 0; // Accumulator: stores the running total
  let i = 0; // Counter: tracks which array position we're on

  // While loop continues AS LONG AS i < numbers.length
  // We don't know array length in advance, making while a good choice here
  while (i < numbers.length) {
    sum = sum + numbers[i]; // Add current element to sum
    // Could also write as: sum += numbers[i];

    i++; // CRITICAL: Increment i or loop runs forever (infinite loop!)
  }

  return sum;

  // NOTE: In real projects, you'd use modern array methods:
  // return numbers.reduce((sum, num) => sum + num, 0);
  // But for learning loops, this manual approach shows the concept clearly
}

// Task 3: Generate Multiplication Table with Nested Loops
function multiplicationTable(size) {
  let table = []; // Will hold all rows

  // Outer loop: Creates each row (i controls row number)
  for (let i = 0; i < size; i++) {
    let row = []; // New empty row for each iteration

    // Inner loop: Fills the current row with values (j controls column number)
    // For each row i, we loop through all columns j
    for (let j = 0; j < size; j++) {
      // Multiply (i+1) by (j+1) because arrays start at 0
      // Example: When i=0, j=0 → (0+1) * (0+1) = 1 * 1 = 1
      //          When i=0, j=1 → (0+1) * (1+1) = 1 * 2 = 2
      row.push((i + 1) * (j + 1));
    }

    // After inner loop completes one row, add it to the table
    table.push(row);

    // Execution flow for size=3:
    // i=0: row = [1, 2, 3], table = [[1, 2, 3]]
    // i=1: row = [2, 4, 6], table = [[1, 2, 3], [2, 4, 6]]
    // i=2: row = [3, 6, 9], table = [[1, 2, 3], [2, 4, 6], [3, 6, 9]]
  }

  return table;
}
