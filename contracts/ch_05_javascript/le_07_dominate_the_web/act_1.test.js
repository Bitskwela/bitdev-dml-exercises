const { validateSolution } = require("../test-helper.js");
const path = require("path");
const codePath = path.join(__dirname, "act_1.answer.js");

describe("Lesson 07: Dominate the Web", () => {
  test("updateWelcomeMessage should select and update innerText of #welcome", () => {
    validateSolution(codePath, (context) => {
      const { updateWelcomeMessage, document } = context;
      const mockElement = { innerText: "" };
      document.querySelector.mockReturnValue(mockElement);
      updateWelcomeMessage("User");
      expect(document.querySelector).toHaveBeenCalledWith("#welcome");
      expect(mockElement.innerText).toBe("Welcome, User!");
    });
  });

  test("setupClickHandler should add a click listener to #alertBtn that updates #status", () => {
    validateSolution(codePath, (context) => {
      const { setupClickHandler, document } = context;
      const mockBtn = { addEventListener: jest.fn() };
      const statusElement = { innerText: "" };
      document.querySelector.mockImplementation((selector) => {
        if (selector === "#alertBtn") return mockBtn;
        if (selector === "#status") return statusElement;
        return null;
      });
      setupClickHandler();
      expect(mockBtn.addEventListener).toHaveBeenCalledWith(
        "click",
        expect.any(Function),
      );
      const clickCallback = mockBtn.addEventListener.mock.calls[0][1];
      clickCallback();
      expect(statusElement.innerText).toBe("Button was clicked!");
    });
  });

  test("setupToggle should toggle #content visibility on click of #toggleBtn", () => {
    validateSolution(codePath, (context) => {
      const { setupToggle, document } = context;
      const toggleBtn = { addEventListener: jest.fn() };
      const content = { style: { display: "none" } };
      document.querySelector.mockImplementation((selector) => {
        if (selector === "#toggleBtn") return toggleBtn;
        if (selector === "#content") return content;
        return null;
      });
      setupToggle();
      const toggleCallback = toggleBtn.addEventListener.mock.calls[0][1];
      toggleCallback();
      expect(content.style.display).toBe("block");
      toggleCallback();
      expect(content.style.display).toBe("none");
    });
  });
});
