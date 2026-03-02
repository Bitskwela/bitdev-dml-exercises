const { validateSolution } = require("../../ch_05_javascript/test-helper.js");
const path = require("path");

// Mocking localStorage for use in VM context
global.localStorage = {
  getItem: jest.fn(),
  setItem: jest.fn(),
  removeItem: jest.fn(),
  clear: jest.fn(),
};

describe("Le 03: Typhoon Relief Tracker", () => {
  const codePath = path.join(__dirname, "act_1.answer.js");

  test("loadReliefData from localStorage", () => {
    validateSolution(codePath, (context) => {
      const { loadReliefData, localStorage } = context;
      const mockedData = { Rice: 50 };
      localStorage.getItem.mockReturnValueOnce(JSON.stringify(mockedData));

      const data = loadReliefData();
      expect(data).toEqual(mockedData);
      expect(localStorage.getItem).toHaveBeenCalledWith("reliefData");
    });
  });

  test("updateReliefItem should add to counts and save to localStorage", () => {
    validateSolution(codePath, (context) => {
      const { updateReliefItem, localStorage } = context;
      const initial = { Water: 10 };
      const updated = updateReliefItem(initial, "Water", 5);

      expect(updated.Water).toBe(15);
      expect(localStorage.setItem).toHaveBeenCalledWith(
        "reliefData",
        JSON.stringify(updated),
      );
    });
  });

  test("resetReliefData clears localStorage and returns an empty object", () => {
    validateSolution(codePath, (context) => {
      const { resetReliefData, localStorage } = context;
      const data = resetReliefData();
      expect(data).toEqual({});
      expect(localStorage.removeItem).toHaveBeenCalledWith("reliefData");
    });
  });

  test("renderTable updates the table body", () => {
    validateSolution(codePath, (context) => {
      const { renderTable, document } = context;
      const tableBody = { innerHTML: "" };
      document.querySelector.mockReturnValue(tableBody);

      const data = { Rice: 200, Canned: 150 };
      renderTable(data);

      expect(tableBody.innerHTML).toContain("Rice");
      expect(tableBody.innerHTML).toContain("200");
      expect(tableBody.innerHTML).toContain("Canned");
      expect(tableBody.innerHTML).toContain("150");
    });
  });
});
