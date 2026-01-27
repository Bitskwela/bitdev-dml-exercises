## Background Story

![Cover Image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_7/C7+9.0+-+COVER.png)

Tian’s website for Barangay Sto. Niño was looking solid—well-structured text, clear headings, and logical lists. But it felt... solitary. Like an island in the middle of a vast ocean.

"It’s good," Ms. Reyes, the Barangay Secretary, commented. "But if I want to see the location on Google Maps, I have to leave your site. If I want to see our community gallery, there’s nothing to Look at. It’s just... words."

Tian realized the problem. The "Web" is called a "Web" because things are **connected**. Without links, a website is just a digital document. Without images, it’s just a digital flyer.

"How do I make it feel alive, Miguel?" Tian asked.

Miguel smiled. "You need to master the two tags that changed the world: `<a>` and `<img>`. The `<a>` tag — the Anchor — is the 'Hyper' in HyperText. It’s the bridge between documents. The `<img>` tag is the 'Visual Identity.' It’s what turns a technical manual into an experience."

"But wait," Tian frowned. "I tried just typing the file name `logo.png` and nothing happened."

"That’s because the browser needs a **Path**," Miguel explained. "An Elite Developer knows exactly how to point the browser to the right resource, whether it's on their own computer or on a server across the globe."

"Let’s build some bridges," Tian said, opening the code editor.

---

## Theory & Lecture Content

## Connections & Visuals: The Anchor and the Image

### 1. The Bridge: The Anchor Tag (`<a>`)
The `<a>` tag creates a hyperlink. The most important attribute is `href` (Hypertext Reference).

- **External Links:** Pointing to other websites.
  ```html
  <a href="https://google.com" target="_blank">Search on Google</a>
  ```
  *Elite Tip:* Use `target="_blank"` to open links in a new tab so users don't leave your site entirely.

- **Internal Links:** Pointing to other files in your project.
  ```html
  <a href="contact.html">Contact Us</a>
  ```

- **Anchor Links:** Pointing to a section on the *same* page.
  ```html
  <a href="#services">Jump to Services</a>
  ...
  <h2 id="services">Our Services</h2>
  ```

### 2. The Lens: The Image Tag (`<img>`)
The `<img>` tag is an **empty tag** (it has no closing tag). It requires two critical attributes:
1. `src` (Source): The path to the image.
2. `alt` (Alternative Text): A description of the image for screen readers and SEO.

- **Elite Strategy: The `alt` Attribute is Mandatory.**
  Never skip it. If the image is just decorative, use `alt=""`. If it carries information, describe it precisely.

### 3. Mastering Paths (The Map)
This is where most beginners fail. You must tell the browser exactly where to find the file.
- **Relative Path:** `src="images/logo.png"` (Look into the 'images' folder next to me).
- **Absolute Path:** `src="https://site.com/photo.jpg"` (Go to this specific address on the internet).

### 4. Interactive Images: The Image Link
You can wrap an image inside an anchor tag to make the picture clickable.
```html
<a href="home.html">
    <img src="logo.png" alt="Go to Homepage">
</a>
```

### 5. Performance & UX
- **Lazy Loading:** `loading="lazy"` tells the browser to only load the image when the user scrolls near it. This makes your site much faster!
- **Responsive Images:** Always use CSS to ensure images don't "explode" out of their containers.

---

## Clean Code: Link Integrity

**Junior Mistake:**
```html
<p>Click <a href="page2.html">here</a> to see info.</p>
```
*Why this is bad:* "Click here" tells the user (and Google) nothing about the destination.

**Elite Precision:**
```html
<p>Read our <a href="clearance.html">Barangay Clearance Guide</a> for more info.</p>
```
*Why this is good:* It’s descriptive, accessible, and better for SEO.

---

## Summary for the Aspiring Engineer

1. **Links are bridges.** Use clear, descriptive text for your links.
2. **Paths are directions.** Double-check your folder structure.
3. **Images need context.** Always provide an `alt` description.
4. **Performance matters.** Use `loading="lazy"` for a faster user experience.

**Next Lesson:** Tables, Forms, and the Art of Input.

---

## Closing Story

Tian clicked the "View Gallery" link. Instantly, the page jumped to the bottom where the photos of the Barangay Fiesta were displayed. Each photo had a clear `alt` description.

"It works! It feels like a real system now," Tian exclaimed.

"You've connected the dots," Miguel said. "Your site is no longer an island. It's part of the global web. You're not just writing text anymore—you're building a network."

Tian looked at the browser. The Barangay Sto. Niño portal was visually rich and perfectly navigable. One more step closer to the "Elite" level.
