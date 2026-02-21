// Task 1: Select and Update Text Content
function updateWelcomeMessage(username) {
  // DOM MANIPULATION: Finding and modifying HTML elements from JavaScript

  // document.querySelector() finds the FIRST element matching the CSS selector
  // "#welcome" means "find element with id='welcome'"
  // CSS selectors: # for IDs, . for classes, just tag name for elements
  const welcomeElement = document.querySelector("#welcome");

  // innerText sets the text content of an element (no HTML tags)
  // This REPLACES whatever text was there before
  welcomeElement.innerText = `Welcome, ${username}!`;

  // ALTERNATIVE PROPERTIES:
  // - textContent: Similar to innerText but includes hidden text
  // - innerHTML: Allows HTML tags (use carefully, can be security risk)
}

// Task 2: Add Click Event Listener
function setupClickHandler() {
  // Select both elements we'll work with
  const alertBtn = document.querySelector("#alertBtn");
  const statusElement = document.querySelector("#status");

  // addEventListener() attaches a function to run when an event occurs
  // First argument: event type ("click", "mouseover", "keypress", etc.)
  // Second argument: callback function to execute when event happens
  alertBtn.addEventListener("click", function () {
    // This function runs ONLY when the button is clicked
    statusElement.innerText = "Button was clicked!";
  });

  // WHY USE addEventListener?
  // - Can attach multiple listeners to same element
  // - More flexible than onclick="..." in HTML
  // - Can remove listeners later with removeEventListener()
}

// Task 3: Toggle Element Visibility
function setupToggle() {
  const toggleBtn = document.querySelector("#toggleBtn");
  const contentElement = document.querySelector("#content");

  toggleBtn.addEventListener("click", function () {
    // TOGGLE PATTERN: Check current state and switch to opposite
    // style.display controls CSS display property

    if (contentElement.style.display === "none") {
      // Currently hidden → show it
      contentElement.style.display = "block";
    } else {
      // Currently visible → hide it
      contentElement.style.display = "none";
    }

    // MODERN ALTERNATIVE: classList.toggle()
    // Add a CSS class .hidden { display: none; }
    // Then: contentElement.classList.toggle("hidden");
    // Automatically adds/removes class based on current state
  });
}
