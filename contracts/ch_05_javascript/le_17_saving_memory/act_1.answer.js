// Task 1: Save and Load Theme Preference
function saveTheme(theme) {
  // LOCAL STORAGE: Browser's way to store data that persists across sessions
  // setItem(key, value) stores a string value
  // localStorage persists even after browser closes (unlike sessionStorage)
  localStorage.setItem("app-theme", theme);

  // localStorage can only store STRINGS
  // For objects/arrays, use JSON.stringify() first
}

function loadTheme() {
  // getItem(key) retrieves the stored value
  // Returns null if key doesn't exist
  const savedTheme = localStorage.getItem("app-theme");

  // Check what was saved and return appropriate value
  if (savedTheme === "dark") {
    return "dark";
  } else {
    return "light"; // Default to light if nothing saved or value is different
  }

  // SIMPLER VERSION:
  // return localStorage.getItem("app-theme") || "light";
  // The || operator returns "light" if getItem returns null/undefined
}

// Task 2: Save and Load Array Data
function saveScores(scores) {
  // JSON.stringify() converts array/object to JSON string
  // localStorage can only store strings, not arrays directly
  localStorage.setItem("app-scores", JSON.stringify(scores));

  // Example: [85, 90, 78] becomes the string "[85,90,78]"
}

function loadScores() {
  // Get the JSON string from localStorage
  const raw = localStorage.getItem("app-scores");

  // If nothing was saved, return empty array
  if (!raw) {
    return [];
  }

  try {
    // TRY/CATCH: JSON.parse() can throw an error if string is invalid JSON

    // JSON.parse() converts JSON string back to JavaScript value
    const parsed = JSON.parse(raw);

    // Verify it's actually an array (safety check)
    if (Array.isArray(parsed)) {
      return parsed;
    } else {
      return []; // Return empty array if data was corrupted
    }
  } catch (error) {
    // If JSON.parse() fails (corrupted data), return empty array
    return [];
  }
}

// Task 3: Clear Specific Data
function clearUserData(key) {
  // Check if the key exists in localStorage
  // getItem() returns null if key doesn't exist
  const exists = localStorage.getItem(key) !== null;

  if (exists) {
    // removeItem(key) deletes the stored item
    localStorage.removeItem(key);
    return true; // Indicate successful deletion
  }

  return false; // Key didn't exist, nothing to delete

  // OTHER USEFUL METHODS:
  // localStorage.clear() - removes ALL stored items
  // localStorage.length - number of stored items
  // localStorage.key(index) - get key name by index
}
