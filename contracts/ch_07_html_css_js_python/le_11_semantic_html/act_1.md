# Activity: The Sto. Niño Semantic Refactor

In this activity, you will perform a "Semantic Refactor" on a legacy Barangay page layout. You will remove generic containers and replace them with meaningful HTML5 landmarks to optimize for SEO and accessibility.

## Objective
Convert a non-semantic layout into an "Elite" structural architecture.

---

## Tasks

### Task 1: Defining the Brand (Header)
**Action:** Replace a placeholder `div` with a `<header>` tag. Inside, place a level-one heading for the Barangay name and use a `<nav>` tag for the navigation menu.
```html
<header>
  <h1>Barangay Sto. Niño</h1>
  <nav>
    <ul>
      <li><a href="index.html">Home</a></li>
      <li><a href="services.html">Services</a></li>
    </ul>
  </nav>
</header>
```

### Task 2: The Core Landmark (Main)
**Action:** Wrap the primary content of the page in a `<main>` tag. Remember, there should only be one of these per page.
```html
<main>
  <!-- All primary content goes here -->
</main>
```

### Task 3: Independent Content (Article)
**Action:** Inside the `<main>` tag, create an `<article>` for a "Community Newsletter" update. Use a `<header>` inside the article for the title and a `<time>` tag for the date.
```html
<article>
  <header>
    <h2>Weekly Community Newsletter</h2>
    <p>Posted on: <time datetime="2024-11-20">November 20, 2024</time></p>
  </header>
  <p>The cleanup drive was a massive success with 100+ volunteers...</p>
</article>
```

### Task 4: Thematic Grouping (Section)
**Action:** Create a `<section>` for "Public Services". Inside this section, use multiple `<article>` tags for each service (e.g., "Clearance", "Health Clinic").
```html
<section>
  <h2>Public Services</h2>
  <article>
    <h3>Barangay Clearance</h3>
    <p>Processing time: 1 day.</p>
  </article>
  <article>
    <h3>Health Clinic</h3>
    <p>Open 8 AM to 5 PM.</p>
  </article>
</section>
```

### Task 5: Supporting Info (Aside)
**Action:** Add an `<aside>` element next to your main content to hold a "Quick Links" sidebar or "Emergency Hotlines".
```html
<aside>
  <h3>Emergency Hotlines</h3>
  <ul>
    <li>Police: 911</li>
    <li>Barangay Hall: 555-0199</li>
  </ul>
</aside>
```

### Task 6: The Standard Footer
**Action:** Add a `<footer>` at the bottom of the page. Include an `<address>` tag with the physical location of the Barangay Hall.
```html
<footer>
  <address>
    Barangay Sto. Niño Hall, Main Street, Sto. Niño, Philipines
  </address>
  <p>&copy; 2024 Official Barangay Portal</p>
</footer>
```

### Task 7: Architectural Polish (CSS)
**Action:** Add a `<style>` block to give your semantic landmarks a professional, clean layout.
```html
<style>
  body { font-family: sans-serif; margin: 0; display: flex; flex-direction: column; min-height: 100vh; }
  header { background: #2c3e50; color: white; padding: 1rem; text-align: center; }
  nav ul { list-style: none; padding: 0; display: flex; justify-content: center; gap: 20px; }
  nav a { color: #ecf0f1; text-decoration: none; }
  main { flex: 1; padding: 2rem; max-width: 800px; margin: 0 auto; }
  article { border-bottom: 1px solid #ddd; padding: 1rem 0; }
  aside { background: #f4f4f4; padding: 1rem; border-left: 4px solid #3498db; margin-top: 20px; }
  footer { background: #34495e; color: white; padding: 1rem; text-align: center; margin-top: auto; }
</style>
```
