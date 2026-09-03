/**
 * Hidden test for le_01_blotter_logger.
 *
 * The three tasks are graded through the exported functions rather than by
 * firing at `#blotter-form`, because the form wiring line is scaffolding the
 * lesson ships rather than work it asks for — gating on it would fail a student
 * who did every task correctly.
 *
 * `handleSubmit` is therefore called with a hand-rolled event, which also lets
 * the `preventDefault` requirement be asserted directly instead of inferred.
 */

/** A stand-in for the browser's submit event, recording preventDefault. */
function makeSubmitEvent() {
  return {
    type: "submit",
    prevented: false,
    preventDefault() {
      this.prevented = true;
    },
  };
}

/** Type into the three inputs the way a barangay clerk would. */
function fillForm(name, issue, location) {
  el("#name").value = name;
  el("#issue").value = issue;
  el("#location").value = location;
}

describe("le_01_blotter_logger", () => {
  it("accepts a complete report and rejects an incomplete one", () => {
    expect(
      Submission.validateInputs("Aling Nena", "Nawawalang aso", "Purok 3"),
      "all three fields present",
    ).true("a complete report must validate");

    expect(Submission.validateInputs("", "Nawawalang aso", "Purok 3"), "no name").false();
    expect(Submission.validateInputs("Aling Nena", "", "Purok 3"), "no issue").false();
    expect(Submission.validateInputs("Aling Nena", "Nawawalang aso", ""), "no location").false();
  });

  it("renders every logged entry into the blotter list", () => {
    Submission.blotterLogs.length = 0;
    Submission.blotterLogs.push({
      name: "Mang Tonyo",
      issue: "Sirang ilaw sa kanto",
      location: "Purok 1",
    });
    Submission.blotterLogs.push({
      name: "Aling Nena",
      issue: "Nawawalang aso",
      location: "Purok 3",
    });

    Submission.renderBlotter();

    const html = el("#blotter-logs").innerHTML;
    expect(html, "first entry name").contain("Mang Tonyo");
    expect(html, "first entry location").contain("Purok 1");
    expect(html, "first entry issue").contain("Sirang ilaw sa kanto");
    expect(html, "second entry name").contain("Aling Nena");
    expect(html, "second entry issue").contain("Nawawalang aso");
  });

  it("captures a submitted report and stops the page reloading", () => {
    Submission.blotterLogs.length = 0;
    fillForm("Kap Ramon", "Ingay sa videoke", "Purok 5");

    const event = makeSubmitEvent();
    Submission.handleSubmit(event);

    expect(event.prevented, "preventDefault").true(
      "submitting must not reload the page, or the log is lost",
    );
    expect(Submission.blotterLogs.length, "entries logged").equal(1);
    expect(Submission.blotterLogs[0].name, "logged name").equal("Kap Ramon");
    expect(Submission.blotterLogs[0].issue, "logged issue").equal("Ingay sa videoke");
    expect(Submission.blotterLogs[0].location, "logged location").equal("Purok 5");
  });

  it("trims whitespace and clears the form after a report", () => {
    Submission.blotterLogs.length = 0;
    fillForm("  Kap Ramon  ", "  Ingay sa videoke  ", "  Purok 5  ");

    Submission.handleSubmit(makeSubmitEvent());

    expect(Submission.blotterLogs[0].name, "trimmed name").equal("Kap Ramon");
    expect(el("#name").value, "name input").equal("", "the form must be cleared for the next report");
    expect(el("#issue").value, "issue input").equal("");
    expect(el("#location").value, "location input").equal("");
  });

  it("renders the new entry as part of handling the submit", () => {
    Submission.blotterLogs.length = 0;
    fillForm("Ate Baby", "Tumagas na tubo", "Purok 2");

    Submission.handleSubmit(makeSubmitEvent());

    expect(el("#blotter-logs").innerHTML, "rendered blotter").contain(
      "Tumagas na tubo",
      "a captured report should appear in the list without a second call",
    );
  });

  it("refuses to log an incomplete report", () => {
    Submission.blotterLogs.length = 0;
    fillForm("Ate Baby", "", "Purok 2");

    Submission.handleSubmit(makeSubmitEvent());

    expect(Submission.blotterLogs.length, "entries logged").equal(
      0,
      "an incomplete report must not reach the blotter",
    );
    expect(el("#name").value, "name input").equal(
      "Ate Baby",
      "a rejected report must keep what was typed, so it can be fixed",
    );
  });
});
