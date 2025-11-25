# localStorage Activity

## Initial Code

```js
// Task 1: Save and Load Theme Preference
function saveTheme(theme) {
  // Add your code here
}

function loadTheme() {
  // Add your code here
}

// Task 2: Save and Load Array Data
function saveScores(scores) {
  // Add your code here
}

function loadScores() {
  // Add your code here
}

// Task 3: Clear Specific Data
function clearUserData(key) {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: `localStorage.setItem()`, `localStorage.getItem()`, `localStorage.removeItem()`, `JSON.stringify()`, `JSON.parse()`

---

### Task 1: Save and Load Theme Preference

Create two functions: `saveTheme(theme)` that saves a theme preference ("light" or "dark") to localStorage, and `loadTheme()` that retrieves the saved theme or returns "light" as the default.

```js
function saveTheme(theme) {
  localStorage.setItem("app-theme", theme);
}

function loadTheme() {
  const savedTheme = localStorage.getItem("app-theme");

  if (savedTheme === "dark") {
    return "dark";
  } else {
    return "light";
  }
}
```

---

### Task 2: Save and Load Array Data

Create two functions: `saveScores(scores)` that saves an array of numbers to localStorage, and `loadScores()` that retrieves and parses the array. Return an empty array if no data exists or if parsing fails.

```js
function saveScores(scores) {
  localStorage.setItem("app-scores", JSON.stringify(scores));
}

function loadScores() {
  const raw = localStorage.getItem("app-scores");

  if (!raw) {
    return [];
  }

  try {
    const parsed = JSON.parse(raw);
    if (Array.isArray(parsed)) {
      return parsed;
    } else {
      return [];
    }
  } catch (error) {
    return [];
  }
}
```

---

### Task 3: Clear Specific Data

Create a function that removes a specific item from localStorage by its key. Return `true` if the item existed and was removed, `false` if the key didn't exist.

```js
function clearUserData(key) {
  const exists = localStorage.getItem(key) !== null;

  if (exists) {
    localStorage.removeItem(key);
    return true;
  }

  return false;
}
```

---

## Breakdown of the Activity

**Variables Defined:**

- `theme`: A string parameter representing the user's theme preference, either "light" or "dark".

- `savedTheme`: The value retrieved from localStorage for the theme key. May be null if not set.

- `scores`: An array of numbers to be saved to localStorage.

- `raw`: The raw string value retrieved from localStorage before parsing.

- `parsed`: The JavaScript array resulting from parsing the JSON string.

- `key`: A string parameter representing the localStorage key to remove.

- `exists`: A boolean indicating whether a key exists in localStorage.

**Key Concepts:**

- `localStorage.setItem(key, value)`:
  Stores a string value under the specified key. If the key already exists, the value is overwritten. Only accepts string values.

- `localStorage.getItem(key)`:
  Retrieves the string value for a key. Returns `null` if the key doesn't exist. Always returns a string or null.

- `localStorage.removeItem(key)`:
  Removes the item with the specified key from storage. Does nothing if the key doesn't exist.

- `JSON.stringify(value)`:
  Converts a JavaScript value (object, array, etc.) to a JSON string. Required because localStorage only stores strings.

- `JSON.parse(string)`:
  Converts a JSON string back to a JavaScript value. Throws an error if the string is not valid JSON, so use try/catch.

- Default Values:
  Always provide a fallback value when loading from localStorage, as the data may not exist or may be corrupted.

- Error Handling:
  Wrap `JSON.parse()` in try/catch to handle corrupted or invalid data gracefully.

**Key Functions:**

- `saveTheme(theme)`:
  Demonstrates basic localStorage usage for storing a simple string value.

- `loadTheme()`:
  Shows how to retrieve a value and provide a default when the value doesn't exist or is invalid.

- `saveScores(scores)`:
  Demonstrates converting an array to JSON string before storing in localStorage.

- `loadScores()`:
  Shows the full pattern of retrieving, parsing, validating, and handling errors for complex data.

- `clearUserData(key)`:
  Demonstrates checking for existence and removing specific items from localStorage.
