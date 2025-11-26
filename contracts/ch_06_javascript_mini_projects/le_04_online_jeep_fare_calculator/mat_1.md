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


## Closing Story

As jeepney drivers in Cubao shared Odessa’s Calculator link on Facebook groups, commuters cheered at finally having a transparent fare tool. Paula celebrated by buying taho for the entire barrio—no more “driver’s mood” disputes! But Odessa knows this is only JeepFareCalc v2. Next, she’s planning real‐time route mapping, GPS distance calculations, and backend integration so fares adjust dynamically by traffic and weather. The wheels of innovation keep turning—just like Metro Manila’s jeepneys. 🚍💡
