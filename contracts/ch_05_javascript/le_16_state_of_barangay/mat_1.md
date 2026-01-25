## Background Story

![Cover Image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_5/C5+16.0+-+COVER.png)

It was a rainy afternoon in Gloria, Oriental Mindoro - typical monsoon day when barangay hall operations slow to a crawl. Odessa was in her home office, sipping hot kamote tea, when her cousin from the barangay association called her in a panic.

![image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_5/C5+16.1.png)

“Ods, we have so many resident complaints, permit requests, and purok assignments. Every page refresh resets our form data. We need a tool that remembers our place—parang memory ng lolo’t lola natin!” 😅

Odessa smiled. She knew this was a perfect chance to practice application state management. She recalled her days at the startup, juggling user sessions, routing between login, dashboard, and settings screens—all without losing data. Now, she had to build a light barangay app that:

1. **Remembers** which screen the user is on (e.g., “New Complaint” vs. “View Residents”).
2. **Stores** drafts and form inputs as they type.
3. **Persists** data across refresh, so no lost work.

She sketched a simple flow: a global `state` object to hold `currentScreen`, `draftComplaint`, and a list of `residents`. She’d wrap it in a module (`stateManager.js`) with methods `getState()`, `setState()`, `saveState()`, and `loadState()`. For persistence, she’d use `localStorage`.

By evening, her code editor lit up with neatly organized files:

- `index.html` with three `<section>` screens
- `stateManager.js` exporting state functions
- `app.js` to wire UI events, call `showScreen()`

Within minutes, her cousin’s barangay app could switch screens without losing the draft complaint. Even after reload, the draft reappeared! Odessa leaned back, proud—she was thinking like a systems architect, designing clear state flows, preventing global namespace collisions, and ensuring data persisted like a true Pinoy talaarawan (journal).

As the rain lulled to a drizzle, Odessa imagined scaling this to a full municipal system. But first, she’d teach you how to master application state—one global object at a time. 🌧️➡️☀️

---

## Theory & Lecture Content

Managing state means tracking the “current values” of your app: UI screen, form inputs, user data, etc.

### 1. Why State Matters

- Keeps UI in sync with data.
- Prevents lost inputs on navigation or refresh.
- Centralizes data for debugging & testing.

### 2. Global Variables & Namespacing

A single global object avoids polluting `window`:

```js
// BAD: many globals
let currentScreen = "home";
let draft = {};

// BETTER: single namespace
const AppState = {};
```

Use a module pattern:

```js
// stateManager.js
const AppState = {
  currentScreen: "home",
  draftComplaint: "",
  residents: [],
};
export default AppState;
```

### 3. Encapsulating State Access

Direct mutation is risky. Provide getters/setters:

```js
// stateManager.js
const state = {
  currentScreen: "home",
  draftComplaint: "",
  residents: [],
};

export function getState(key) {
  return state[key];
}

export function setState(key, value) {
  state[key] = value;
}
```

### 4. Persisting State (localStorage)

```js
export function saveState() {
  localStorage.setItem("appState", JSON.stringify(state));
}

export function loadState() {
  const json = localStorage.getItem("appState");
  if (json) {
    Object.assign(state, JSON.parse(json));
  }
}
```

Call `loadState()` on startup, and `saveState()` on changes.

Reference:  
https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage

### 5. Screen Management

Show/hide sections based on `currentScreen`:

```js
export function showScreen(name) {
  setState("currentScreen", name);
  saveState();
  document.querySelectorAll("section").forEach((sec) => {
    sec.style.display = sec.id === name ? "block" : "none";
  });
}
```

---

## Closing Story

As dusk fell over Gloria, Odessa watched her cousin’s barangay workers navigate the app effortlessly. Screens switched without losing drafts, resident lists loaded instantly, and every keystroke was saved—no more “Data lost!” panic. She closed her laptop, thinking: “An architect thinks in state flows and data persistence.”

Her next challenge loomed: orchestrating user interactions with event delegation and custom events, making UIs not just stateful but interactive. Tomorrow, she’d dive into listening for clicks at scale, bubbling events, and crafting custom signals between modules—like barangay tanod coordinating a smooth fiesta procession. 🎉

Odessa smiled, ready to design the next layer of her application’s intelligence. The state was managed—now it was time to make it responsive. 🚀
