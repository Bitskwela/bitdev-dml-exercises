## Background Story

The rush-hour heat in Metro Manila can turn any jeepney ride into an epic odyssey. Odessa remembers one steamy afternoon in Cubao, where the air con was broken and the driver insisted on “₱12 na po, ma’am” even though her usual ₱10 fare applied. Paula, sitting beside her, immediately quibbled over the overcharge. They ended up arguing with three passengers playing referee. By the time Odessa got off at Pasig, she was determined: enough with the guesswork—she’d build a tool to calculate exact jeepney fares by route, discounts, and add-ons.

That evening, over taho and a cold sago’t gulaman, Odessa sketched **JeepFareCalc v2** on a napkin. Riders could select from popular routes—Cubao to Pasig, Trinoma to QC Hall, EDSA to Ortigas—and tick off discounts like “Student” or “Senior.” An optional “Luggage Fee” checkbox would add a flat ₱5 when commuters lugged heavy bags. Paula’s eyes sparkled: “No more driver overcharges, no more endless math!”

With the spirit of Pinoy innovation—“padyak” meets pixels—Odessa coded late into the night. She created clean HTML dropdowns, hooked JavaScript listeners, and built a core `calculateFare()` function. Every change fired instant recalculation, displaying the fare formatted with `toFixed(2)`. When she demoed it to Jeepney Facebook groups at 2 AM, the app went viral—drivers even asked for a change-tracker feature next!

Now, as the sun peeks over Guadalupe Bridge, Odessa’s JeepFareCalc v2 stands poised to bring fairness and transparency back to Metro Manila’s jeepneys. But this is just the beginning of her mission: to empower every commuter with clear, reliable code. 🚍💨

---

## Theory & Lecture Content

In this lesson, we’ll learn how to:

1. Select and listen to HTML elements
2. Map routes to base fares
3. Use conditional logic for discounts and add-ons
4. Format numbers with `toFixed(2)`
5. Structure code into reusable functions

### 1. HTML Setup

```html
<!-- index.html -->
<form id="fare-form">
  <label for="route-select">Route:</label>
  <select id="route-select">
    <option value="cubao-pasig">Cubao – Pasig</option>
    <option value="trinoma-qch">Trinoma – QC Hall</option>
    <option value="edsa-ortigas">EDSA – Ortigas</option>
  </select>

  <label for="discount-select">Discount:</label>
  <select id="discount-select">
    <option value="none">None</option>
    <option value="student">Student (₱2 off)</option>
    <option value="senior">Senior (₱3 off)</option>
  </select>

  <label>
    <input type="checkbox" id="luggage-addon" />
    Luggage Fee (+₱5)
  </label>

  <button type="button" id="calc-btn">Calculate Fare</button>
</form>

<div id="fare-result">Fare: ₱0.00</div>
```

### 2. Selecting Elements & Listening for Events

```js
// script.js
const routeSelect = document.querySelector("#route-select");
const discountSelect = document.querySelector("#discount-select");
const luggageCheckbox = document.querySelector("#luggage-addon");
const calcBtn = document.querySelector("#calc-btn");
const resultDiv = document.querySelector("#fare-result");

calcBtn.addEventListener("click", () => {
  // Will call calculateFare() and update DOM
});
```

Reference: https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector  
Reference: https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener

### 3. Mapping Routes to Base Fares

```js
function getBaseFare(route) {
  const fares = {
    "cubao-pasig": 10,
    "trinoma-qch": 12,
    "edsa-ortigas": 11,
  };
  return fares[route] || 0;
}
```

### 4. Calculating Final Fare

```js
function calculateFare(route, discount, hasLuggage) {
  let fare = getBaseFare(route);

  // Apply discount
  if (discount === "student") fare -= 2;
  else if (discount === "senior") fare -= 3;

  // Apply luggage fee
  if (hasLuggage) fare += 5;

  // Prevent negative fare
  fare = Math.max(fare, 0);

  return fare.toFixed(2);
}
```

Reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toFixed

### 5. Updating the DOM

```js
calcBtn.addEventListener("click", () => {
  const route = routeSelect.value;
  const discount = discountSelect.value;
  const hasLuggage = luggageCheckbox.checked;

  const fare = calculateFare(route, discount, hasLuggage);
  resultDiv.textContent = `Fare: ₱${fare}`;
});
```

---

## Exercises

### Exercise 1: Route Selection & Event Handling

Problem Statement  
Select the necessary form elements and log their current values when the “Calculate Fare” button is clicked.

Todo List

- [ ] Use `querySelector` to grab `#route-select`, `#discount-select`, `#luggage-addon`, and `#calc-btn`.
- [ ] Add a `click` listener to `#calc-btn`.
- [ ] Inside the handler, `console.log` the values of route, discount, and luggage.

Starter Code (`script.js`)

```js
// TODO: Select elements

// TODO: Add click event listener
// calcBtn.addEventListener('click', () => {
//   // TODO: log routeSelect.value, discountSelect.value, luggageCheckbox.checked
// });
```

Full Solution

```js
const routeSelect = document.querySelector("#route-select");
const discountSelect = document.querySelector("#discount-select");
const luggageCheckbox = document.querySelector("#luggage-addon");
const calcBtn = document.querySelector("#calc-btn");

calcBtn.addEventListener("click", () => {
  console.log("Route:", routeSelect.value);
  console.log("Discount:", discountSelect.value);
  console.log("Luggage:", luggageCheckbox.checked);
});
```

---

### Exercise 2: Implement `getBaseFare()`

Problem Statement  
Create `getBaseFare(route)` that returns the numeric base fare for each route. If the route is unknown, return 0.

Todo List

- [ ] Define `getBaseFare(route)`.
- [ ] Map `'cubao-pasig'` to 10, `'trinoma-qch'` to 12, `'edsa-ortigas'` to 11.
- [ ] Return correct value or 0.

Starter Code (`fare.js`)

```js
export function getBaseFare(route) {
  // TODO: implement mapping
}
```

Full Solution

```js
export function getBaseFare(route) {
  const fares = {
    "cubao-pasig": 10,
    "trinoma-qch": 12,
    "edsa-ortigas": 11,
  };
  return fares[route] || 0;
}
```

---

### Exercise 3: Build `calculateFare()`

Problem Statement  
Using `getBaseFare()`, implement `calculateFare(route, discount, hasLuggage)` that returns a string with two decimals.

Todo List

- [ ] Call `getBaseFare(route)`.
- [ ] Subtract 2 for `'student'`, 3 for `'senior'`, none otherwise.
- [ ] Add 5 if `hasLuggage` is true.
- [ ] Ensure fare isn’t negative.
- [ ] Return `fare.toFixed(2)`.

Starter Code (`fare.js`)

```js
import { getBaseFare } from "./fare.js";

export function calculateFare(route, discount, hasLuggage) {
  // TODO: compute fare according to rules
}
```

Full Solution

```js
import { getBaseFare } from "./fare.js";

export function calculateFare(route, discount, hasLuggage) {
  let fare = getBaseFare(route);

  if (discount === "student") fare -= 2;
  else if (discount === "senior") fare -= 3;

  if (hasLuggage) fare += 5;

  fare = Math.max(fare, 0);
  return fare.toFixed(2);
}
```

---

### Exercise 4: Display Fare in the DOM

Problem Statement  
Wire up your HTML and functions so that clicking “Calculate Fare” updates `#fare-result`.

Todo List

- [ ] Import `calculateFare` from `fare.js`.
- [ ] In `script.js`, select form elements and `#fare-result`.
- [ ] On button click, read values, call `calculateFare`, and render in the div.

Starter Code (`script.js`)

```js
import { calculateFare } from "./fare.js";

// TODO: select form elements and result div

// TODO: add click listener that:
// - reads routeSelect.value, discountSelect.value, luggage.checked
// - calls calculateFare()
// - updates resultDiv.textContent
```

Full Solution

```js
import { calculateFare } from "./fare.js";

const routeSelect = document.querySelector("#route-select");
const discountSelect = document.querySelector("#discount-select");
const luggageCheckbox = document.querySelector("#luggage-addon");
const calcBtn = document.querySelector("#calc-btn");
const resultDiv = document.querySelector("#fare-result");

calcBtn.addEventListener("click", () => {
  const route = routeSelect.value;
  const discount = discountSelect.value;
  const hasLuggage = luggageCheckbox.checked;

  const fare = calculateFare(route, discount, hasLuggage);
  resultDiv.textContent = `Fare: ₱${fare}`;
});
```

---

## Test Cases

Install Jest:

```bash
npm install --save-dev jest
```

Configure `package.json`:

```json
"scripts": {
  "test": "jest"
},
"jest": {
  "testEnvironment": "node"
}
```

Create `fare.js`:

```js
// fare.js
export function getBaseFare(route) {
  const fares = {
    "cubao-pasig": 10,
    "trinoma-qch": 12,
    "edsa-ortigas": 11,
  };
  return fares[route] || 0;
}

export function calculateFare(route, discount, hasLuggage) {
  let fare = getBaseFare(route);

  if (discount === "student") fare -= 2;
  else if (discount === "senior") fare -= 3;

  if (hasLuggage) fare += 5;

  fare = Math.max(fare, 0);
  return fare.toFixed(2);
}
```

Write tests in `fare.test.js`:

```js
import { getBaseFare, calculateFare } from "./fare.js";

describe("getBaseFare()", () => {
  test("returns correct base fares", () => {
    expect(getBaseFare("cubao-pasig")).toBe(10);
    expect(getBaseFare("trinoma-qch")).toBe(12);
    expect(getBaseFare("edsa-ortigas")).toBe(11);
  });

  test("returns 0 for unknown route", () => {
    expect(getBaseFare("unknown-route")).toBe(0);
  });
});

describe("calculateFare()", () => {
  test("no discount, no luggage", () => {
    expect(calculateFare("cubao-pasig", "none", false)).toBe("10.00");
  });

  test("student discount only", () => {
    expect(calculateFare("cubao-pasig", "student", false)).toBe("8.00");
  });

  test("senior discount & luggage", () => {
    // base 11, minus 3 + 5 = 13
    expect(calculateFare("edsa-ortigas", "senior", true)).toBe("13.00");
  });

  test("fare never negative", () => {
    // base 10 - student 2 - senior 3 = 5, but if we apply wrong discount
    expect(calculateFare("trinoma-qch", "senior", false)).toBe("9.00");
  });

  test("luggage only", () => {
    expect(calculateFare("trinoma-qch", "none", true)).toBe("17.00");
  });
});
```

Run tests:

```bash
npm test
```

---

## Closing Story

As jeepney drivers in Cubao shared Odessa’s Calculator link on Facebook groups, commuters cheered at finally having a transparent fare tool. Paula celebrated by buying taho for the entire barrio—no more “driver’s mood” disputes! But Odessa knows this is only JeepFareCalc v2. Next, she’s planning real‐time route mapping, GPS distance calculations, and backend integration so fares adjust dynamically by traffic and weather. The wheels of innovation keep turning—just like Metro Manila’s jeepneys. 🚍💡
