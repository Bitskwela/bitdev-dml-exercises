// Task 1: Welcome Message Function
function welcomeStudent(name) {
  if (!name) {
    return "Welcome, Student!";
  } else {
    return `Welcome, ${name}!`;
  }
}

// Task 2: Calculate Total Price
function calculateTotal(price, quantity) {
  if (!quantity) {
    quantity = 1;
  }
  return price * quantity;
}

// Task 3: Check Pass or Fail
function checkGrade(score) {
  return score >= 75 ? "Passed" : "Failed";
}
