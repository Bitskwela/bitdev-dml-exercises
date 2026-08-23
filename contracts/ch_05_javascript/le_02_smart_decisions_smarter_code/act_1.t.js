/**
 * Hidden test for le_02_smart_decisions_smarter_code.
 *
 * The lesson is three pure functions, so the test calls them across their
 * decision boundaries rather than reading the source. `spec.json` names them in
 * `exports`, which is what puts them on `Submission`.
 *
 * Boundaries are the point of the lesson (`>` vs `>=`, `&&` vs `||`), so every
 * case below sits on one: 4999/5000/5001 for the budget, 0 and the exact limit
 * for validity, and 3000 exactly for the event split.
 */

describe("le_02_smart_decisions_smarter_code", () => {
  it("classifies a budget on both sides of the limit and exactly on it", () => {
    const check = Submission.checkBudgetStatus;
    expect(typeof check, "checkBudgetStatus").equal("function");

    expect(check(5001), "above the limit").equal("Over budget");
    expect(check(5000), "exactly the limit").equal("At limit");
    expect(check(4999), "below the limit").equal("Under budget");
  });

  it("accepts only positive entries up to the limit", () => {
    const valid = Submission.isValidEntry;
    expect(typeof valid, "isValidEntry").equal("function");

    expect(valid(1), "smallest positive").true();
    expect(valid(5000), "exactly the limit").true();
    expect(valid(0), "zero").false();
    expect(valid(-1), "negative").false();
    expect(valid(5001), "above the limit").false();
  });

  it("splits event expenses at 3000 and groups the operational ones", () => {
    const classify = Submission.classifyExpense;
    expect(typeof classify, "classifyExpense").equal("function");

    expect(classify(3001, "event"), "big event").equal("High event expense");
    expect(classify(3000, "event"), "event exactly at 3000").equal(
      "Normal event expense",
    );
    expect(classify(10, "supplies"), "supplies").equal("Operational expense");
    expect(classify(10, "food"), "food").equal("Operational expense");
    expect(classify(10, "transport"), "unknown category").equal(
      "Uncategorized expense",
    );
  });
});
