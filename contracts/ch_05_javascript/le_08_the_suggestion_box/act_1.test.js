const { validateSolution } = require("../test-helper.js");
const path = require("path");
const codePath = path.join(__dirname, "act_1.answer.js");

describe("Lesson 08: The Suggestion Box", () => {
  test("setupFormSubmit should prevent default submission and alert user", () => {
    validateSolution(codePath, (context) => {
      const { setupFormSubmit, document } = context;
      const form = { addEventListener: jest.fn() };
      const event = { preventDefault: jest.fn() };
      const alertMock = jest.fn();
      context.alert = alertMock;

      document.querySelector.mockReturnValue(form);
      setupFormSubmit();

      const submitCallback = form.addEventListener.mock.calls[0][1];
      submitCallback(event);
      expect(event.preventDefault).toHaveBeenCalled();
      expect(alertMock).toHaveBeenCalledWith("Form submitted successfully!");
    });
  });

  test("getInputValue should return the value of a target input element", () => {
    validateSolution(codePath, (context) => {
      const { getInputValue, document } = context;
      const input = { value: "test-value" };
      document.querySelector.mockReturnValue(input);
      expect(getInputValue("userName")).toBe("test-value");
      expect(document.querySelector).toHaveBeenCalledWith("#userName");
    });
  });

  test('setupValidation should show error if email does not include "@"', () => {
    validateSolution(codePath, (context) => {
      const { setupValidation, document } = context;
      const emailInput = { value: "invalid", addEventListener: jest.fn() };
      const errorMessage = { innerText: "" };

      document.querySelector.mockImplementation((selector) => {
        if (selector === "#emailInput") return emailInput;
        if (selector === "#errorMessage") return errorMessage;
        return null;
      });
      setupValidation();

      const inputCallback = emailInput.addEventListener.mock.calls[0][1];
      inputCallback();
      expect(errorMessage.innerText).toBe("Please enter a valid email");

      emailInput.value = "valid@test.com";
      inputCallback();
      expect(errorMessage.innerText).toBe("");
    });
  });
});
