// Task 1: Select and Update Text Content
function updateWelcomeMessage(username) {
  const welcomeElement = document.querySelector("#welcome");
  welcomeElement.innerText = `Welcome, ${username}!`;
}

// Task 2: Add Click Event Listener
function setupClickHandler() {
  const alertBtn = document.querySelector("#alertBtn");
  const statusElement = document.querySelector("#status");

  alertBtn.addEventListener("click", function () {
    statusElement.innerText = "Button was clicked!";
  });
}

// Task 3: Toggle Element Visibility
function setupToggle() {
  const toggleBtn = document.querySelector("#toggleBtn");
  const contentElement = document.querySelector("#content");

  toggleBtn.addEventListener("click", function () {
    if (contentElement.style.display === "none") {
      contentElement.style.display = "block";
    } else {
      contentElement.style.display = "none";
    }
  });
}
