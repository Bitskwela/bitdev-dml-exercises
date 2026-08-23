/**
 * Hidden test for le_08_the_suggestion_box.
 *
 * `fire` returns false when a handler called `preventDefault`, which is how the
 * "stop the page reloading" task is proved rather than assumed. Validation is
 * driven through real `input` events so a handler that only runs on submit
 * fails.
 */

describe("le_08_the_suggestion_box", () => {
  it("intercepts the form submit instead of letting the page reload", () => {
    Submission.setupFormSubmit();

    const allowed = fire("#userForm", "submit");
    expect(allowed, "default action allowed").false(
      "the submit handler must call event.preventDefault()",
    );
  });

  it("reads the current value out of an input by id", () => {
    el("#nameInput").value = "Odessa";
    expect(Submission.getInputValue("nameInput"), "input value").equal(
      "Odessa",
    );
  });

  it("shows an error only while the email is invalid", () => {
    const input = el("#emailInput");
    const error = el("#errorMessage");
    Submission.setupValidation();

    input.value = "not-an-email";
    fire("#emailInput", "input");
    expect(error.innerText, "error for invalid email").equal(
      "Please enter a valid email",
    );

    input.value = "neri@bitskwela.ph";
    fire("#emailInput", "input");
    expect(error.innerText, "error after a valid email").equal(
      "",
      "the message must clear once the email becomes valid",
    );
  });
});
