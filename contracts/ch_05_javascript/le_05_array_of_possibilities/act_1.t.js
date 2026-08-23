/**
 * Hidden test for le_05_array_of_possibilities.
 *
 * Array work is judged on the values returned. `getEvenNumbers` must return a
 * new array rather than mutate its input, which is the mistake this lesson's
 * `push`-into-a-new-array shape is teaching against.
 */

describe("le_05_array_of_possibilities", () => {
  it("finds the highest score wherever it sits", () => {
    expect(Submission.findHighestScore([10, 90, 40]), "middle").equal(90);
    expect(Submission.findHighestScore([90, 10, 40]), "first").equal(90);
    expect(Submission.findHighestScore([10, 40, 90]), "last").equal(90);
    expect(Submission.findHighestScore([42]), "single element").equal(42);
    expect(Submission.findHighestScore([-9, -3, -7]), "all negative").equal(-3);
  });

  it("keeps only the even numbers, without touching the original array", () => {
    const input = [1, 2, 3, 4, 5, 6];
    expect(Submission.getEvenNumbers(input), "evens").eql([2, 4, 6]);
    expect(input, "input array").eql(
      [1, 2, 3, 4, 5, 6],
      "the original array must not be modified",
    );

    expect(Submission.getEvenNumbers([1, 3, 5]), "no evens").eql([]);
    expect(Submission.getEvenNumbers([0]), "zero is even").eql([0]);
  });

  it("averages a list of grades", () => {
    expect(Submission.calculateAverage([80, 90, 100]), "whole average").equal(
      90,
    );
    expect(Submission.calculateAverage([75]), "single grade").equal(75);
    expect(Submission.calculateAverage([1, 2]), "fractional average").equal(1.5);
  });
});
