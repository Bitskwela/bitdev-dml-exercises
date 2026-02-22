// Task 1: Welcome Message Function
function welcomeStudent(name) {
  // This function demonstrates DEFAULT BEHAVIOR with parameters
  // The !name check handles "falsy" values (undefined, null, empty string, etc.)

  if (!name) {
    // If no name is provided (or name is falsy), use a generic message
    return "Welcome, Student!";
  } else {
    // If a name IS provided, personalize the message
    // Using template literals (backticks) for string interpolation
    return `Welcome, ${name}!`;
  }

  // MODERN ALTERNATIVE: You could use default parameters (ES6):
  // function welcomeStudent(name = "Student") {
  //   return `Welcome, ${name}!`;
  // }
  // This achieves the same result more concisely
}

// Task 2: Calculate Total Price
function calculateTotal(price, quantity) {
  // This demonstrates handling OPTIONAL PARAMETERS
  // If quantity is not provided, it will be undefined

  if (!quantity) {
    // Default to 1 if quantity is not provided
    quantity = 1;
  }

  // Multiply price by quantity to get total
  return price * quantity;

  // EXAMPLES:
  // calculateTotal(100, 5) → 500 (price 100, quantity 5)
  // calculateTotal(100) → 100 (price 100, quantity defaults to 1)

  // MODERN ALTERNATIVE: Default parameter
  // function calculateTotal(price, quantity = 1) {
  //   return price * quantity;
  // }
}

// Task 3: Check Pass or Fail
function checkGrade(score) {
  // This uses the TERNARY OPERATOR: condition ? valueIfTrue : valueIfFalse
  // It's a concise way to write simple if...else statements

  // Check if score >= 75 (passing grade in Philippine schools)
  return score >= 75 ? "Passed" : "Failed";

  // EQUIVALENT IF...ELSE VERSION:
  // if (score >= 75) {
  //   return "Passed";
  // } else {
  //   return "Failed";
  // }

  // The ternary is more concise for simple true/false returns
  // Use it when the logic is straightforward and fits on one line

  // EXAMPLES:
  // checkGrade(80) → "Passed" (80 >= 75 is true)
  // checkGrade(70) → "Failed" (70 >= 75 is false)
  // checkGrade(75) → "Passed" (75 >= 75 is true, equals counts!)
}
