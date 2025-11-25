# Loops of Liberation Activity

## Initial Code

```js
// Task 1: Print Numbers with For Loop
function printNumbers(start, end) {
  // Add your code here
}

// Task 2: Sum Array Elements with While Loop
function sumArray(numbers) {
  // Add your code here
}

// Task 3: Generate Multiplication Table with Nested Loops
function multiplicationTable(size) {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: `for` loop, `while` loop, `do...while` loop, Nested Loops

---

### Task 1: Print Numbers with For Loop

Create a function that uses a `for` loop to print all numbers from `start` to `end` (inclusive). Each number should be logged to the console.

```js
function printNumbers(start, end) {
  for (let i = start; i <= end; i++) {
    console.log(i);
  }
}
```

---

### Task 2: Sum Array Elements with While Loop

Create a function that uses a `while` loop to calculate the sum of all numbers in an array. Return the total sum.

```js
function sumArray(numbers) {
  let sum = 0;
  let i = 0;

  while (i < numbers.length) {
    sum = sum + numbers[i];
    i++;
  }

  return sum;
}
```

---

### Task 3: Generate Multiplication Table with Nested Loops

Create a function that uses nested `for` loops to generate a multiplication table. The function takes a `size` parameter and returns a 2D array where each element at position `[i][j]` equals `(i+1) * (j+1)`.

```js
function multiplicationTable(size) {
  let table = [];

  for (let i = 0; i < size; i++) {
    let row = [];
    for (let j = 0; j < size; j++) {
      row.push((i + 1) * (j + 1));
    }
    table.push(row);
  }

  return table;
}
```

---

## Breakdown of the Activity

**Variables Defined:**

- `start`: A numeric parameter representing the starting number for the loop. Used as the initial value in the `for` loop.

- `end`: A numeric parameter representing the ending number for the loop. Used as the condition boundary in the `for` loop.

- `numbers`: An array of numbers to be summed. Accessed using index `i` inside the `while` loop.

- `sum`: An accumulator variable initialized to 0 that stores the running total as we iterate through the array.

- `i`: A counter variable used to track the current position in the loop. Incremented with `i++` after each iteration.

- `size`: A numeric parameter that determines the dimensions of the multiplication table (size x size).

- `table`: A 2D array (array of arrays) that stores the multiplication table results.

- `row`: A temporary array that stores each row of the multiplication table before being pushed to the main table.

**Key Concepts:**

- `for` Loop:
  The most common loop structure with three parts: initialization (`let i = start`), condition (`i <= end`), and increment (`i++`). The loop continues as long as the condition is true.

- `while` Loop:
  Executes a block of code as long as a specified condition is true. The condition is checked before each iteration. Useful when you don't know exactly how many times to loop.

- `do...while` Loop:
  Similar to `while`, but the condition is checked after the code block executes. This guarantees the code runs at least once.

- Nested Loops:
  Placing one loop inside another. The inner loop completes all its iterations for each single iteration of the outer loop. Useful for working with 2D data structures like tables or grids.

- Loop Control:
  - `i++` increments the counter by 1
  - `i < array.length` ensures we don't go beyond the array bounds
  - The condition determines when the loop stops

**Key Functions:**

- `printNumbers(start, end)`:
  Demonstrates a basic `for` loop that iterates from a starting value to an ending value. Uses `console.log()` to output each number.

- `sumArray(numbers)`:
  Shows how to use a `while` loop to iterate through an array. Uses an index variable `i` and the array's `length` property to control the loop.

- `multiplicationTable(size)`:
  Demonstrates nested loops where the outer loop handles rows and the inner loop handles columns. Shows how to build a 2D array dynamically using `push()`.
