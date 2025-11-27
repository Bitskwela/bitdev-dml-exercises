## Background Story

It was 7 AM in Pasig City, and Odessa was already sipping her extra-strong barako coffee at the office ☕️. As the logistics startup grew, live delivery updates poured in every second: “Pack #123 picked up,” “Pack #456 delivered,” “Pack #789 delayed”—all in one big `<div id="updates"></div>`. Every time a van moved, she had to refresh the page. It felt like watching EDSA traffic through a cracked windshield—chaotic and frustrating.

Her lead, Kuya Ronnie, winked: “Ods, stop hard-coding HTML. Learn to build DOM elements on the fly with `createElement`, `appendChild`, and `removeChild`. Your page will update itself—no reload needed!”

Inspired, Odessa opened her editor. She started with one delivery card:

```js
const card = document.createElement("div");
card.className = "update-card";
card.textContent = "Pack #101 is out for delivery";
document.getElementById("updates").appendChild(card);
```

She watched the card appear instantly—like magic. Next, she learned to remove a card when the package was delivered:

```js
const container = document.getElementById("updates");
const toRemove = document.querySelector('[data-id="101"]');
container.removeChild(toRemove);
```

Odessa grinned. Her updates panel was becoming a living, breathing feed. Later that afternoon, in a video call with a Manila-based client, she demoed a page where new cards popped in every time a van hit a waypoint, and old cards vanished when delivery was complete. The client clapped—no more manual refreshes!

As the sun set over the Ortigas skyline, Odessa imagined her future startup dashboard: real-time maps, blinking pins, and auto-updating status cards—all built from scratch in JavaScript. With `createElement`, `appendChild`, and `removeChild` mastered, she was ready to build dynamic UIs that solve real-world problems, one delivery update at a time 🚚💨.

---

## Theory & Lecture Content

Modern JavaScript lets you manipulate the page structure at runtime using DOM methods. Today we cover:

1. document.createElement
2. node.appendChild
3. node.removeChild

### 1. document.createElement

Use this to create any HTML element in memory.

```js
const p = document.createElement("p");
p.textContent = "Hello, Odessa!";
p.className = "greeting"; // set CSS class
p.setAttribute("data-id", "100");
```

Nothing appears on the page yet—this element exists only in JavaScript.

---

### 2. appendChild

To insert your new element into the page, append it to a parent node.

```js
const container = document.getElementById("updates");
container.appendChild(p);
```

Best practice: if you need to add many elements at once, use a `DocumentFragment` to minimize reflows.

```js
const frag = document.createDocumentFragment();
for (let i = 0; i < 5; i++) {
  const li = document.createElement("li");
  li.textContent = `Item ${i + 1}`;
  frag.appendChild(li);
}
document.querySelector("ul").appendChild(frag);
```

Reference:  
https://developer.mozilla.org/en-US/docs/Web/API/Document/createDocumentFragment

---

### 3. removeChild

To remove an element from its parent:

```js
const container = document.getElementById("updates");
const oldCard = document.querySelector('[data-id="100"]');
if (oldCard) {
  container.removeChild(oldCard);
}
```

You can also clear all children:

```js
const container = document.getElementById("updates");
while (container.firstChild) {
  container.removeChild(container.firstChild);
}
```

Reference:  
https://developer.mozilla.org/en-US/docs/Web/API/Node/removeChild

---

## Closing Story

With those functions mastered, Odessa refreshed her live deliveries panel without a single page reload. Every time a new package was scanned, JavaScript created a shiny card in her browser; every completed delivery vanished in an instant. The office monitors now felt alive—each DOM update was a heartbeat in her logistics network.

Kuya Ronnie dropped a message: “Next up: Event Delegation & Custom Events. You’ll make your UI interactive and lean. Ready to catch clicks and fire your own events?”

Odessa smiled, stretching her arms. Dynamic DOM was powerful, but adding interactivity would make her dashboard truly come alive. Tomorrow, she’d learn to handle user clicks, delegate events, and build custom events that flow through her app like data pipelines. Her journey from static HTML to real-time dynamic UIs was just getting started—and the future looked bright, one element at a time. 🚀
