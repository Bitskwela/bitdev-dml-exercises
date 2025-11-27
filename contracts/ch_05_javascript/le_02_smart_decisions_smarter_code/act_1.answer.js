// Task 1: Budget Validation
function checkBudgetStatus(budget) {
  if (budget > 5000) {
    return "Over budget";
  } else if (budget == 5000) {
    return "At limit";
  } else {
    return "Under budget";
  }
}

// Task 2: Entry Validation with Multiple Conditions
function isValidEntry(amount) {
  if (amount > 0 && amount <= 5000) {
    return true;
  } else {
    return false;
  }
}

// Task 3: Budget Category Classifier
function classifyExpense(amount, category) {
  if (category == "event" && amount > 3000) {
    return "High event expense";
  } else if (category == "event" && amount <= 3000) {
    return "Normal event expense";
  } else if (category == "supplies" || category == "food") {
    return "Operational expense";
  } else {
    return "Uncategorized expense";
  }
}
