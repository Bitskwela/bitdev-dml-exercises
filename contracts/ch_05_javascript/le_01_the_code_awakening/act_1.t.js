/**
 * Hidden test for le_01_the_code_awakening.
 *
 * A plain-script lesson has no component to mount and no export to inspect, so
 * it is graded on what it printed — `logs()` is the submission's observable
 * behaviour. Nothing here reads the source, so a student who reaches the right
 * output by a different route still passes.
 *
 * The lesson lets the student pick their own name and age, so the assertions
 * are on the *relationships* the tasks specify (the message quotes the name and
 * age; the birth year is the arithmetic of the other two), never on one
 * hard-coded identity.
 */

describe("le_01_the_code_awakening", () => {
  /** Every line the submission printed, joined for whole-output matching. */
  const output = () => logs().join("\n");

  /** The first number the submission printed that could be an age. */
  const printedAge = () => {
    for (const line of logs()) {
      const value = Number(line.trim());
      if (Number.isInteger(value) && value > 0 && value < 150) return value;
    }
    return undefined;
  };

  it("prints the three personal details", () => {
    const lines = logs();
    expect(lines.length >= 3, "console.log count").true(
      `expected at least 3 printed lines from Task 1, got ${lines.length}`,
    );
    expect(printedAge() !== undefined, "printed age").true(
      "expected one line to print the age as a number",
    );
    expect(output(), "output").match(
      /\b(true|false)\b/,
      "expected the boolean isStudent value to be printed",
    );
  });

  it("builds the template-literal message with the name and age in it", () => {
    const message = logs().find((line) => line.includes("I am a student."));
    expect(message !== undefined, "message line").true(
      'expected a line matching "Hi, I\'m ..., I am ... years old, and it is ... that I am a student."',
    );
    expect(message, "message").match(
      /^Hi, I'm .+, I am \d+ years old, and it is (true|false) that I am a student\.$/,
    );

    // The message must quote the same age Task 1 printed, not a second literal.
    const age = printedAge();
    expect(message, "message").contain(
      String(age),
      `expected the message to use the age ${age} printed in Task 1`,
    );
  });

  it("reports a birth year consistent with the age it printed", () => {
    const birthLine = logs().find((line) => /born in \d{4}/.test(line));
    expect(birthLine !== undefined, "birth year line").true(
      'expected a line reporting the birth year, e.g. "I was born in 2005"',
    );

    const birthYear = Number(birthLine.match(/born in (\d{4})/)[1]);
    const age = printedAge();
    expect(birthYear, "birthYear").equal(
      2025 - age,
      `expected 2025 - ${age} = ${2025 - age}, but the submission printed ${birthYear}`,
    );
  });
});
