## Background Story

Every afternoon, Odessa and Paula could hear worried chatter at the barangay hall’s waiting area. Kuya Renzo, the tricycle driver, had just lost his side gig as a courier. Ate Marites, the single mom, wanted to earn from home but didn’t know where to start. Even the teen who sold fishballs outside Señora Cruz’s sari-sari store asked for “online job tips.”

Seeing her neighbors struggle, Odessa felt a calling: “Let’s help them find work with code.” Over cups of tsokolate at a talipapa stall, she and Paula sketched **HanapBuhay.js**—a simple job board that would list freelance gigs like transcription, graphic design, data entry, and tutoring. Residents could filter by skills (e.g., “Writing,” “Design,” “Admin”) using checkboxes and search by keywords. It would use a mocked JSON array on the frontend, but the UI would feel 100% real.

That night, Odessa coded the data file with an array of job objects, each having a title, description, and array of required skills. Paula watched as Odessa wrote the filtering logic: `jobs.filter(job => selectedSkills.every(skill => job.skills.includes(skill)))` and chained a `.filter()` for the search keyword. They created checkboxes dynamically, listened for `change` events, and updated the job list instantly.

The next morning, they deployed the static HTML on Netlify and shared the link in the barangay’s Facebook group. Kuya Renzo clicked and found a data-entry job on Upwork. Ate Marites filtered for “Writing” jobs and saw a transcription gig—her first remote assignment. Even the pensioner Dona Lita signed up for an online tutoring platform.

As stories of success poured in, Odessa smiled: this was just the frontend. Next month, she’d build the real backend with Node.js and MongoDB. But for now, HanapBuhay.js was changing lives—one filter at a time. And Paula already joked, “Odessa for Mayor!” 🇵🇭💻

---

## Theory & Lecture Content

In this lesson, you will learn how to:

1. Mock a JSON array of job postings
2. Render a list of jobs to the DOM
3. Handle checkbox filters and search input
4. Use `Array.filter()` and `Array.includes()`
5. Wire up event listeners to update the UI in real time

### 1. Mocking Job Data

```js
// data.js
export const jobs = [
  {
    id: 1,
    title: "Transcriptionist",
    description: "Convert audio files into text.",
    skills: ["Writing", "Listening", "Typing"],
  },
  {
    id: 2,
    title: "Graphic Designer",
    description: "Create social media banners.",
    skills: ["Design", "Creativity", "Photoshop"],
  },
  {
    id: 3,
    title: "Virtual Assistant",
    description: "Manage email inbox and schedule.",
    skills: ["Admin", "Communication", "Organization"],
  },
  // ... more jobs
];
```

### 2. Rendering Jobs

```html
<!-- index.html -->
<input type="text" id="search-input" placeholder="Search jobs..." />
<div id="skill-filters"></div>
<ul id="job-list"></ul>
```

```js
// app.js
import { jobs } from "./data.js";

const jobListEl = document.querySelector("#job-list");
const searchInput = document.querySelector("#search-input");
const filterContainer = document.querySelector("#skill-filters");

// Render job items
export function renderJobs(jobArray) {
  jobListEl.innerHTML = jobArray
    .map(
      (job) => `
      <li>
        <h3>${job.title}</h3>
        <p>${job.description}</p>
        <small>Skills: ${job.skills.join(", ")}</small>
      </li>
    `
    )
    .join("");
}
```

Reference:

- Array.filter: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/filter
- Array.includes: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/includes

### 3. Creating Checkbox Filters

```js
// Extract unique skills
const allSkills = [...new Set(jobs.flatMap((job) => job.skills))];

// Dynamically create checkboxes
allSkills.forEach((skill) => {
  const label = document.createElement("label");
  label.innerHTML = `<input type="checkbox" value="${skill}" /> ${skill}`;
  filterContainer.appendChild(label);
});
```

### 4. Filtering Logic

```js
export function filterJobs(jobs, selectedSkills, keyword) {
  return jobs
    .filter((job) =>
      // match all selected skills
      selectedSkills.every((skill) => job.skills.includes(skill))
    )
    .filter(
      (job) =>
        // keyword match in title or description
        job.title.toLowerCase().includes(keyword) ||
        job.description.toLowerCase().includes(keyword)
    );
}
```

### 5. Wiring it All Together

```js
let activeSkills = [];
let searchTerm = "";

filterContainer.addEventListener("change", () => {
  activeSkills = Array.from(
    filterContainer.querySelectorAll("input:checked")
  ).map((cb) => cb.value);
  updateRender();
});

searchInput.addEventListener("input", () => {
  searchTerm = searchInput.value.trim().toLowerCase();
  updateRender();
});

function updateRender() {
  const filtered = filterJobs(jobs, activeSkills, searchTerm);
  renderJobs(filtered);
}

// Initial render
renderJobs(jobs);
```

---

## Exercises

### Exercise 1: Mock and Export Job Data

**Problem Statement**  
Create a `data.js` file exporting a constant `jobs` containing at least 5 job objects. Each should have `id`, `title`, `description`, and `skills` (array).

**Todo List**

- [ ] Create `data.js`.
- [ ] Define and export `jobs` array.
- [ ] Include at least 5 jobs with varied skills.

**Starter Code (data.js)**

```js
// TODO: export const jobs = [ ... ];
```

**Full Solution (data.js)**

```js
export const jobs = [
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
    title: "Social Media Mgmt",
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
```

---

### Exercise 2: Render Job Listings

**Problem Statement**  
Implement `renderJobs(jobArray)` in `app.js` to display jobs inside `<ul id="job-list">`.

**Todo List**

- [ ] Select `#job-list` element.
- [ ] Define `renderJobs(jobs)` using `.map()` and template literals.
- [ ] Join the array and set `innerHTML`.

**Starter Code (app.js)**

```js
import { jobs } from "./data.js";

const jobListEl = document.querySelector("#job-list");

export function renderJobs(jobArray) {
  // TODO
}

// initial call
renderJobs(jobs);
```

**Full Solution (app.js)**

```js
import { jobs } from "./data.js";

const jobListEl = document.querySelector("#job-list");

export function renderJobs(jobArray) {
  jobListEl.innerHTML = jobArray
    .map(
      (job) => `
      <li>
        <h3>${job.title}</h3>
        <p>${job.description}</p>
        <small>Skills: ${job.skills.join(", ")}</small>
      </li>
    `
    )
    .join("");
}

// initial render
renderJobs(jobs);
```

---

### Exercise 3: Build the `filterJobs` Function

**Problem Statement**  
Write `filterJobs(jobs, selectedSkills, keyword)` that returns only those jobs matching **all** selected skills and containing the keyword in the title or description.

**Todo List**

- [ ] Accept three parameters.
- [ ] Use `jobs.filter()` twice: first for skills, then for keyword.
- [ ] Use `Array.every()` and `includes()` for skills.
- [ ] Compare lowercase strings for keyword match.

**Starter Code (app.js)**

```js
export function filterJobs(jobs, selectedSkills, keyword) {
  // TODO
}
```

**Full Solution (app.js)**

```js
export function filterJobs(jobs, selectedSkills, keyword) {
  return jobs
    .filter((job) =>
      selectedSkills.every((skill) => job.skills.includes(skill))
    )
    .filter(
      (job) =>
        job.title.toLowerCase().includes(keyword) ||
        job.description.toLowerCase().includes(keyword)
    );
}
```

---

### Exercise 4: Wire Up Filters and Search

**Problem Statement**  
Hook up checkboxes and search input so the displayed job list updates in real time.

**Todo List**

- [ ] Dynamically render skill checkboxes from `allSkills`.
- [ ] Listen for `change` events on filter container.
- [ ] Listen for `input` events on `#search-input`.
- [ ] On any change, call `filterJobs()` and `renderJobs()`.

**Starter Code (app.js)**

```js
import { jobs } from "./data.js";
import { renderJobs, filterJobs } from "./app.js";

const filterContainer = document.querySelector("#skill-filters");
const searchInput = document.querySelector("#search-input");

const allSkills = [...new Set(jobs.flatMap((j) => j.skills))];

// TODO: render checkboxes

let activeSkills = [];
let searchTerm = "";

function updateRender() {
  // TODO: filter and render
}

// TODO: add event listeners

// initial render
renderJobs(jobs);
```

**Full Solution (app.js)**

```js
import { jobs } from "./data.js";
import { renderJobs, filterJobs } from "./app.js";

const filterContainer = document.querySelector("#skill-filters");
const searchInput = document.querySelector("#search-input");

const allSkills = [...new Set(jobs.flatMap((j) => j.skills))];

// Render skill checkboxes
allSkills.forEach((skill) => {
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

// Checkbox change
filterContainer.addEventListener("change", () => {
  activeSkills = Array.from(
    filterContainer.querySelectorAll("input:checked")
  ).map((cb) => cb.value);
  updateRender();
});

// Search input
searchInput.addEventListener("input", () => {
  searchTerm = searchInput.value.trim().toLowerCase();
  updateRender();
});

// Initial render
renderJobs(jobs);
```

---

## Test Cases

Install Jest:

```bash
npm install --save-dev jest
```

Add to `package.json`:

```json
"scripts": {
  "test": "jest"
},
"jest": {
  "testEnvironment": "node"
}
```

Create `data.js` and `app.js` as above. Then write tests in `app.test.js`:

```js
// app.test.js
import { jobs } from "./data.js";
import { filterJobs } from "./app.js";

describe("filterJobs()", () => {
  test("returns all jobs when no filters", () => {
    const result = filterJobs(jobs, [], "");
    expect(result.length).toBe(jobs.length);
  });

  test("filters by single skill", () => {
    const result = filterJobs(jobs, ["Admin"], "");
    expect(result.every((job) => job.skills.includes("Admin"))).toBe(true);
  });

  test("filters by multiple skills", () => {
    const result = filterJobs(jobs, ["Admin", "Communication"], "");
    expect(
      result.every(
        (job) =>
          job.skills.includes("Admin") && job.skills.includes("Communication")
      )
    ).toBe(true);
  });

  test("filters by keyword in title", () => {
    const result = filterJobs(jobs, [], "graphic");
    expect(result).toHaveLength(1);
    expect(result[0].title).toMatch(/Graphic/i);
  });

  test("filters by keyword in description", () => {
    const result = filterJobs(jobs, [], "spreadsheet");
    expect(result).toHaveLength(1);
    expect(result[0].description).toMatch(/spreadsheet/i);
  });

  test("combines skill and keyword filters", () => {
    const result = filterJobs(jobs, ["Writing"], "audio");
    expect(result).toHaveLength(1);
    expect(result[0].title).toBe("Transcriptionist");
  });
});
```

Run tests:

```bash
npm test
```

---

## Closing Story

As HanapBuhay.js spread across barangays, job seekers no longer hung around the hall hoping for word-of-mouth leads. Kuya Renzo’s first Upwork gig paid off his motorbike loan. Ate Marites finished her transcription project, and Dona Lita’s tutoring schedule filled up.

Odessa and Paula celebrated with a halo-halo feast at their favorite carinderia. But Odessa’s mind raced ahead: “Next month, I’ll connect this frontend to a Node.js API and build a real backend.” Paula raised her spoon: “Odessa for Mayor—and for Tech Mogul!”

The portal was live, the community empowered, and Odessa’s journey to full-stack hero had only just begun. 🚀
