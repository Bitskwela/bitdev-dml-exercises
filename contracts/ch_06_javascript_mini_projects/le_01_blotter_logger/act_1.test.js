const { validateSolution } = require("../../ch_05_javascript/test-helper.js");
const path = require("path");

describe("Le 01: Blotter Logger", () => {
  const codePath = path.join(__dirname, "act_1.answer.js");

  test("validateInputs should return false if any field is missing", () => {
    validateSolution(codePath, (context) => {
      const { validateInputs } = context.global;
      expect(validateInputs("", "issue", "location")).toBe(false);
      expect(validateInputs("name", "", "location")).toBe(false);
      expect(validateInputs("name", "issue", "")).toBe(false);
      expect(validateInputs("name", "issue", "location")).toBe(true);
    });
  });

  test("handleSubmit should add a log entry to blotterLogs", () => {
    validateSolution(codePath, (context) => {
      const {
        handleSubmit,
        blotterLogs,
        nameInput,
        issueInput,
        locationInput,
      } = context.global;

      nameInput.value = "Juan Dela Cruz";
      issueInput.value = "Noise Complaint";
      locationInput.value = "Brgy. 123";

      const mockEvent = { preventDefault: jest.fn() };
      handleSubmit(mockEvent);

      expect(mockEvent.preventDefault).toHaveBeenCalled();
      expect(blotterLogs.length).toBe(1);
      expect(blotterLogs[0]).toEqual({
        name: "Juan Dela Cruz",
        issue: "Noise Complaint",
        location: "Brgy. 123",
      });

      // Inputs should be cleared
      expect(nameInput.value).toBe("");
      expect(issueInput.value).toBe("");
      expect(locationInput.value).toBe("");
    });
  });

  test("renderBlotter should update logsContainer innerHTML", () => {
    validateSolution(codePath, (context) => {
      const { renderBlotter, blotterLogs, logsContainer } = context.global;

      blotterLogs.push({ name: "Maria", issue: "Lost Dog", location: "Park" });
      renderBlotter();

      expect(logsContainer.innerHTML).toContain("Maria @ Park");
      expect(logsContainer.innerHTML).toContain("Lost Dog");
    });
  });
});
