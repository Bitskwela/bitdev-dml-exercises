# Barangay Job Matching Portal Activity

## Initial Code

```js
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
  // Add your code here
}

// Task 2: Filter Jobs by Skills and Keyword
function filterJobs(jobs, selectedSkills, keyword) {
  // Add your code here
}

// Task 3: Set Up Filters and Search
function setupJobPortal() {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: `Array.map()`, `Array.filter()`, `Array.every()`, `Array.includes()`, Template Literals, Dynamic Checkbox Creation, Event Listeners

---

### Task 1: Render Job Listings

Create a function that renders an array of job objects into the `#job-list` element. Use `.map()` to transform each job into an HTML `<li>` element with title, description, and skills.

```js
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
```

---

### Task 2: Filter Jobs by Skills and Keyword

Create a function that filters jobs based on selected skills and a search keyword. A job matches if it has ALL selected skills and the keyword appears in the title or description (case-insensitive).

```js
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
```

---

### Task 3: Set Up Filters and Search

Create a function that sets up the job portal:

1. Extract unique skills from all jobs
2. Create checkboxes dynamically
3. Listen for checkbox changes and search input
4. Re-filter and re-render on each change

```js
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
```

---

## Breakdown of the Activity

**Variables Defined:**

- `jobs`: An array of job objects, each with `id`, `title`, `description`, and `skills` array.

- `jobArray`: Parameter representing the array of jobs to render.

- `selectedSkills`: An array of skill strings that the user has checked.

- `keyword`: A string representing the user's search term.

- `allSkills`: An array of unique skill strings extracted from all jobs.

- `activeSkills`: Tracks currently selected skills from checkboxes.

- `searchTerm`: Tracks the current search input value.

- `filterContainer`: Reference to the container where skill checkboxes are created.

- `searchInput`: Reference to the search text input element.

**Key Concepts:**

- `Array.map()`:
  Transforms each element in an array. Used to convert job objects to HTML strings.

- `Array.filter()`:
  Creates a new array with elements that pass a test. Used twice: once for skills, once for keyword.

- `Array.every()`:
  Returns `true` if ALL elements pass the test. Checks if job has ALL selected skills.

- `Array.includes()`:
  Checks if an array contains a specific value. Used to check if job.skills includes a required skill.

- `String.includes()`:
  Checks if a string contains a substring. Used for keyword matching in title/description.

- `toLowerCase()`:
  Converts string to lowercase for case-insensitive comparison.

- Dynamic Element Creation:
  Using `document.createElement()` to build checkboxes programmatically.

- `Array.from()`:
  Converts array-like objects (like NodeList) to a real array for using array methods.

- `input:checked` Selector:
  CSS selector that matches only checked checkbox inputs.

**Key Functions:**

- `renderJobs(jobArray)`:
  Converts an array of job objects to HTML and updates the DOM.

- `filterJobs(jobs, selectedSkills, keyword)`:
  Filters jobs by matching ALL selected skills AND keyword in title/description. Returns filtered array.

- `setupJobPortal()`:
  Initializes the job portal by creating checkboxes, setting up event listeners, and performing initial render.

- `updateRender()`:
  Helper function that applies current filters and re-renders the job list.
