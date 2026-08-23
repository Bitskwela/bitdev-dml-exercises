/**
 * Hidden test for le_03_loops_of_liberation.
 *
 * Loops are judged by what they produce, not how they are written: a `for`, a
 * `while` and a `reduce` all pass if the values are right. `printNumbers` has no
 * return value, so it is judged on its console output — the only thing it does.
 */

describe("le_03_loops_of_liberation", () => {
  it("prints every number in the range, inclusive of both ends", () => {
    const before = logs().length;
    Submission.printNumbers(3, 6);
    const printed = logs().slice(before);

    expect(printed.length, "printed line count").equal(
      4,
      "expected 3, 4, 5 and 6 — the range is inclusive at both ends",
    );
    expect(printed.join(","), "printed values").equal("3,4,5,6");
  });

  it("prints exactly once when the range is a single number", () => {
    const before = logs().length;
    Submission.printNumbers(7, 7);
    expect(logs().slice(before).join(","), "single-value range").equal("7");
  });

  it("sums an array, including the empty case", () => {
    expect(Submission.sumArray([1, 2, 3, 4]), "sum of 1..4").equal(10);
    expect(Submission.sumArray([5]), "single element").equal(5);
    expect(Submission.sumArray([]), "empty array").equal(
      0,
      "an empty array sums to 0, not undefined",
    );
    expect(Submission.sumArray([-2, 2]), "negatives cancel").equal(0);
  });

  it("builds a square multiplication table", () => {
    expect(Submission.multiplicationTable(3), "3x3 table").eql([
      [1, 2, 3],
      [2, 4, 6],
      [3, 6, 9],
    ]);
    expect(Submission.multiplicationTable(1), "1x1 table").eql([[1]]);
  });
});
