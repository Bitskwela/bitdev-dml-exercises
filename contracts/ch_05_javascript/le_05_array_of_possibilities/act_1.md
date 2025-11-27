# Arrays Activity

## Initial Code

```js
// Task 1: Find the Highest Score
function findHighestScore(scores) {
  // Add your code here
}

// Task 2: Get Even Numbers
function getEvenNumbers(numbers) {
  // Add your code here
}

// Task 3: Calculate Average
function calculateAverage(grades) {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: Creating Arrays, Accessing Array Elements, Looping Through Arrays, Array Methods (`push`, `length`), `for` Loop with Arrays

---

### Task 1: Find the Highest Score

Create a function that takes an array of quiz scores and returns the highest score. Use a `for` loop to iterate through the array and compare each value.

```js
function findHighestScore(scores) {
  let highest = scores[0];

  for (let i = 1; i < scores.length; i++) {
    if (scores[i] > highest) {
      highest = scores[i];
    }
  }

  return highest;
}
```

---

### Task 2: Get Even Numbers

Create a function that takes an array of numbers and returns a new array containing only the even numbers. Use a `for` loop and the modulo operator (`%`) to check if a number is even.

```js
function getEvenNumbers(numbers) {
  let evenNumbers = [];

  for (let i = 0; i < numbers.length; i++) {
    if (numbers[i] % 2 === 0) {
      evenNumbers.push(numbers[i]);
    }
  }

  return evenNumbers;
}
```

---

### Task 3: Calculate Average

Create a function that takes an array of grades and returns the average. Use a `for` loop to sum all values, then divide by the array length.

```js
function calculateAverage(grades) {
  let sum = 0;

  for (let i = 0; i < grades.length; i++) {
    sum += grades[i];
  }

  let average = sum / grades.length;
  return average;
}
```

---

## Breakdown of the Activity

**Variables Defined:**

- `scores`: An array of numeric quiz scores passed as a parameter. Accessed using index notation like `scores[0]` or `scores[i]`.

- `highest`: A variable initialized with the first element of the array. Stores the current highest value found during iteration.

- `numbers`: An array of integers passed as a parameter. Each element is checked to determine if it's even or odd.

- `evenNumbers`: A new empty array that stores only the even numbers found. Elements are added using the `push()` method.

- `grades`: An array of numeric grade values used to calculate the average.

- `sum`: An accumulator variable initialized to 0. Stores the running total of all array elements.

- `average`: The calculated result of dividing the sum by the number of elements in the array.

- `i`: The loop counter variable used to access array elements by their index position.

**Key Concepts:**

- Creating Arrays:
  Arrays are created using square brackets `[]` with values separated by commas. Example: `let scores = [80, 75, 90, 85]`

- Accessing Array Elements:
  Elements are accessed using their index (starting from 0). Example: `scores[0]` returns the first element, `scores[2]` returns the third element.

- Array Length:
  The `.length` property returns the number of elements in an array. Used in loop conditions to prevent accessing elements beyond the array bounds.

- Looping Through Arrays:
  A `for` loop with `i` starting at 0 and running while `i < array.length` allows you to visit each element. Access the current element with `array[i]`.

- Push Method:
  The `push()` method adds a new element to the end of an array. Example: `evenNumbers.push(4)` adds 4 to the array.

- Modulo Operator:
  The `%` operator returns the remainder after division. A number is even if `number % 2 === 0` (no remainder when divided by 2).

**Key Functions:**

- `findHighestScore(scores)`:
  Demonstrates iterating through an array to find the maximum value. Initializes with the first element and compares each subsequent element.

- `getEvenNumbers(numbers)`:
  Shows how to filter an array by creating a new array and conditionally adding elements using `push()`. Uses the modulo operator to check for even numbers.

- `calculateAverage(grades)`:
  Demonstrates accumulating a sum while looping through an array, then performing a calculation with the total and array length.
