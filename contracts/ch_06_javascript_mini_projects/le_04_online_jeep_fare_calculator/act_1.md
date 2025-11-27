# Jeepney Fare Calculator Activity

## Initial Code

```js
// Task 1: Get Base Fare by Route
function getBaseFare(route) {
  // Add your code here
}

// Task 2: Calculate Final Fare
function calculateFare(route, discount, hasLuggage) {
  // Add your code here
}

// Task 3: Wire Up the Calculator
function setupFareCalculator() {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: Objects as Lookup Tables, Conditional Logic (`if...else`), `Math.max()`, `toFixed()`, `querySelector`, Event Listeners, Checkbox `checked` Property

---

### Task 1: Get Base Fare by Route

Create a function that returns the base fare for a given route. Use an object to map route values to their fares:

- "cubao-pasig" → ₱10
- "trinoma-qch" → ₱12
- "edsa-ortigas" → ₱11

Return 0 for unknown routes.

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

---

### Task 2: Calculate Final Fare

Create a function that calculates the final fare based on route, discount type, and luggage. Apply discounts (student: ₱2 off, senior: ₱3 off) and luggage fee (₱5). Ensure fare is never negative.

```js
function calculateFare(route, discount, hasLuggage) {
  let fare = getBaseFare(route);

  if (discount === "student") {
    fare = fare - 2;
  } else if (discount === "senior") {
    fare = fare - 3;
  }

  if (hasLuggage) {
    fare = fare + 5;
  }

  fare = Math.max(fare, 0);

  return fare.toFixed(2);
}
```

---

### Task 3: Wire Up the Calculator

Create a function that sets up the fare calculator. It should select the form elements, listen for button clicks, read the current values, calculate the fare, and display the result.

```js
function setupFareCalculator() {
  const routeSelect = document.querySelector("#route-select");
  const discountSelect = document.querySelector("#discount-select");
  const luggageCheckbox = document.querySelector("#luggage-addon");
  const calcBtn = document.querySelector("#calc-btn");
  const resultDiv = document.querySelector("#fare-result");

  calcBtn.addEventListener("click", function () {
    const route = routeSelect.value;
    const discount = discountSelect.value;
    const hasLuggage = luggageCheckbox.checked;

    const fare = calculateFare(route, discount, hasLuggage);
    resultDiv.textContent = "Fare: ₱" + fare;
  });
}

document.addEventListener("DOMContentLoaded", setupFareCalculator);
```

---

## Breakdown of the Activity

**Variables Defined:**

- `fares`: An object used as a lookup table mapping route strings to their base fare values.

- `route`: A string representing the selected route (e.g., "cubao-pasig").

- `discount`: A string representing the discount type ("none", "student", or "senior").

- `hasLuggage`: A boolean indicating whether the luggage checkbox is checked.

- `fare`: A number that starts as the base fare and is modified by discounts and add-ons.

- `routeSelect`: Reference to the route dropdown element.

- `discountSelect`: Reference to the discount dropdown element.

- `luggageCheckbox`: Reference to the luggage checkbox input element.

- `resultDiv`: Reference to the div where the calculated fare is displayed.

**Key Concepts:**

- Object as Lookup Table:
  Using an object to map keys to values is cleaner than multiple `if...else` statements. Access values with bracket notation `obj[key]`.

- Fallback with `||`:
  The expression `fares[route] || 0` returns 0 if the route is not found in the object.

- Conditional Logic:
  Using `if...else if` to apply different discounts based on the discount type.

- `Math.max()`:
  Returns the largest of the given numbers. `Math.max(fare, 0)` ensures the fare is never negative.

- `toFixed(2)`:
  Formats a number to exactly 2 decimal places. Returns a string.

- `checkbox.checked`:
  Boolean property of checkbox inputs. Returns `true` if checked, `false` otherwise.

- `select.value`:
  Returns the `value` attribute of the currently selected `<option>` in a dropdown.

**Key Functions:**

- `getBaseFare(route)`:
  Looks up the base fare from an object using the route as a key. Returns 0 for unknown routes.

- `calculateFare(route, discount, hasLuggage)`:
  Computes the final fare by applying discounts and add-ons. Returns a formatted string with 2 decimal places.

- `setupFareCalculator()`:
  Initializes the calculator by selecting DOM elements and setting up the click event handler.
