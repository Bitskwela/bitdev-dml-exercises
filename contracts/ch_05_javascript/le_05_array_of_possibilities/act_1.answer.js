// Task 1: Find the Highest Score
function findHighestScore(scores) {
  let highest = scores[0];

  for (let i = 1; i < scores.length; i++) {
    if (scores[i] > highest) {
      highest = scores[i];
    }
  }

  return highest;
}

// Task 2: Get Even Numbers
function getEvenNumbers(numbers) {
  let evenNumbers = [];

  for (let i = 0; i < numbers.length; i++) {
    if (numbers[i] % 2 === 0) {
      evenNumbers.push(numbers[i]);
    }
  }

  return evenNumbers;
}

// Task 3: Calculate Average
function calculateAverage(grades) {
  let sum = 0;

  for (let i = 0; i < grades.length; i++) {
    sum += grades[i];
  }

  let average = sum / grades.length;
  return average;
}
