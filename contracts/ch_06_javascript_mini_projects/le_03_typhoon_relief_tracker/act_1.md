# Typhoon Relief Tracker Activity

## Initial Code

```js
// Task 1: Load and Save Relief Data
function loadReliefData() {
  // Add your code here
}

function saveReliefData(data) {
  // Add your code here
}

// Task 2: Update Relief Item
function updateReliefItem(data, item, count) {
  // Add your code here
}

function resetReliefData() {
  // Add your code here
}

// Task 3: Render Relief Table
function renderTable(data) {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: `localStorage`, `JSON.stringify()`, `JSON.parse()`, `Object.entries()`, `for...of`, DOM Manipulation, Table Rendering

---

### Task 1: Load and Save Relief Data

Create two functions for localStorage persistence:

- `loadReliefData()` - retrieves and parses data from localStorage, returns empty object if not found
- `saveReliefData(data)` - converts object to JSON and saves to localStorage

```js
function loadReliefData() {
  const raw = localStorage.getItem("reliefData");
  if (raw) {
    return JSON.parse(raw);
  } else {
    return {};
  }
}

function saveReliefData(data) {
  localStorage.setItem("reliefData", JSON.stringify(data));
}
```

---

### Task 2: Update Relief Item

Create functions to modify relief data:

- `updateReliefItem(data, item, count)` - adds count to existing item or creates new entry, then saves
- `resetReliefData()` - clears localStorage and returns empty object

```js
function updateReliefItem(data, item, count) {
  const current = data[item] || 0;
  data[item] = current + count;
  saveReliefData(data);
  return data;
}

function resetReliefData() {
  localStorage.removeItem("reliefData");
  return {};
}
```

---

### Task 3: Render Relief Table

Create a function that renders the relief data as HTML table rows. Use `Object.entries()` to iterate over the data object and build the table body content.

```js
function renderTable(data) {
  const tableBody = document.querySelector("#relief-table tbody");
  let rows = "";

  for (const [item, count] of Object.entries(data)) {
    rows += `<tr><td>${item}</td><td>${count}</td></tr>`;
  }

  tableBody.innerHTML = rows;
}
```

---

## Breakdown of the Activity

**Variables Defined:**

- `raw`: The raw string retrieved from localStorage before parsing.

- `data`: An object where keys are item names (e.g., "Rice") and values are counts (e.g., 50).

- `item`: A string representing the donation item name.

- `count`: A number representing the quantity to add to the donation.

- `current`: The existing count for an item, defaults to 0 if item doesn't exist.

- `tableBody`: Reference to the `<tbody>` element where table rows will be rendered.

- `rows`: A string accumulating HTML table row elements.

**Key Concepts:**

- `localStorage`:
  Browser storage API that persists data across sessions. Data survives page refresh and browser restart.

- `JSON.stringify()`:
  Converts JavaScript objects to JSON strings for storage. Required because localStorage only stores strings.

- `JSON.parse()`:
  Converts JSON strings back to JavaScript objects. Used when retrieving data from localStorage.

- `Object.entries()`:
  Returns an array of `[key, value]` pairs from an object. Useful for iterating over object properties.

- `for...of` Loop:
  Iterates over iterable objects like arrays. Combined with destructuring `[key, value]` for clean iteration.

- Default Values with `||`:
  The expression `data[item] || 0` returns 0 if `data[item]` is undefined or falsy.

- `localStorage.removeItem()`:
  Removes a specific item from localStorage by its key.

**Key Functions:**

- `loadReliefData()`:
  Retrieves relief data from localStorage. Returns parsed object or empty object if no data exists.

- `saveReliefData(data)`:
  Persists the relief data object to localStorage as a JSON string.

- `updateReliefItem(data, item, count)`:
  Increments the count for an item (or creates it) and saves. Returns the updated data object.

- `resetReliefData()`:
  Clears all relief data from localStorage and returns an empty object for a fresh start.

- `renderTable(data)`:
  Converts the data object to HTML table rows and updates the DOM.
