// Task 1: Handle Form Submission
function setupFormSubmit() {
  const form = document.querySelector("#userForm");

  form.addEventListener("submit", function (event) {
    event.preventDefault();
    alert("Form submitted successfully!");
  });
}

// Task 2: Get Input Value
function getInputValue(inputId) {
  const inputElement = document.querySelector(`#${inputId}`);
  return inputElement.value;
}

// Task 3: Real-time Input Validation
function setupValidation() {
  const emailInput = document.querySelector("#emailInput");
  const errorMessage = document.querySelector("#errorMessage");

  emailInput.addEventListener("input", function () {
    const email = emailInput.value;

    if (!email.includes("@")) {
      errorMessage.innerText = "Please enter a valid email";
    } else {
      errorMessage.innerText = "";
    }
  });
}
