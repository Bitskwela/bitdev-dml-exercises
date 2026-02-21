// Task 1: Budget Validation
function checkBudgetStatus(budget) {
  // Using if...else if...else to handle three distinct cases
  // We check the highest value first (> 5000)
  if (budget > 5000) {
    return "Over budget";
  } else if (budget === 5000) {
    // Using === (strict equality) instead of == prevents type coercion bugs
    // This checks if budget is EXACTLY 5000 (same value AND same type)
    return "At limit";
  } else {
    // If neither above condition is true, budget must be < 5000
    return "Under budget";
  }
}

// Task 2: Entry Validation with Multiple Conditions
function isValidEntry(amount) {
  // The && (AND) operator requires BOTH conditions to be true
  // 1. amount > 0 (must be positive)
  // 2. amount <= 5000 (must not exceed limit)
  if (amount > 0 && amount <= 5000) {
    return true;
  } else {
    return false;
  }

  // NOTE: This can be simplified to a single line (you'll learn this later):
  // return amount > 0 && amount <= 5000;
  // The condition itself evaluates to true/false, so we don't need the if/else
}

// Task 3: Budget Category Classifier
function classifyExpense(amount, category) {
  // Combining both && (AND) and || (OR) operators
  // Order matters! Check specific cases (event + amount) before general cases

  if (category === "event" && amount > 3000) {
    // Both must be true: category is "event" AND amount exceeds 3000
    return "High event expense";
  } else if (category === "event" && amount <= 3000) {
    // Event expenses 3000 or less
    return "Normal event expense";
  } else if (category === "supplies" || category === "food") {
    // The || (OR) operator means AT LEAST ONE condition must be true
    // This catches both "supplies" and "food" categories
    return "Operational expense";
  } else {
    // Fallback case: catches everything that doesn't match above conditions
    return "Uncategorized expense";
  }
}
