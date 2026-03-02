const { validateSolution } = require("../test-helper.js");
const path = require("path");
const codePath = path.join(__dirname, "act_1.answer.js");

describe("Lesson 06: Objects in the Mirror", () => {
  test("getStudentSummary should return personal student details formatted string", () => {
    validateSolution(codePath, (context) => {
      const { getStudentSummary } = context;
      const student = { name: "Juan", age: 20, course: "BSIT", year: 2 };
      expect(getStudentSummary(student)).toBe(
        "Juan is 20 years old, studying BSIT in year 2.",
      );
    });
  });

  test("createProfile should dynamically build an object from key-value arrays", () => {
    validateSolution(codePath, (context) => {
      const { createProfile } = context;
      const keys = ["name", "age", "role"];
      const values = ["Odessa", 22, "Moderator"];
      expect(createProfile(keys, values)).toEqual({
        name: "Odessa",
        age: 22,
        role: "Moderator",
      });
    });
  });

  test("getTeacherEmail should access nested email property", () => {
    validateSolution(codePath, (context) => {
      const { getTeacherEmail } = context;
      const classInfo = { teacher: { email: "teacher@school.ph" } };
      expect(getTeacherEmail(classInfo)).toBe("teacher@school.ph");
    });
  });
});
