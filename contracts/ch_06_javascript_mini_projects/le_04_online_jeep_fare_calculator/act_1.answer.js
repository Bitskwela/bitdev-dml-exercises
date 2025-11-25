// Task 1: Get Base Fare by Route
function getBaseFare(route) {
  const fares = {
    "cubao-pasig": 10,
    "trinoma-qch": 12,
    "edsa-ortigas": 11,
  };

  return fares[route] || 0;
}

// Task 2: Calculate Final Fare
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

// Task 3: Wire Up the Calculator
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
