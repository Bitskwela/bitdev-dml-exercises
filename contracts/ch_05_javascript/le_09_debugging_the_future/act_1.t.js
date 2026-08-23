/**
 * Hidden test for le_09_debugging_the_future.
 *
 * The lesson is about *surviving* failure, so every case here is a failure
 * case: the function must return the fallback rather than throw. That the
 * error is also reported is checked through the captured console, not by
 * reading the source.
 */

describe("le_09_debugging_the_future", () => {
  it("parses valid JSON and returns null on malformed input", () => {
    expect(Submission.parseJSONSafely('{"a":1}'), "valid JSON").eql({ a: 1 });

    const before = logs("error").length;
    expect(Submission.parseJSONSafely("{not json"), "malformed JSON").equal(
      null,
      "a parse failure must return null rather than throw",
    );
    expect(logs("error").length > before, "reported the parse error").true(
      "expected the caught error to be reported via console.error",
    );
  });

  it("divides normally but refuses to divide by zero", () => {
    expect(Submission.safeDivide(10, 2), "normal division").equal(5);

    const before = logs("error").length;
    expect(Submission.safeDivide(10, 0), "divide by zero").equal(
      null,
      "dividing by zero must return null rather than Infinity or a throw",
    );
    expect(logs("error").length > before, "reported the division error").true();
  });

  it("reports a failed fetch as a result object instead of throwing", () => {
    const result = Submission.fetchUserData();
    expect(result && result.success, "success flag").false(
      "a failed fetch should report success: false",
    );
    expect(typeof (result && result.error), "error message").equal(
      "string",
      "the failure reason should come back on the result",
    );
  });
});
