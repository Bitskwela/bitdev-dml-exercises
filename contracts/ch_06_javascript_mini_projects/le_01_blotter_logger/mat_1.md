## Background Story

Odessa woke up to the sound of roosters crowing and jeepneys rattling along Ortigas Avenue. Today was the first official barangay meeting since the lockdown eased in San Juan. Her Lola Angela had asked her to help digitize the barangay blotter—a thick, dusty notebook where Captain Cruz and his kagawads record all neighborhood incidents.

Last night, over a steaming cup of kapeng barako, Odessa sketched a simple form on a scrap of paper. She pictured a web page where residents could type in their names, issues, and locations—no more ink smudges, no more misplaced pages. Paula, her coding buddy, jumped on a video call at 6 AM to cheer her on: “Let’s prove that even sari-sari store owners can file reports with a click!”

By mid-morning, under the shade of a mango tree in the barangay hall courtyard, Odessa opened her laptop. The old blotter sat on a wooden desk, its pages curled. She felt a surge of pride: with just HTML and plain JavaScript, she could turn this analog log into a dynamic list—instantly viewable on any phone or tablet.

As residents trickled in—Aling Nena complaining about stolen sinampay, Mang Rudy reporting a stray dog—they watched in awe as entries populated live on-screen. It wasn’t a full database yet, but Paula reminded her, “Every big system starts with a small script.” When Lola Angela saw the first digital blotter entry (“Nagalit si Aling Nena kay Mang Rudy dahil sa sinampay”), she clasped Odessa’s hand and whispered, “Ang galing mo, apo.”

By sunset, Captain Cruz nodded approvingly: “This is just BlotterLog v1, but it’s a game-changer.” Odessa grinned, dreaming already of the next version with persistent storage. Little did she know, today’s simple form would spark her passion to build community tools—one barangay at a time. 🇵🇭✨

---

## Theory & Lecture Content

In this module, you’ll learn how to:

1. Select HTML elements with `querySelector`
2. Listen for form submissions using `addEventListener`
3. Use **template literals** (``) for clean string interpolation
4. Transform and render arrays with `.map()`

### 1. Selecting Elements with querySelector

```html
<!-- index.html -->
<form id="blotter-form">
  <input type="text" id="name" placeholder="Your Name" />
  <input type="text" id="issue" placeholder="Issue Description" />
  <input type="text" id="location" placeholder="Location" />
  <button type="submit">Submit</button>
</form>

<div id="blotter-logs"></div>
```

```js
// script.js
// Grab elements from the DOM
const form = document.querySelector("#blotter-form");
const nameInput = document.querySelector("#name");
const issueInput = document.querySelector("#issue");
const locationInput = document.querySelector("#location");
const logsContainer = document.querySelector("#blotter-logs");
```

Reference: https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector

### 2. Listening for Events

```js
form.addEventListener("submit", handleFormSubmit);

function handleFormSubmit(event) {
  event.preventDefault(); // stop page reload
  // … your code …
}
```

Reference: https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener

### 3. Template Literals

Template literals let you embed variables inside strings:

```js
const entry = {
  name: "Aling Nena",
  issue: "Sinampay issue",
  location: "Zone 1",
};
const html = `
  <div class="log-entry">
    <h4>${entry.name} @ ${entry.location}</h4>
    <p>${entry.issue}</p>
  </div>
`;
```

Reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals

### 4. Mapping an Array

Given an array of logs, `.map()` transforms each element:

```js
const logs = [
  { name: "Aling Nena", issue: "Sinampay", location: "Zone 1" },
  { name: "Mang Rudy", issue: "Stray dog", location: "Zone 2" },
];

const htmlArray = logs.map(
  (entry) => `
  <div class="log-entry">
    <h4>${entry.name}</h4>
    <p>${entry.issue} at ${entry.location}</p>
  </div>
`
);

const combinedHTML = htmlArray.join("");
logsContainer.innerHTML = combinedHTML;
```

Reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map

---

## Exercises

### Exercise 1: Capture and Store Blotter Entries

**Problem Statement**  
Write code that listens to the form submit, prevents default reload, retrieves input values, and pushes an object into an array.

**Todo List**

- [ ] Initialize an empty array `blotterLogs`.
- [ ] Add `submit` event listener to `#blotter-form`.
- [ ] In the handler, prevent default behavior.
- [ ] Retrieve values from `#name`, `#issue`, and `#location`.
- [ ] Push a new object `{ name, issue, location }` to `blotterLogs`.
- [ ] Log the updated array to console.

**Starter Code (script.js)**

```js
const form = document.querySelector("#blotter-form");
const nameInput = document.querySelector("#name");
const issueInput = document.querySelector("#issue");
const locationInput = document.querySelector("#location");

// TODO: Initialize array
// const blotterLogs = …

// TODO: Add event listener
form.addEventListener("submit", function (event) {
  // TODO: Prevent reload
  // TODO: Get input values
  // TODO: Push into blotterLogs
  // TODO: Console.log blotterLogs
});
```

**Full Solution (script.js)**

```js
const form = document.querySelector("#blotter-form");
const nameInput = document.querySelector("#name");
const issueInput = document.querySelector("#issue");
const locationInput = document.querySelector("#location");

const blotterLogs = [];

form.addEventListener("submit", function (event) {
  event.preventDefault();

  const name = nameInput.value.trim();
  const issue = issueInput.value.trim();
  const location = locationInput.value.trim();

  blotterLogs.push({ name, issue, location });
  console.log(blotterLogs);

  // Clear inputs for next entry
  nameInput.value = "";
  issueInput.value = "";
  locationInput.value = "";
});
```

### Exercise 2: Render Blotter Entries Using map() and Template Literals

**Problem Statement**  
Create a function `renderBlotter()` that reads `blotterLogs` and displays them inside `#blotter-logs` using `.map()` and template literals.

**Todo List**

- [ ] Define `renderBlotter()` function.
- [ ] Inside, use `.map()` on `blotterLogs` to build an array of HTML strings.
- [ ] Join the array into one string.
- [ ] Set `logsContainer.innerHTML` to that string.
- [ ] Call `renderBlotter()` after pushing a new entry.

**Starter Code (script.js)**

```js
const logsContainer = document.querySelector("#blotter-logs");
const blotterLogs = []; // from Exercise 1

function renderBlotter() {
  // TODO: Map blotterLogs to HTML array
  // const htmlArray = …
  // TODO: Join into single string
  // const htmlString = …
  // TODO: Insert into DOM
  // logsContainer.innerHTML = …
}

// After adding to blotterLogs:
renderBlotter();
```

**Full Solution (script.js)**

```js
const logsContainer = document.querySelector("#blotter-logs");
const blotterLogs = [];

function renderBlotter() {
  const htmlArray = blotterLogs.map(
    (entry) => `
    <div class="log-entry">
      <h4>${entry.name} @ ${entry.location}</h4>
      <p>${entry.issue}</p>
    </div>
  `
  );

  logsContainer.innerHTML = htmlArray.join("");
}

// Form handler from Exercise 1
form.addEventListener("submit", function (event) {
  event.preventDefault();
  const name = nameInput.value.trim();
  const issue = issueInput.value.trim();
  const location = locationInput.value.trim();

  blotterLogs.push({ name, issue, location });
  renderBlotter();

  nameInput.value = "";
  issueInput.value = "";
  locationInput.value = "";
});
```

### Exercise 3: Add Simple Validation

**Problem Statement**  
Ensure that users cannot submit empty fields. If any input is empty, display an `alert` and do **not** add to `blotterLogs`.

**Todo List**

- [ ] In form handler, check if any input is an empty string.
- [ ] If so, call `alert('Please fill in all fields!')` and return early.
- [ ] Otherwise, proceed to push and render.

**Starter Code (script.js)**

```js
form.addEventListener("submit", function (event) {
  event.preventDefault();

  const name = nameInput.value.trim();
  const issue = issueInput.value.trim();
  const location = locationInput.value.trim();

  // TODO: If any field is empty, alert and return

  blotterLogs.push({ name, issue, location });
  renderBlotter();
});
```

**Full Solution (script.js)**

```js
form.addEventListener("submit", function (event) {
  event.preventDefault();

  const name = nameInput.value.trim();
  const issue = issueInput.value.trim();
  const location = locationInput.value.trim();

  if (!name || !issue || !location) {
    alert("Please fill in all fields!");
    return;
  }

  blotterLogs.push({ name, issue, location });
  renderBlotter();

  nameInput.value = "";
  issueInput.value = "";
  locationInput.value = "";
});
```

---

## Test Cases

Install Jest and jsdom environment first:

```bash
npm install --save-dev jest
```

Add to `package.json`:

```json
"scripts": {
  "test": "jest"
},
"jest": {
  "testEnvironment": "jsdom"
}
```

Create `script.js` as an ES module:

```js
// script.js
export let blotterLogs = [];

export function addBlotterEntry(name, issue, location) {
  const entry = { name, issue, location };
  blotterLogs.push(entry);
  return entry;
}

export function renderBlotter(logs) {
  return logs
    .map(
      (e) => `
    <div class="log-entry">
      <h4>${e.name} @ ${e.location}</h4>
      <p>${e.issue}</p>
    </div>
  `
    )
    .join("");
}
```

Write tests in `script.test.js`:

```js
/**
 * @jest-environment jsdom
 */
import { blotterLogs, addBlotterEntry, renderBlotter } from "./script.js";

beforeEach(() => {
  // Reset the array before each test
  blotterLogs.length = 0;
});

test("addBlotterEntry pushes correct object", () => {
  const entry = addBlotterEntry("Test User", "Test Issue", "Test Location");
  expect(blotterLogs).toHaveLength(1);
  expect(entry).toEqual({
    name: "Test User",
    issue: "Test Issue",
    location: "Test Location",
  });
});

test("renderBlotter produces correct HTML", () => {
  blotterLogs.push(
    { name: "A", issue: "I1", location: "L1" },
    { name: "B", issue: "I2", location: "L2" }
  );
  const html = renderBlotter(blotterLogs);
  expect(html).toContain("A @ L1");
  expect(html).toContain("<p>I1</p>");
  expect(html).toContain("B @ L2");
  expect(html).toContain("<p>I2</p>");
});

test("renderBlotter returns empty string when no logs", () => {
  const html = renderBlotter([]);
  expect(html).toBe("");
});
```

Run tests:

```bash
npm test
```

---

## Closing Story

As dusk settled over San Juan, Odessa and Paula looked at the glowing laptop screen. The digital blotter now captured each resident’s story with clean lines of HTML and JavaScript. No more crumpled notebooks, no more lost pages. Captain Cruz clapped his hands in delight: “Couldn’t have imagined this a year ago!”

Odessa felt her confidence soar. She knew that moving forward, she’d need to make these logs permanent—surviving page reloads, user sessions, and even power outages. Paula teased, “LocalStorage next, sis!”

As the evening breeze whispered through the mango leaves, Odessa closed her laptop with a smile. Today was version 1. Tomorrow? She’d build BlotterLog v2—with data that never disappears. 🚀

_Next up: Persistent Storage and LocalStorage API!_
