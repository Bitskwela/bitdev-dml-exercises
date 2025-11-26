# Answer Keys for Chapter 6: JavaScript mini-projects

## Lesson 1: Blotter Logger

```javascript
const form = document.querySelector("#blotter-form");
const nameInput = document.querySelector("#name");
const issueInput = document.querySelector("#issue");
const locationInput = document.querySelector("#location");
const logsContainer = document.querySelector("#blotter-logs");

const blotterLogs = [];

// Task 3: Add Validation
function validateInputs(name, issue, location) {
  if (!name || !issue || !location) {
    alert("Please fill in all fields!");
    return false;
  }
  return true;
}

// Task 2: Render Blotter Entries
function renderBlotter() {
  const htmlArray = blotterLogs.map(function (entry) {
    return `
      <div class="log-entry">
        <h4>${entry.name} @ ${entry.location}</h4>
        <p>${entry.issue}</p>
      </div>
    `;
  });

  logsContainer.innerHTML = htmlArray.join("");
}

// Task 1: Capture Form Data
function handleSubmit(event) {
  event.preventDefault();

  const name = nameInput.value.trim();
  const issue = issueInput.value.trim();
  const location = locationInput.value.trim();

  if (!validateInputs(name, issue, location)) {
    return;
  }

  blotterLogs.push({ name, issue, location });

  nameInput.value = "";
  issueInput.value = "";
  locationInput.value = "";

  renderBlotter();
}

form.addEventListener("submit", handleSubmit);
```

## Lesson 2: Sari-Sari POS Calculator

```javascript
// Task 1: Create the Item Class
class Item {
  constructor(name, price) {
    this.name = name;
    this.price = price;
  }

  toHTML() {
    return `<li>${this.name} — ₱${this.price.toFixed(2)}</li>`;
  }
}

// Task 2: Create the Cart Class
class Cart {
  constructor() {
    this.items = [];
  }

  addItem(item) {
    this.items.push(item);
  }

  clearCart() {
    this.items = [];
  }

  getTotal() {
    return this.items.reduce(function (sum, item) {
      return sum + item.price;
    }, 0);
  }

  render(listEl, totalEl) {
    const html = this.items
      .map(function (item) {
        return item.toHTML();
      })
      .join("");

    listEl.innerHTML = html;
    totalEl.textContent = this.getTotal().toFixed(2);
  }
}

// Task 3: Wire Up the Form
function setupPOS() {
  const form = document.querySelector("#pos-form");
  const nameInput = document.querySelector("#item-name");
  const priceInput = document.querySelector("#item-price");
  const clearBtn = document.querySelector("#clear-cart");
  const cartList = document.querySelector("#cart-list");
  const cartTotal = document.querySelector("#cart-total");

  const cart = new Cart();

  form.addEventListener("submit", function (e) {
    e.preventDefault();

    const name = nameInput.value.trim();
    const price = parseFloat(priceInput.value);

    if (!name || isNaN(price) || price < 0) {
      alert("Enter valid name and price.");
      return;
    }

    const item = new Item(name, price);
    cart.addItem(item);
    cart.render(cartList, cartTotal);

    nameInput.value = "";
    priceInput.value = "";
    nameInput.focus();
  });

  clearBtn.addEventListener("click", function () {
    cart.clearCart();
    cart.render(cartList, cartTotal);
  });
}

document.addEventListener("DOMContentLoaded", setupPOS);
```

## Lesson 3: Typhoon Relief Tracker

```javascript
// Task 1: Load and Save Relief Data
function loadReliefData() {
  const raw = localStorage.getItem("reliefData");
  if (raw) {
    return JSON.parse(raw);
  } else {
    return {};
  }
}

function saveReliefData(data) {
  localStorage.setItem("reliefData", JSON.stringify(data));
}

// Task 2: Update Relief Item
function updateReliefItem(data, item, count) {
  const current = data[item] || 0;
  data[item] = current + count;
  saveReliefData(data);
  return data;
}

function resetReliefData() {
  localStorage.removeItem("reliefData");
  return {};
}

// Task 3: Render Relief Table
function renderTable(data) {
  const tableBody = document.querySelector("#relief-table tbody");
  let rows = "";

  for (const [item, count] of Object.entries(data)) {
    rows += `<tr><td>${item}</td><td>${count}</td></tr>`;
  }

  tableBody.innerHTML = rows;
}

// Wire Up Event Listeners
const nameInput = document.querySelector("#item-name");
const countInput = document.querySelector("#item-count");
const addBtn = document.querySelector("#add-btn");
const resetBtn = document.querySelector("#reset-btn");

let reliefData = {};

document.addEventListener("DOMContentLoaded", function () {
  reliefData = loadReliefData();
  renderTable(reliefData);
});

addBtn.addEventListener("click", function () {
  const item = nameInput.value.trim();
  const count = parseInt(countInput.value, 10);

  if (!item || isNaN(count) || count <= 0) {
    alert("Enter valid item and positive count.");
    return;
  }

  reliefData = updateReliefItem(reliefData, item, count);
  renderTable(reliefData);

  nameInput.value = "";
  countInput.value = "";
  nameInput.focus();
});

resetBtn.addEventListener("click", function () {
  reliefData = resetReliefData();
  renderTable(reliefData);
});
```

## Lesson 4: Online Jeep Fare Calculator

```javascript
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
```

## Lesson 5: Barangay Job Matching Portal

```javascript
// Job Data
const jobs = [
  {
    id: 1,
    title: "Transcriptionist",
    description: "Convert audio to text.",
    skills: ["Writing", "Listening", "Typing"],
  },
  {
    id: 2,
    title: "Graphic Designer",
    description: "Design posters and banners.",
    skills: ["Design", "Creativity", "Photoshop"],
  },
  {
    id: 3,
    title: "Data Entry",
    description: "Enter data into spreadsheets.",
    skills: ["Typing", "Admin", "Accuracy"],
  },
  {
    id: 4,
    title: "Social Media Manager",
    description: "Manage FB and IG pages.",
    skills: ["Communication", "Writing", "Creativity"],
  },
  {
    id: 5,
    title: "Virtual Assistant",
    description: "Manage email and schedule.",
    skills: ["Admin", "Organization", "Communication"],
  },
];

// Task 1: Render Job Listings
function renderJobs(jobArray) {
  const jobListEl = document.querySelector("#job-list");

  const html = jobArray
    .map(function (job) {
      return `
      <li>
        <h3>${job.title}</h3>
        <p>${job.description}</p>
        <small>Skills: ${job.skills.join(", ")}</small>
      </li>
    `;
    })
    .join("");

  jobListEl.innerHTML = html;
}

// Task 2: Filter Jobs by Skills and Keyword
function filterJobs(jobs, selectedSkills, keyword) {
  return jobs
    .filter(function (job) {
      return selectedSkills.every(function (skill) {
        return job.skills.includes(skill);
      });
    })
    .filter(function (job) {
      const lowerKeyword = keyword.toLowerCase();
      const inTitle = job.title.toLowerCase().includes(lowerKeyword);
      const inDescription = job.description
        .toLowerCase()
        .includes(lowerKeyword);
      return inTitle || inDescription;
    });
}

// Task 3: Set Up Filters and Search
function setupJobPortal() {
  const filterContainer = document.querySelector("#skill-filters");
  const searchInput = document.querySelector("#search-input");

  // Extract unique skills
  const allSkills = [];
  jobs.forEach(function (job) {
    job.skills.forEach(function (skill) {
      if (!allSkills.includes(skill)) {
        allSkills.push(skill);
      }
    });
  });

  // Create checkboxes
  allSkills.forEach(function (skill) {
    const label = document.createElement("label");
    label.innerHTML = `<input type="checkbox" value="${skill}" /> ${skill}`;
    filterContainer.appendChild(label);
  });

  let activeSkills = [];
  let searchTerm = "";

  function updateRender() {
    const filtered = filterJobs(jobs, activeSkills, searchTerm);
    renderJobs(filtered);
  }

  filterContainer.addEventListener("change", function () {
    const checkboxes = filterContainer.querySelectorAll("input:checked");
    activeSkills = Array.from(checkboxes).map(function (cb) {
      return cb.value;
    });
    updateRender();
  });

  searchInput.addEventListener("input", function () {
    searchTerm = searchInput.value.trim().toLowerCase();
    updateRender();
  });

  // Initial render
  renderJobs(jobs);
}

document.addEventListener("DOMContentLoaded", setupJobPortal);
```
