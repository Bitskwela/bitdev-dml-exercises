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
