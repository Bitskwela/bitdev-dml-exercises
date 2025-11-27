# Application State Management Activity

## Initial Code

```js
// stateManager.js
// Task 1: Create a State Manager
const state = {
  currentScreen: "home",
  draft: "",
  items: [],
};

function getState(key) {
  // Add your code here
}

function setState(key, value) {
  // Add your code here
}

function saveState() {
  // Add your code here
}

function loadState() {
  // Add your code here
}

// app.js
// Task 2: Screen Navigation
function showScreen(name) {
  // Add your code here
}

// Task 3: Persist Form Input
function setupDraftPersistence() {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: Global State Object, `getState`/`setState` Pattern, `localStorage`, State Persistence, Screen Management

---

### Task 1: Create a State Manager

Create a state manager module with functions to get and set state values, and save/load state using `localStorage`. The state object should have `currentScreen`, `draft`, and `items` properties.

```js
const state = {
  currentScreen: "home",
  draft: "",
  items: [],
};

function getState(key) {
  return state[key];
}

function setState(key, value) {
  state[key] = value;
}

function saveState() {
  localStorage.setItem("appState", JSON.stringify(state));
}

function loadState() {
  const json = localStorage.getItem("appState");
  if (json) {
    Object.assign(state, JSON.parse(json));
  }
}
```

---

### Task 2: Screen Navigation

Create a function that shows the correct screen based on the state. It should update the `currentScreen` state, save to localStorage, and show/hide HTML sections based on their id.

```js
function showScreen(name) {
  setState("currentScreen", name);
  saveState();

  const sections = document.querySelectorAll("section");
  sections.forEach((section) => {
    if (section.id === name) {
      section.style.display = "block";
    } else {
      section.style.display = "none";
    }
  });
}
```

---

### Task 3: Persist Form Input

Create a function that sets up draft persistence. It should load the saved draft into a textarea and save the draft to state on every input event.

```js
function setupDraftPersistence() {
  const draftTextarea = document.querySelector("#draft");

  // Load saved draft
  draftTextarea.value = getState("draft");

  // Save draft on input
  draftTextarea.addEventListener("input", function (event) {
    setState("draft", event.target.value);
    saveState();
  });
}
```

---

## Breakdown of the Activity

**Variables Defined:**

- `state`: A private object that holds all application state. Contains `currentScreen`, `draft`, and `items` properties.

- `currentScreen`: A string indicating which screen/section is currently visible (e.g., "home", "form", "list").

- `draft`: A string storing the user's draft text input that should persist across page refreshes.

- `items`: An array for storing any list data the application needs to track.

- `key`: A string parameter used to access specific properties in the state object.

- `value`: The value to be stored in the state for a given key.

**Key Concepts:**

- Global State Object:
  A single object that holds all application data. Avoids polluting the global namespace with many variables. Makes state predictable and centralized.

- Encapsulated State Access:
  Using `getState()` and `setState()` functions instead of directly accessing the state object. This allows for validation, logging, or side effects when state changes.

- `localStorage`:
  Browser API for storing key-value pairs that persist across sessions. Data survives page refresh and browser restart. Only stores strings.

- `JSON.stringify()` / `JSON.parse()`:
  Convert JavaScript objects to JSON strings for storage, and parse JSON strings back to objects when loading.

- `Object.assign()`:
  Copies properties from source objects to a target object. Used to merge loaded state into the existing state object.

- Screen Management:
  Pattern of showing/hiding HTML sections based on current state. Uses `querySelectorAll` and `style.display` to control visibility.

**Key Functions:**

- `getState(key)`:
  Returns the value of a specific property from the state object. Provides controlled read access to state.

- `setState(key, value)`:
  Updates a specific property in the state object. Provides controlled write access to state.

- `saveState()`:
  Persists the entire state object to localStorage as a JSON string.

- `loadState()`:
  Retrieves state from localStorage and merges it into the current state object.

- `showScreen(name)`:
  Updates the currentScreen state, saves to localStorage, and toggles visibility of HTML sections.
