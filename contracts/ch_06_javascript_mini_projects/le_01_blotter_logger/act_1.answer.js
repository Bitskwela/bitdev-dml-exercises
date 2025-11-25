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
