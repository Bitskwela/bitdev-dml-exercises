/**
 * Hidden test for le_06_objects_in_the_mirror.
 *
 * Objects are judged on what comes back out. `createProfile` is checked with
 * `eql` (structural) rather than `equal` (identity), because building a new
 * object is exactly the task.
 */

describe("le_06_objects_in_the_mirror", () => {
  it("summarises a student from its properties", () => {
    const summary = Submission.getStudentSummary({
      name: "Ana",
      age: 19,
      course: "IT",
      year: 2,
    });
    expect(summary, "summary").equal(
      "Ana is 19 years old, studying IT in year 2.",
    );
  });

  it("zips keys and values into a profile object", () => {
    expect(
      Submission.createProfile(["name", "city"], ["Ben", "Cebu"]),
      "profile",
    ).eql({ name: "Ben", city: "Cebu" });

    expect(Submission.createProfile([], []), "no keys").eql(
      {},
      "no keys should build an empty object, not undefined",
    );
  });

  it("reaches a value nested two levels deep", () => {
    expect(
      Submission.getTeacherEmail({
        subject: "Math",
        teacher: { name: "Cruz", email: "cruz@school.ph" },
      }),
      "email",
    ).equal("cruz@school.ph");
  });
});
