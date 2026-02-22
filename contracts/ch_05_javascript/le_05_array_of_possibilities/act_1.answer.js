// Task 1: Find the Highest Score

function findHighestScore(scores) {
  // Start by assuming the first element is the highest
  // This is a common pattern when searching through arrays
  let highest = scores[0];

  // Loop starting from index 1 (we already have scores[0])
  // This small optimization avoids comparing scores[0] to itself
  for (let i = 1; i < scores.length; i++) {
    // Compare current element with our current highest
    // If current is higher, update highest to this new value
    if (scores[i] > highest) {
      highest = scores[i];
    }
  }

  // After checking all elements, highest contains the maximum value
  return highest;
}

// Task 2: Get Even Numbers

function getEvenNumbers(numbers) {
  // Create an empty array to store our filtered results
  // We'll add only even numbers to this array
  let evenNumbers = [];

  // Check each number in the input array
  for (let i = 0; i < numbers.length; i++) {
    // The modulo operator % gives the remainder after division
    // Any number divided by 2 with remainder 0 is even
    // Examples: 4 % 2 = 0 (even), 5 % 2 = 1 (odd)
    if (numbers[i] % 2 === 0) {
      // push() adds an element to the end of an array
      // This builds our result array one even number at a time
      evenNumbers.push(numbers[i]);
    }
  }

  // Return the new array containing only even numbers
  // The original 'numbers' array is unchanged (non-destructive operation)
  return evenNumbers;
}

// Task 3: Calculate Average

function calculateAverage(grades) {
  // Initialize a bucket to collect the sum of all grades
  // Starting at 0 is crucial for addition
  let sum = 0;

  // Visit each grade and add it to our running total
  // This is called "accumulation" - building up a value
  for (let i = 0; i < grades.length; i++) {
    // += is shorthand for: sum = sum + grades[i]
    sum += grades[i];
  }

  // Average = total sum divided by count of items
  // grades.length gives us how many grade values we have
  // Example: [80, 90, 70] → sum=240, length=3 → average=80
  let average = sum / grades.length;

  // Note: If grades is empty, this returns NaN (division by zero)
  // In production code, you'd check: if (grades.length === 0) return 0;
  return average;
}

// Modern JavaScript alternative (preview for Lesson 10):
// These functions could also be written using array methods like:
// - findHighestScore: Math.max(...scores)
// - getEvenNumbers: numbers.filter(n => n % 2 === 0)
// - calculateAverage: scores.reduce((sum, score) => sum + score, 0) / scores.length
// We'll learn these powerful methods in Lesson 10!
