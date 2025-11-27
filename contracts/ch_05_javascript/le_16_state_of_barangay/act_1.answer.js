// stateManager.js
const state = {
  currentScreen: "home",
  draft: "",
  items: [],
};

function getState(key) {
  return state[key];
}

function setState(key, value) {
  state[key] = value;
}

function saveState() {
  localStorage.setItem("appState", JSON.stringify(state));
}

function loadState() {
  const json = localStorage.getItem("appState");
  if (json) {
    Object.assign(state, JSON.parse(json));
  }
}

// app.js
function showScreen(name) {
  setState("currentScreen", name);
  saveState();

  const sections = document.querySelectorAll("section");
  sections.forEach((section) => {
    if (section.id === name) {
      section.style.display = "block";
    } else {
      section.style.display = "none";
    }
  });
}

function setupDraftPersistence() {
  const draftTextarea = document.querySelector("#draft");

  // Load saved draft
  draftTextarea.value = getState("draft");

  // Save draft on input
  draftTextarea.addEventListener("input", function (event) {
    setState("draft", event.target.value);
    saveState();
  });
}

// Initialize app
document.addEventListener("DOMContentLoaded", function () {
  loadState();
  showScreen(getState("currentScreen"));
  setupDraftPersistence();
});
