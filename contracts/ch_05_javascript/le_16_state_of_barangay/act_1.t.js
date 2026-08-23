/**
 * Hidden test for le_16_state_of_barangay.
 *
 * The three `section` elements are declared in `spec.json` because
 * `showScreen` reaches them with `querySelectorAll("section")` — a lesson that
 * needs several distinct elements behind one selector cannot rely on lazy
 * creation, which would hand it the same object three times.
 *
 * State is checked through the accessors and through storage, never by reading
 * the module's internals.
 */

describe("le_16_state_of_barangay", () => {
  it("reads and writes state through its accessors", () => {
    Submission.setState("currentScreen", "reports");
    expect(Submission.getState("currentScreen"), "currentScreen").equal(
      "reports",
    );

    Submission.setState("items", ["a", "b"]);
    expect(Submission.getState("items"), "items").eql(["a", "b"]);
  });

  it("round-trips state through localStorage", () => {
    localStorage.clear();
    Submission.setState("draft", "Naapektuhan ang kalsada");
    Submission.saveState();

    const stored = localStorage.getItem("appState");
    expect(stored !== null, "stored payload").true(
      "saveState should write the whole state under 'appState'",
    );
    expect(JSON.parse(stored).draft, "stored draft").equal(
      "Naapektuhan ang kalsada",
    );

    Submission.setState("draft", "overwritten");
    Submission.loadState();
    expect(Submission.getState("draft"), "draft after loadState").equal(
      "Naapektuhan ang kalsada",
      "loadState should restore what was saved",
    );
  });

  it("shows only the named screen and hides the others", () => {
    Submission.showScreen("reports");

    expect(el("#reports").style.display, "#reports").equal("block");
    expect(el("#home").style.display, "#home").equal(
      "none",
      "every other section must be hidden, not just the new one shown",
    );
    expect(el("#settings").style.display, "#settings").equal("none");
    expect(Submission.getState("currentScreen"), "state").equal("reports");
  });

  it("seeds the draft box and persists what is typed into it", () => {
    Submission.setState("draft", "seeded text");
    Submission.setupDraftPersistence();
    expect(el("#draft").value, "seeded value").equal(
      "seeded text",
      "the textarea should start from the saved draft",
    );

    el("#draft").value = "typed by the resident";
    fire("#draft", "input");
    expect(Submission.getState("draft"), "draft after typing").equal(
      "typed by the resident",
    );
    expect(
      JSON.parse(localStorage.getItem("appState")).draft,
      "persisted draft",
    ).equal("typed by the resident", "typing should also persist the draft");
  });
});
