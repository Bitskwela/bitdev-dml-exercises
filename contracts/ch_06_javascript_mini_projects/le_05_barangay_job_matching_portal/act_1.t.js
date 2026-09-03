/**
 * Hidden test for le_05_barangay_job_matching_portal.
 *
 * `filterJobs` combines two rules with different logic, and getting them the
 * wrong way round still "works" on the happy path — so both are pinned
 * separately: skills are ALL-of (a job must have every selected skill), while
 * the keyword is ANY-of across title and description.
 *
 * `setupJobPortal` is called once, in the last case, because it appends the
 * skill checkboxes and a second call would duplicate every one of them.
 */

const titlesOf = (list) => list.map((job) => job.title);

describe("le_05_barangay_job_matching_portal", () => {
  it("renders every job with its title, description and skills", () => {
    Submission.renderJobs(Submission.jobs);

    const html = el("#job-list").innerHTML;
    expect(html, "list markup").contain("<li>");
    expect(html, "job title").contain("Transcriptionist");
    expect(html, "job description").contain("Convert audio to text.");
    expect(html, "job skills").contain("Writing, Listening, Typing");
    expect(html, "last job").contain("Virtual Assistant");
  });

  it("renders only the jobs it is given", () => {
    Submission.renderJobs([Submission.jobs[1]]);

    const html = el("#job-list").innerHTML;
    expect(html, "rendered job").contain("Graphic Designer");
    expect(html, "filtered-out job").not.contain(
      "Transcriptionist",
      "rendering a filtered list must replace the previous one, not append to it",
    );
  });

  it("returns everything when nothing is selected or searched", () => {
    const all = Submission.filterJobs(Submission.jobs, [], "");

    expect(all.length, "unfiltered count").equal(5);
  });

  it("filters by a single skill", () => {
    const typing = titlesOf(Submission.filterJobs(Submission.jobs, ["Typing"], ""));

    expect(typing.length, "typing jobs").equal(2);
    expect(typing, "typing jobs").contain("Transcriptionist");
    expect(typing, "typing jobs").contain("Data Entry");
  });

  it("requires every selected skill, not just one of them", () => {
    const both = titlesOf(
      Submission.filterJobs(Submission.jobs, ["Writing", "Creativity"], ""),
    );

    expect(both.length, "jobs with both skills").equal(
      1,
      "selecting two skills should narrow the list, not widen it",
    );
    expect(both, "jobs with both skills").contain("Social Media Manager");
  });

  it("matches the keyword against the title or the description", () => {
    const byTitle = titlesOf(Submission.filterJobs(Submission.jobs, [], "designer"));
    expect(byTitle, "title match").contain("Graphic Designer");
    expect(byTitle.length, "title match count").equal(1);

    const byDescription = titlesOf(Submission.filterJobs(Submission.jobs, [], "spreadsheets"));
    expect(byDescription, "description match").contain("Data Entry");
    expect(byDescription.length, "description match count").equal(1);
  });

  it("ignores the case of the keyword", () => {
    const upper = titlesOf(Submission.filterJobs(Submission.jobs, [], "DESIGNER"));

    expect(upper, "uppercase search").contain(
      "Graphic Designer",
      "a search must not depend on how the resident typed it",
    );
  });

  it("applies the skills and the keyword together", () => {
    const both = titlesOf(Submission.filterJobs(Submission.jobs, ["Admin"], "email"));

    expect(both.length, "combined filter").equal(1);
    expect(both, "combined filter").contain("Virtual Assistant");
  });

  it("returns an empty list when nothing matches", () => {
    const none = Submission.filterJobs(Submission.jobs, ["Design"], "spreadsheets");

    expect(none.length, "impossible combination").equal(0);
  });

  it("sets up the portal with a skill filter per unique skill", () => {
    Submission.setupJobPortal();

    expect(el("#job-list").innerHTML, "initial render").contain(
      "Transcriptionist",
      "the portal should show every job before any filter is applied",
    );
    expect(el("#skill-filters").children.length, "skill checkboxes").equal(
      10,
      "one checkbox per unique skill across all five jobs",
    );
  });
});
