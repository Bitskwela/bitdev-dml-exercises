const { validateSolution } = require("../test-helper.js");
const path = require("path");
const codePath = path.join(__dirname, "act_1.answer.js");

describe("Lesson 04: Function Overload", () => {
  test("welcomeStudent should return a personalized or generic message", () => {
    validateSolution(codePath, (context) => {
      const { welcomeStudent } = context;
      expect(welcomeStudent("Juan")).toBe("Welcome, Juan!");
      expect(welcomeStudent()).toBe("Welcome, Student!");
      expect(welcomeStudent("")).toBe("Welcome, Student!");
    });
  });

  test("calculateTotal should return total price with quantity default to 1", () => {
    validateSolution(codePath, (context) => {
      const { calculateTotal } = context;
      expect(calculateTotal(100, 5)).toBe(500);
      expect(calculateTotal(100)).toBe(100);
      expect(calculateTotal(50, 0)).toBe(50); // Since !0 is true in the answer key, it defaults to 1
    });
  });

  test('checkGrade should return "Passed" if score >= 75 and "Failed" otherwise', () => {
    validateSolution(codePath, (context) => {
      const { checkGrade } = context;
      expect(checkGrade(80)).toBe("Passed");
      expect(checkGrade(75)).toBe("Passed");
      expect(checkGrade(74)).toBe("Failed");
    });
  });
});
