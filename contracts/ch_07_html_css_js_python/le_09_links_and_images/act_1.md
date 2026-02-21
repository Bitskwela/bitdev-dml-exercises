# Activity: The Sto. Niño Interactive Map & Gallery

In this activity, you will evolve the Barangay portal by connecting it to the world and adding visual identity. You will implement navigation, external bridges, and high-performance image loading.

## Objective
Create a fully interconnected page with internal/external links and optimized images.

---

## Tasks

### Task 1: Building the Bridge (External Links)
**Action:** Create a paragraph that links to "Google Maps" so users can find the Barangay Hall. Ensure the link opens in a new tab.
```html
<p>Find us on <a href="https://www.google.com/maps" target="_blank">Google Maps</a> to visit the Barangay Hall in person.</p>
```

### Task 2: The Navigation Hub (Internal Links)
**Action:** Create a `<nav>` element with an unordered list of links to non-existent internal pages: "Home", "About", and "Services".
```html
<nav>
  <ul>
    <li><a href="index.html">Home</a></li>
    <li><a href="about.html">About</a></li>
    <li><a href="services.html">Services</a></li>
  </ul>
</nav>
```

### Task 3: Visual Signature (Local Images)
**Action:** Add the Barangay Logo to the top of your page. Since we don't have the file yet, use a placeholder path `images/logo.png` and a descriptive `alt` attribute.
```html
<img src="images/logo.png" alt="Official Seal of Barangay Sto. Niño">
```

### Task 4: Content from the Cloud (External Images)
**Action:** Insert a community photo using an external URL. Add a `width` of 600px and the `loading="lazy"` attribute for performance.
```html
<img 
  src="https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_7/C7+9.0+-+COVER.png" 
  alt="Community gathering at the Sto. Niño Multi-purpose Hall" 
  width="600" 
  loading="lazy"
>
```

### Task 5: Teleportation (Anchor Links)
**Action:** Create an "Emergency Contact" section at the bottom of your page with an `id="emergency"`. Then, create a link at the top of your page that "jumps" directly to that section.
```html
<!-- At the top -->
<a href="#emergency">Jump to Emergency Contacts</a>

<!-- At the bottom -->
<h2 id="emergency">Emergency Contacts</h2>
<p>Dial 911 for immediate assistance.</p>
```

### Task 6: Interactive Graphics (Image Links)
**Action:** Wrap a small icon image (use a placeholder icon URL) inside an anchor tag that links to the Barangay’s Facebook page.
```html
<a href="https://facebook.com" target="_blank">
  <img src="https://cdn-icons-png.flaticon.com/512/124/124010.png" alt="Follow us on Facebook" width="40">
</a>
```

### Task 7: Elite Responsiveness (Internal CSS)
**Action:** Add a `<style>` block to ensure that all images on the page never exceed the width of their container and look sharp.
```html
<style>
  body {
    font-family: Arial, sans-serif;
    max-width: 900px;
    margin: 0 auto;
    padding: 20px;
  }
  img {
    max-width: 100%;
    height: auto;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
  }
  nav ul {
    list-style: none;
    padding: 0;
    display: flex;
    gap: 20px;
  }
  a {
    color: #3498db;
    text-decoration: none;
    font-weight: bold;
  }
  a:hover {
    text-decoration: underline;
    color: #2980b9;
  }
</style>
```
