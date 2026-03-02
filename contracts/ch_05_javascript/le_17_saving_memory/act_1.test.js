const { validateSolution } = require("../test-helper.js");
const path = require("path");
const codePath = path.join(__dirname, "act_1.answer.js");

describe("Lesson 17: Saving Memory", () => {
  beforeAll(() => {
    global.localStorage = {
      getItem: jest.fn(),
      setItem: jest.fn(),
      removeItem: jest.fn(),
      clear: jest.fn(),
    };
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  test("saveTheme/loadTheme should persist and restore string values from localStorage", () => {
    validateSolution(codePath, (context) => {
      const { saveTheme, loadTheme } = context;
      saveTheme("dark");
      expect(global.localStorage.setItem).toHaveBeenCalledWith(
        "app-theme",
        "dark",
      );

      global.localStorage.getItem.mockReturnValue("light");
      expect(loadTheme()).toBe("light");

      global.localStorage.getItem.mockReturnValue(null);
      expect(loadTheme()).toBe("light"); // default
    });
  });

  test("saveScores/loadScores should handle arrays and JSON strings", () => {
    validateSolution(codePath, (context) => {
      const { saveScores, loadScores } = context;
      const scores = [100, 95, 80];
      saveScores(scores);
      expect(global.localStorage.setItem).toHaveBeenCalledWith(
        "app-scores",
        JSON.stringify(scores),
      );

      global.localStorage.getItem.mockReturnValue(JSON.stringify(scores));
      expect(loadScores()).toEqual(scores);

      global.localStorage.getItem.mockReturnValue(null);
      expect(loadScores()).toEqual([]);
    });
  });

  test("clearUserData should remove key from localStorage", () => {
    validateSolution(codePath, (context) => {
      const { clearUserData } = context;
      global.localStorage.getItem.mockReturnValue("exists");
      const result = clearUserData("token");
      expect(result).toBe(true);
      expect(global.localStorage.removeItem).toHaveBeenCalledWith("token");

      global.localStorage.getItem.mockReturnValue(null);
      const result2 = clearUserData("token");
      expect(result2).toBe(false);
    });
  });
});
