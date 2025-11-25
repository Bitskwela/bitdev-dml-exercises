// Task 1: Parse JSON Safely
function parseJSONSafely(jsonString) {
  try {
    const data = JSON.parse(jsonString);
    return data;
  } catch (error) {
    console.error("Error parsing JSON:", error.message);
    return null;
  }
}

// Task 2: Safe Division
function safeDivide(a, b) {
  try {
    if (b === 0) {
      throw new Error("Cannot divide by zero");
    }
    return a / b;
  } catch (error) {
    console.error("Division error:", error.message);
    return null;
  }
}

// Task 3: Handle API Error
function fetchUserData() {
  try {
    // Simulating network failure
    throw new Error("Network connection failed");
  } catch (error) {
    console.error("Failed to fetch user data:", error.message);
    return {
      success: false,
      error: error.message,
    };
  }
}
