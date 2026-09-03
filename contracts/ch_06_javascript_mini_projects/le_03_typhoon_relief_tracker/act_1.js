// Task 1: Load and Save Relief Data
function loadReliefData() {
  // Add your code here
}

function saveReliefData(data) {
  // Add your code here
}

// Task 2: Update Relief Item
function updateReliefItem(data, item, count) {
  // Add your code here
}

function resetReliefData() {
  // Add your code here
}

// Task 3: Render Relief Table
function renderTable(data) {
  // Add your code here
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
