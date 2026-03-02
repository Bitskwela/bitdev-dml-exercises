const { validateSolution } = require("../../ch_05_javascript/test-helper.js");
const path = require("path");

describe("Le 05: Barangay Job Matching Portal", () => {
  const codePath = path.join(__dirname, "act_1.answer.js");

  test("renderJobs should update job-list with cards", () => {
    validateSolution(codePath, (context) => {
      const { document } = context;
      const jobListEl = { innerHTML: "" };
      document.querySelector.mockReturnValue(jobListEl);

      const { renderJobs } = context.global;

      const sampleJobs = [
        { title: "Chef", description: "Cook food", skills: ["Cooking"] },
      ];
      renderJobs(sampleJobs);

      expect(jobListEl.innerHTML).toContain("Chef");
      expect(jobListEl.innerHTML).toContain("Cook food");
      expect(jobListEl.innerHTML).toContain("Cooking");
    });
  });

  test("filterJobs should filter by skill and keyword", () => {
    validateSolution(codePath, (context) => {
      const { filterJobs, jobs } = context.global;

      // Filter by skill: 'Creativity'
      const skillFiltered = filterJobs(jobs, ["Creativity"], "");
      expect(skillFiltered.length).toBe(2); // Graphic Designer, Social Media Manager

      // Filter by keyword: 'audio'
      const keywordFiltered = filterJobs(jobs, [], "audio");
      expect(keywordFiltered.length).toBe(1);
      expect(keywordFiltered[0].title).toBe("Transcriptionist");

      // Filter by skill and keyword
      const combined = filterJobs(jobs, ["Writing"], "audio");
      expect(combined.length).toBe(1);

      const nonefound = filterJobs(jobs, ["Writing"], "Photoshop");
      expect(nonefound.length).toBe(0);
    });
  });

  test("setupJobPortal should populate filters with unique skills", () => {
    validateSolution(codePath, (context) => {
      const { document } = context;
      const filterContainer = {
        appendChild: jest.fn(),
        querySelectorAll: jest.fn(() => []),
        addEventListener: jest.fn(),
      };
      document.querySelector.mockImplementation((selector) => {
        if (selector === "#skill-filters") return filterContainer;
        return { addEventListener: jest.fn() };
      });

      const { setupJobPortal, jobs } = context;

      setupJobPortal();

      const uniqueSkillsCount = new Set(jobs.flatMap((j) => j.skills)).size;
      expect(filterContainer.appendChild).toHaveBeenCalledTimes(
        uniqueSkillsCount,
      );
    });
  });
});
