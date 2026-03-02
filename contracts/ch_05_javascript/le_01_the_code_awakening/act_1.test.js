const path = require("path");
const { validateSolution } = require("../test-helper");

describe("le_01_the_code_awakening", () => {
  const filePath = path.join(__dirname, "act_1.answer.js");

  test("should define the correct variables", () => {
    validateSolution(filePath, (context) => {
      expect(context.name).toBe("Odessa");
      expect(context.age).toBe(20);
      expect(typeof context.isStudent).toBe("boolean");
    });
  });

  test("should construct the correct template literal message", () => {
    validateSolution(filePath, (context) => {
      expect(context.message).toContain("Odessa");
      expect(context.message).toContain("20");
      expect(context.message).toContain("Hi, I'm Odessa");
    });
  });

  test("should calculate the correct birth year", () => {
    validateSolution(filePath, (context) => {
      expect(context.currentYear).toBe(2025);
      expect(context.birthYear).toBe(2005);
    });
  });
});
