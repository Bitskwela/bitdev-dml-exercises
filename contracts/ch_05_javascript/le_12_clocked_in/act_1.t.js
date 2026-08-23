/**
 * Hidden test for le_12_clocked_in.
 *
 * The harness clock is frozen at 2026-01-01T00:00:00Z, which is what makes a
 * date lesson gradable at all — "tomorrow" has one right answer here, where
 * against a real clock it would differ on every run.
 *
 * `formatDatePH` is given explicit dates rather than the frozen "now", so the
 * padding and month-name rules are exercised rather than assumed.
 */

describe("le_12_clocked_in", () => {
  it("formats tomorrow as an ISO-style date", () => {
    expect(Submission.getTomorrowDate(), "tomorrow").equal(
      "2026-01-02",
      "the clock is frozen at 2026-01-01, so tomorrow is 2026-01-02",
    );
  });

  it("measures the hours between two dates, signed", () => {
    expect(
      Submission.getHoursDifference(
        "2026-03-01T08:00:00Z",
        "2026-03-01T17:00:00Z",
      ),
      "a nine-hour shift",
    ).equal(9);

    expect(
      Submission.getHoursDifference(
        "2026-03-01T00:00:00Z",
        "2026-03-02T00:00:00Z",
      ),
      "a full day",
    ).equal(24);

    expect(
      Submission.getHoursDifference(
        "2026-03-01T17:00:00Z",
        "2026-03-01T08:00:00Z",
      ),
      "end before start",
    ).equal(-9, "a backwards range is negative, not absolute");
  });

  it("formats a date the Philippine way, zero-padding the day", () => {
    expect(
      Submission.formatDatePH(new Date("2026-03-09T12:00:00Z")),
      "single-digit day",
    ).equal("09 Mar 2026", "days below ten are padded to two digits");

    expect(
      Submission.formatDatePH(new Date("2026-12-25T12:00:00Z")),
      "two-digit day",
    ).equal("25 Dec 2026");
  });
});
