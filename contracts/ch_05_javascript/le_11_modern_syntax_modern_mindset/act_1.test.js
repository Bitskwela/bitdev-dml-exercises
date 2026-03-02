const { validateSolution } = require("../test-helper.js");
const path = require("path");
const codePath = path.join(__dirname, "act_1.answer.js");

describe("Lesson 11: Modern Syntax Modern Mindset", () => {
  test("calculateArea should return area of rectangle", () => {
    validateSolution(codePath, (context) => {
      const { calculateArea } = context;
      expect(calculateArea(5, 10)).toBe(50);
    });
  });

  test('greetUser should return "Hello, User!"', () => {
    validateSolution(codePath, (context) => {
      const { greetUser } = context;
      expect(greetUser("User")).toBe("Hello, User!");
    });
  });

  test("getUserInfo should use destructuring to build info string", () => {
    validateSolution(codePath, (context) => {
      const { getUserInfo } = context;
      const user = { name: "Juan", age: 25, course: "Engineering" };
      expect(getUserInfo(user)).toBe(
        "Juan is 25 years old and studying Engineering.",
      );
    });
  });

  test("formatScores should extract array elements and return formatted string", () => {
    validateSolution(codePath, (context) => {
      const { formatScores } = context;
      const scores = [90, 85, 95];
      expect(formatScores(scores)).toBe("Math: 90, English: 85, Science: 95");
    });
  });
});
