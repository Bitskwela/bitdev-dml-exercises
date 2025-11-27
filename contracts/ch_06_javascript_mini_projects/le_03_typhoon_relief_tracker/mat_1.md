## Background Story

When Typhoon Dante tore through Luzon, the streets of Marikina and nearby barangays felt its fury. Fallen trees blocked roads, floodwaters swept away supplies, and neighbors rallied to help one another. Odessa and Paula didn’t hesitate—they volunteered at the barangay hall’s relief operations. Inside, a whiteboard listed incoming rice sacks, canned goods, water bottles, and medicines. But the marker kept running out of ink, entries disappeared, and volunteers often duplicated counts. Chaos reigned from dawn to dusk.

On the third day, while drinking tsokolate at a sari-sari store turned makeshift pantry, Odessa whispered to Paula, “We can fix this with code.” Paula’s eyes lit up. Under the dim hall lights, Odessa sketched a simple tracker: an input for item name, a number field for quantity, and buttons to add or reset. The data would persist in the browser’s **localStorage**, so even when the power flickered or the page reloaded, no donation count would vanish.

Back at home, with a cup of kape brewed by her Lola, Odessa fired up her laptop. The clock read 1 AM, but the memory of volunteers scrambling for markers drove her on. She coded an **ES6 module** to load existing data from localStorage, parse it into an object, and render each relief item in a clean table. Using `Object.entries()` and `for…in`, she transformed raw data into readable rows: “Rice – 50 sacks,” “Canned Goods – 120 cans,” and so on.

By dawn, the prototype was ready. Paula joined Odessa at the barangay hall with her tablet. Volunteers gathered as Odessa clicked “Add Donation,” typed “Rice” and “10,” and watched the tally jump from 50 to 60. No marker drama, no smudges—just code. When the mayor’s assistant peeked in for a progress report, Odessa beamed: “I made it in one hour.” Paula nudged her, knowing Odessa’s calm voice hid the quiet drive of a coding beast.

Now, the relief team tracks donations reliably. When trucks loaded with water bottles arrive, they log every case. When barangay kagawads ask for totals, Odessa hits “Export” (coming soon!) and shares the data. The once-chaotic whiteboard is now a digital dashboard. Yet Odessa already dreams of the next feature: synchronizing data across multiple devices via a cloud database. But for today, they celebrate a small victory—code that turns bayanihan into lasting order. 🇵🇭✨

---

## Theory & Lecture Content

In this module, you’ll learn how to:

1. Use **localStorage** for persistent data.
2. Convert objects to/from JSON with `JSON.stringify` / `JSON.parse`.
3. Manipulate the DOM to render dynamic tables.
4. Iterate over objects using `for…in` and `Object.entries()`.
5. Organize code into clear, reusable functions.

### 1. Working with localStorage

```js
// Save JavaScript object to localStorage
const data = { Rice: 50, CannedGoods: 120 };
localStorage.setItem("reliefData", JSON.stringify(data));

// Load and parse back into object
const stored = localStorage.getItem("reliefData");
const reliefData = stored ? JSON.parse(stored) : {};
```

Reference: https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage

### 2. Iterating Object Data

```js
// Using for…in
for (const item in reliefData) {
  console.log(`${item} – ${reliefData[item]}`);
}

// Using Object.entries()
Object.entries(reliefData).forEach(([key, value]) => {
  console.log(`${key}: ${value}`);
});
```

Reference:

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/for...in
- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/entries

### 3. Rendering to the DOM

```html
<!-- index.html -->
<div>
  <input id="item-name" placeholder="Item Name" />
  <input id="item-count" type="number" placeholder="Count" />
  <button id="add-btn">Add Donation</button>
  <button id="reset-btn">Reset All</button>
</div>
<table id="relief-table">
  <thead>
    <tr>
      <th>Item</th>
      <th>Count</th>
    </tr>
  </thead>
  <tbody></tbody>
</table>
```

```js
// script.js
const tableBody = document.querySelector("#relief-table tbody");
function renderTable(data) {
  let rows = "";
  for (const [item, count] of Object.entries(data)) {
    rows += `<tr><td>${item}</td><td>${count}</td></tr>`;
  }
  tableBody.innerHTML = rows;
}
```

---

## Closing Story

As relief operations settled into a smooth rhythm, volunteers no longer chased missing markers. Odessa’s BayanihanTracker became the heartbeat of their logistics—every sack of rice, can of sardines, and box of meds logged safely in the browser. The mayor’s assistant emailed for a “printout,” which Odessa quickly exported by copying the table.

Yet deep down, Odessa knew this was just version 1. Soon, she’d integrate a real database, real-time updates across devices, and user authentication for multiple barangays. But for now, she closed her laptop with pride: code had turned crisis into calm.

_Next up: Building a backend API with Fetch and creating a full-stack relief dashboard!_ 🚀
