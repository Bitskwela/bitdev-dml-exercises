/**
 * Hidden test for le_11_modern_syntax_modern_mindset.
 *
 * Arrow functions, destructuring and template literals are all judged on the
 * value produced. Nothing here inspects the source, so a student who writes a
 * classic `function` still passes — the lesson teaches the idiom, the test
 * checks the behaviour.
 */

describe("le_11_modern_syntax_modern_mindset", () => {
  it("calculates an area", () => {
    expect(Submission.calculateArea(4, 5), "4 x 5").equal(20);
    expect(Submission.calculateArea(0, 9), "zero width").equal(0);
  });

  it("greets a user", () => {
    expect(Submission.greetUser("Rosa"), "greeting").equal("Hello, Rosa!");
  });

  it("destructures a user object into a sentence", () => {
    expect(
      Submission.getUserInfo({ name: "Lito", age: 22, course: "CS" }),
      "user info",
    ).equal("Lito is 22 years old and studying CS.");
  });

  it("destructures an array of scores positionally", () => {
    expect(Submission.formatScores([90, 85, 78]), "scores").equal(
      "Math: 90, English: 85, Science: 78",
    );
  });
});
