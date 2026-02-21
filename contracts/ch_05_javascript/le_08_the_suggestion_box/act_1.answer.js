// Task 1: Handle Form Submission
function setupFormSubmit() {
  const form = document.querySelector("#userForm");

  // FORM EVENTS: Forms have a special "submit" event
  // Triggered when user clicks submit button or presses Enter in input
  form.addEventListener("submit", function (event) {
    // event.preventDefault() STOPS the default form behavior
    // Default: form submits to server, page reloads
    // We prevent this to handle submission with JavaScript instead
    event.preventDefault();

    alert("Form submitted successfully!");

    // IN REAL APPS, you'd typically:
    // 1. Get form data: const data = new FormData(form);
    // 2. Validate inputs
    // 3. Send to server: fetch('/api/submit', { method: 'POST', body: data })
    // 4. Show success/error message
  });
}

// Task 2: Get Input Value
function getInputValue(inputId) {
  // Template literal in selector: #${inputId} becomes #username, #email, etc.
  const inputElement = document.querySelector(`#${inputId}`);

  // .value gets the CURRENT content of an input field
  // Works for: <input>, <textarea>, <select>
  return inputElement.value;

  // COMMON GOTCHA:
  // innerText gets displayed text (for divs, spans, etc.)
  // value gets form input content (for input, textarea, select)
  // Using the wrong one is a common mistake!
}

// Task 3: Real-time Input Validation
function setupValidation() {
  const emailInput = document.querySelector("#emailInput");
  const errorMessage = document.querySelector("#errorMessage");

  // "input" event fires EVERY TIME the user types a character
  // Other form events: "change" (fires on blur), "focus", "blur"
  emailInput.addEventListener("input", function () {
    // Get current value from the input field
    const email = emailInput.value;

    // Simple validation: check if email contains "@"
    // This is NOT comprehensive (just for demonstration)
    if (!email.includes("@")) {
      // Show error message if invalid
      errorMessage.innerText = "Please enter a valid email";
    } else {
      // Clear error message if valid (empty string = no text displayed)
      errorMessage.innerText = "";
    }

    // BETTER VALIDATION: Use regex or HTML5 pattern
    // const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    // if (!emailRegex.test(email)) { ... }

    // OR: Use HTML5 validation
    // <input type="email" required pattern="...">
    // Then check: if (!emailInput.validity.valid) { ... }
  });
}
