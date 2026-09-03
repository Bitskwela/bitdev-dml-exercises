/**
 * Hidden test for le_03_typhoon_relief_tracker.
 *
 * The point of the lesson is that the tally SURVIVES a refresh, so the tests go
 * through `localStorage` rather than trusting the returned object: a
 * `updateReliefItem` that only mutates its argument would pass an in-memory
 * check and lose everything when the page reloads.
 *
 * Storage is cleared at the start of each case, since the harness keeps one
 * store for the whole file and a leftover tally would make the tests
 * order-dependent.
 */

/** Read the persisted tally the way a page reload would. */
function persisted() {
  const raw = localStorage.getItem("reliefData");
  return raw ? JSON.parse(raw) : null;
}

describe("le_03_typhoon_relief_tracker", () => {
  it("returns an empty tally when nothing has been stored yet", () => {
    localStorage.removeItem("reliefData");

    expect(JSON.stringify(Submission.loadReliefData()), "fresh load").equal(
      "{}",
      "a first visit should start from an empty tally, not undefined",
    );
  });

  it("saves a tally and loads it back unchanged", () => {
    localStorage.removeItem("reliefData");
    Submission.saveReliefData({ Bigas: 12, Sardinas: 30 });

    expect(persisted(), "persisted tally").ok("saveReliefData must write to localStorage");
    expect(JSON.stringify(Submission.loadReliefData()), "round trip").equal(
      JSON.stringify({ Bigas: 12, Sardinas: 30 }),
    );
  });

  it("adds a new item to the tally and persists it", () => {
    localStorage.removeItem("reliefData");

    const data = Submission.updateReliefItem({}, "Bigas", 12);

    expect(data.Bigas, "returned tally").equal(12);
    expect(persisted().Bigas, "persisted tally").equal(
      12,
      "an update must survive a refresh, not just live in memory",
    );
  });

  it("accumulates repeat donations of the same item", () => {
    localStorage.removeItem("reliefData");

    let data = Submission.updateReliefItem({}, "Bigas", 12);
    data = Submission.updateReliefItem(data, "Bigas", 8);

    expect(data.Bigas, "running total").equal(20, "a second donation adds, it does not replace");
    expect(persisted().Bigas, "persisted total").equal(20);
  });

  it("keeps different items apart", () => {
    localStorage.removeItem("reliefData");

    let data = Submission.updateReliefItem({}, "Bigas", 12);
    data = Submission.updateReliefItem(data, "Sardinas", 30);

    expect(data.Bigas, "rice").equal(12, "one item's donation must not touch another's");
    expect(data.Sardinas, "sardines").equal(30);
  });

  it("resets the tally in memory and in storage", () => {
    Submission.updateReliefItem({}, "Bigas", 12);

    const cleared = Submission.resetReliefData();

    expect(JSON.stringify(cleared), "returned tally").equal("{}");
    expect(persisted(), "persisted tally").not.ok(
      "resetting must clear localStorage, or the old tally returns on refresh",
    );
  });

  it("renders one table row per item", () => {
    Submission.renderTable({ Bigas: 12, Sardinas: 30 });

    const html = el("#relief-table tbody").innerHTML;
    expect(html, "table markup").contain("<tr>");
    expect(html, "rice row").contain("Bigas");
    expect(html, "rice count").contain("12");
    expect(html, "sardines row").contain("Sardinas");
    expect(html, "sardines count").contain("30");
  });

  it("renders an empty table for an empty tally", () => {
    Submission.renderTable({});

    expect(el("#relief-table tbody").innerHTML, "empty table").equal(
      "",
      "an empty tally should clear the table, not leave stale rows",
    );
  });
});
