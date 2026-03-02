const { validateSolution } = require("../test-helper.js");
const path = require("path");
const codePath = path.join(__dirname, "act_1.answer.js");

describe("Lesson 09: Debugging the Future", () => {
  test("parseJSONSafely should return parsed JSON or null on error", () => {
    validateSolution(codePath, (context) => {
      const { parseJSONSafely, console } = context;
      const validJSON = '{"name": "test"}';
      const invalidJSON = "{name: test}";

      expect(parseJSONSafely(validJSON)).toEqual({ name: "test" });
      expect(parseJSONSafely(invalidJSON)).toBeNull();
      expect(console.error).toHaveBeenCalled();
    });
  });

  test("safeDivide should return division result or null if divisor is zero", () => {
    validateSolution(codePath, (context) => {
      const { safeDivide, console } = context;
      expect(safeDivide(10, 2)).toBe(5);
      expect(safeDivide(10, 0)).toBeNull();
      expect(console.error).toHaveBeenCalledWith(
        "Division error:",
        "Cannot divide by zero",
      );
    });
  });

  test("fetchUserData should return success false object on simulated network failure", () => {
    validateSolution(codePath, (context) => {
      const { fetchUserData, console } = context;
      const result = fetchUserData();
      expect(result).toEqual({
        success: false,
        error: "Network connection failed",
      });
      expect(console.error).toHaveBeenCalledWith(
        "Failed to fetch user data:",
        "Network connection failed",
      );
    });
  });
});
