## Background Story

![Cover Image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_6/C6+1.0+-+COVER.png)

Odessa woke up to the sound of roosters crowing and jeepneys rattling along Ortigas Avenue. Today was the first official barangay meeting since the lockdown eased in San Juan. Her Lola Angela had asked her to help digitize the barangay blotter—a thick, dusty notebook where Captain Cruz and his kagawads record all neighborhood incidents.

![image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_6/C6+1.1.png)

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
`,
);

const combinedHTML = htmlArray.join("");
logsContainer.innerHTML = combinedHTML;
```

Reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map

---

## Closing Story

As dusk settled over San Juan, Odessa and Paula looked at the glowing laptop screen. The digital blotter now captured each resident’s story with clean lines of HTML and JavaScript. No more crumpled notebooks, no more lost pages. Captain Cruz clapped his hands in delight: “Couldn’t have imagined this a year ago!”

Odessa felt her confidence soar. She knew that moving forward, she’d need to make these logs permanent—surviving page reloads, user sessions, and even power outages. Paula teased, “LocalStorage next, sis!”

As the evening breeze whispered through the mango leaves, Odessa closed her laptop with a smile. Today was version 1. Tomorrow? She’d build BlotterLog v2—with data that never disappears. 🚀

_Next up: Persistent Storage and LocalStorage API!_
