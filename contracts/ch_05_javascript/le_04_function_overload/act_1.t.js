/**
 * Hidden test for le_04_function_overload.
 *
 * The lesson is about defaults and the ternary, so the cases that matter are
 * the ones where an argument is missing or falsy — that is where a naive
 * implementation diverges from the intended one.
 */

describe("le_04_function_overload", () => {
  it("greets by name, and falls back when none is given", () => {
    expect(Submission.welcomeStudent("Maria"), "named").equal(
      "Welcome, Maria!",
    );
    expect(Submission.welcomeStudent(), "no argument").equal(
      "Welcome, Student!",
    );
    expect(Submission.welcomeStudent(""), "empty name").equal(
      "Welcome, Student!",
      "an empty name is not a name — it should take the fallback",
    );
  });

  it("defaults the quantity to one when it is missing", () => {
    expect(Submission.calculateTotal(50, 3), "explicit quantity").equal(150);
    expect(Submission.calculateTotal(50), "omitted quantity").equal(
      50,
      "a missing quantity should behave as 1",
    );
  });

  it("passes at exactly the passing mark", () => {
    expect(Submission.checkGrade(90), "well above").equal("Passed");
    expect(Submission.checkGrade(75), "exactly 75").equal(
      "Passed",
      "75 is a pass — the boundary is >= 75, not > 75",
    );
    expect(Submission.checkGrade(74), "just below").equal("Failed");
  });
});
