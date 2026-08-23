/**
 * Hidden test for le_17_saving_memory.
 *
 * Storage round-trips through the real API: save with one function, read back
 * with the other. Every case that matters here is a *bad* stored value —
 * missing, corrupted, wrong type — because that is where a naive `JSON.parse`
 * throws and takes the page down.
 */

describe("le_17_saving_memory", () => {
  it("round-trips the theme and defaults to light", () => {
    localStorage.clear();
    expect(Submission.loadTheme(), "nothing saved").equal(
      "light",
      "with no saved theme the default is light",
    );

    Submission.saveTheme("dark");
    expect(Submission.loadTheme(), "after saving dark").equal("dark");

    Submission.saveTheme("light");
    expect(Submission.loadTheme(), "after saving light").equal("light");

    localStorage.setItem("app-theme", "chartreuse");
    expect(Submission.loadTheme(), "unrecognised theme").equal(
      "light",
      "an unknown stored value falls back to light",
    );
  });

  it("round-trips scores and survives corrupted storage", () => {
    localStorage.clear();
    expect(Submission.loadScores(), "nothing saved").eql([]);

    Submission.saveScores([10, 20, 30]);
    expect(Submission.loadScores(), "after saving").eql([10, 20, 30]);

    localStorage.setItem("app-scores", "{not json");
    expect(Submission.loadScores(), "corrupted JSON").eql(
      [],
      "unparseable storage must return an empty array, not throw",
    );

    localStorage.setItem("app-scores", '{"a":1}');
    expect(Submission.loadScores(), "wrong shape").eql(
      [],
      "a stored object is not a score list",
    );
  });

  it("reports whether it actually cleared anything", () => {
    localStorage.clear();
    localStorage.setItem("app-theme", "dark");

    expect(Submission.clearUserData("app-theme"), "existing key").true();
    expect(localStorage.getItem("app-theme"), "after clearing").equal(null);
    expect(Submission.clearUserData("app-theme"), "already gone").false(
      "clearing a key that is not there should report false",
    );
  });
});
