// Job Data
const jobs = [
  {
    id: 1,
    title: "Transcriptionist",
    description: "Convert audio to text.",
    skills: ["Writing", "Listening", "Typing"],
  },
  {
    id: 2,
    title: "Graphic Designer",
    description: "Design posters and banners.",
    skills: ["Design", "Creativity", "Photoshop"],
  },
  {
    id: 3,
    title: "Data Entry",
    description: "Enter data into spreadsheets.",
    skills: ["Typing", "Admin", "Accuracy"],
  },
  {
    id: 4,
    title: "Social Media Manager",
    description: "Manage FB and IG pages.",
    skills: ["Communication", "Writing", "Creativity"],
  },
  {
    id: 5,
    title: "Virtual Assistant",
    description: "Manage email and schedule.",
    skills: ["Admin", "Organization", "Communication"],
  },
];

// Task 1: Render Job Listings
function renderJobs(jobArray) {
  const jobListEl = document.querySelector("#job-list");

  const html = jobArray
    .map(function (job) {
      return `
      <li>
        <h3>${job.title}</h3>
        <p>${job.description}</p>
        <small>Skills: ${job.skills.join(", ")}</small>
      </li>
    `;
    })
    .join("");

  jobListEl.innerHTML = html;
}

// Task 2: Filter Jobs by Skills and Keyword
function filterJobs(jobs, selectedSkills, keyword) {
  return jobs
    .filter(function (job) {
      return selectedSkills.every(function (skill) {
        return job.skills.includes(skill);
      });
    })
    .filter(function (job) {
      const lowerKeyword = keyword.toLowerCase();
      const inTitle = job.title.toLowerCase().includes(lowerKeyword);
      const inDescription = job.description
        .toLowerCase()
        .includes(lowerKeyword);
      return inTitle || inDescription;
    });
}

// Task 3: Set Up Filters and Search
function setupJobPortal() {
  const filterContainer = document.querySelector("#skill-filters");
  const searchInput = document.querySelector("#search-input");

  // Extract unique skills
  const allSkills = [];
  jobs.forEach(function (job) {
    job.skills.forEach(function (skill) {
      if (!allSkills.includes(skill)) {
        allSkills.push(skill);
      }
    });
  });

  // Create checkboxes
  allSkills.forEach(function (skill) {
    const label = document.createElement("label");
    label.innerHTML = `<input type="checkbox" value="${skill}" /> ${skill}`;
    filterContainer.appendChild(label);
  });

  let activeSkills = [];
  let searchTerm = "";

  function updateRender() {
    const filtered = filterJobs(jobs, activeSkills, searchTerm);
    renderJobs(filtered);
  }

  filterContainer.addEventListener("change", function () {
    const checkboxes = filterContainer.querySelectorAll("input:checked");
    activeSkills = Array.from(checkboxes).map(function (cb) {
      return cb.value;
    });
    updateRender();
  });

  searchInput.addEventListener("input", function () {
    searchTerm = searchInput.value.trim().toLowerCase();
    updateRender();
  });

  // Initial render
  renderJobs(jobs);
}

document.addEventListener("DOMContentLoaded", setupJobPortal);
