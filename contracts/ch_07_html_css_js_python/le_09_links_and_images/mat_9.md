## Background Story

The barangay website was taking shape. Tian had properly structured text—headings, paragraphs, lists—and the content was finally readable. But it still felt incomplete, static, isolated.

The barangay secretary, Ms. Reyes, reviewed the draft and pointed out two critical missing elements:

"First, how do users navigate between pages? You have a homepage, a services page, and a contact page, but there's no way to move from one to another. Users would have to manually type each URL, which is ridiculous."

Tian nodded, embarrassed. They hadn't even thought about navigation.

"Second, where are the images? The barangay logo, photos of officials, pictures of our community projects. Right now it's just text—no visual identity at all. Modern websites need images."

Tian opened their project folder. Three HTML files sat there: `index.html`, `services.html`, and `contact.html`. Each page existed independently with no connection to the others. There was also a folder named `images` containing the barangay logo and several photos, but Tian didn't know how to display them on the webpage.

They tried typing the image filename directly in the HTML:

```html
barangay-logo.png
```

Just the text appeared in the browser, not the actual image. Obviously that wasn't how it worked.

For navigation, Tian tried writing:

```html
Click here to go to Services page: services.html
```

But `services.html` appeared as plain text, not as a clickable link. Again, wrong approach.

That evening, Tian called Kuya Miguel, frustration evident in their voice.

"Kuya, my website has three pages but they're isolated from each other. I need navigation—clickable links that take users from one page to another. And I need to display images—the barangay logo, photos of officials. But I don't know the HTML tags for either. How do I make text clickable? How do I show images?"

Miguel pulled up his own screen, opening a simple example page.

"You need two of the most fundamental HTML elements: the `<a>` tag for links—also called anchor tags—and the `<img>` tag for images. These two elements are what made the web revolutionary. Before hyperlinks, documents were isolated. The `<a>` tag created the 'hyper' in hypertext—the ability to connect documents together. And the `<img>` tag transformed the web from pure text to a multimedia platform."

"So links connect pages, images add visuals?"

"Exactly. Links can point to other pages on your site, to external websites, to specific sections within a page, to email addresses, or even to downloadable files. Images can be local files in your project folder, or they can be hosted on external servers. Both elements use attributes—`href` for links to specify the destination, `src` for images to specify the image location, `alt` for images to provide alternative text for accessibility."

Miguel continued, "Today we're learning both elements thoroughly. You'll create navigation menus that connect all your pages, add the barangay logo to your header, include official photos, understand absolute vs relative paths, learn about image formats, and implement accessibility best practices. By the end of this lesson, your website won't be isolated pages with text—it'll be an interconnected, visual web presence."

---

## Theory & Lecture Content

## Links (`<a>` - Anchor Tag)

**Links** = Clickable elements that navigate to other pages or locations

### Basic Link Syntax

```html
<a href="destination">Link Text</a>
     │              │
     │              └─ Visible clickable text
     └─────────────── URL destination
```

**Example:**
```html
<a href="https://google.com">Go to Google</a>
```

### Types of Links

#### 1. External Links (Other websites)

```html
<!-- Full URL required -->
<a href="https://www.facebook.com">Facebook</a>
<a href="https://youtube.com">YouTube</a>
<a href="https://dlsu.edu.ph">DLSU Website</a>
```

#### 2. Internal Links (Same website)

```html
<!-- Relative path -->
<a href="about.html">About Us</a>
<a href="services.html">Services</a>
<a href="contact.html">Contact</a>

<!-- Subfolder -->
<a href="pages/profile.html">Profile</a>
<a href="docs/manual.pdf">Download Manual</a>
```

#### 3. Anchor Links (Same page, jump to section)

```html
<!-- Link to section with id -->
<a href="#services">Jump to Services</a>
<a href="#contact">Jump to Contact</a>

<!-- Target sections -->
<h2 id="services">Services</h2>
<p>Services content...</p>

<h2 id="contact">Contact</h2>
<p>Contact info...</p>
```

#### 4. Email Links

```html
<a href="mailto:barangay@gmail.com">Email Us</a>
<a href="mailto:captain@barangay.com?subject=Request">Email with Subject</a>
```

#### 5. Phone Links

```html
<a href="tel:+639171234567">Call Us: 0917-123-4567</a>
```

### Link Attributes

```html
<!-- target="_blank" - Opens in new tab -->
<a href="https://google.com" target="_blank">Google (New Tab)</a>

<!-- title - Tooltip on hover -->
<a href="about.html" title="Learn more about us">About</a>

<!-- download - Forces download instead of navigation -->
<a href="form.pdf" download>Download Form</a>
```

### Link States (CSS styling)

```html
<style>
/* Unvisited link (default: blue) */
a:link { color: blue; }

/* Visited link (default: purple) */
a:visited { color: purple; }

/* Mouse hover */
a:hover { color: red; }

/* Active (being clicked) */
a:active { color: yellow; }
</style>
```

### Filipino Example: Barangay Navigation

```html
<nav>
    <h2>Barangay Menu</h2>
    <ul>
        <li><a href="index.html">Home</a></li>
        <li><a href="officials.html">Officials</a></li>
        <li><a href="services.html">Services</a></li>
        <li><a href="#contact">Contact</a></li>
        <li><a href="https://facebook.com/barangaystonino" target="_blank">Facebook Page</a></li>
    </ul>
</nav>
```

## Images (`<img>`)

**Images** = Visual content displayed on page

### Basic Image Syntax

```html
<img src="source" alt="description">
     │            │
     │            └─ Alternate text (if image fails)
     └───────────── Image file path
```

**Example:**
```html
<img src="captain.jpg" alt="Barangay Captain">
```

### Image Sources

#### 1. Local Images (Same folder)

```html
<img src="photo.jpg" alt="Photo">
<img src="images/logo.png" alt="Logo">
<img src="../pictures/header.jpg" alt="Header">
```

#### 2. External Images (URL)

```html
<img src="https://example.com/image.jpg" alt="External image">
```

### Image Attributes

```html
<!-- Width and Height (pixels) -->
<img src="photo.jpg" alt="Photo" width="300" height="200">

<!-- Width only (height auto-scales) -->
<img src="photo.jpg" alt="Photo" width="500">

<!-- title - Tooltip on hover -->
<img src="logo.png" alt="Logo" title="Barangay Logo">
```

### Why `alt` Attribute is Critical

1. **Accessibility:** Screen readers for blind users
2. **SEO:** Google indexes image descriptions
3. **Fallback:** Shows text if image fails to load
4. **Slow connections:** Text appears before image loads

**Good alt text:**
```html
<img src="captain.jpg" alt="Barangay Captain Maria Santos speaking at community meeting">
```

**Bad alt text:**
```html
<img src="captain.jpg" alt="image">  <!-- Too generic -->
<img src="captain.jpg" alt="">       <!-- Empty (only for decorative) -->
```

### Image as Link

```html
<!-- Clickable image -->
<a href="homepage.html">
    <img src="logo.png" alt="Barangay Logo - Click to go home">
</a>
```

### Responsive Images

```html
<!-- Max width 100% (scales to container) -->
<img src="banner.jpg" alt="Banner" style="max-width: 100%; height: auto;">
```

### Image Formats

**Common formats:**
- **JPG/JPEG** - Photos (lossy compression, smaller file size)
- **PNG** - Graphics, logos (transparent backgrounds, lossless)
- **GIF** - Animations, simple graphics (limited colors)
- **SVG** - Vector graphics (scales without quality loss)
- **WebP** - Modern format (better compression, not universally supported)

**When to use:**
- Photos: JPG
- Logos with transparency: PNG
- Animations: GIF
- Icons/illustrations: SVG

## Real-World Example: Barangay Official Profile

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Barangay Officials</title>
</head>
<body>
    <h1>Barangay Sto. Niño Officials</h1>
    
    <!-- Navigation Links -->
    <nav>
        <a href="index.html">Home</a> |
        <a href="officials.html">Officials</a> |
        <a href="services.html">Services</a> |
        <a href="#contact">Contact</a>
    </nav>
    
    <hr>
    
    <!-- Captain Profile with Image -->
    <h2>Barangay Captain</h2>
    <img src="images/captain.jpg" alt="Barangay Captain Maria Santos" width="200">
    <p>
        <strong>Hon. Maria Santos</strong><br>
        Term: 2022-2025<br>
        <a href="mailto:maria.santos@barangay.gov">Email</a> |
        <a href="tel:+639171234567">Call: 0917-123-4567</a>
    </p>
    
    <hr>
    
    <!-- Kagawad with Images -->
    <h2>Kagawad Members</h2>
    
    <div>
        <img src="images/kagawad1.jpg" alt="Kagawad Juan Dela Cruz" width="150">
        <p><strong>Juan Dela Cruz</strong> - Health Committee</p>
    </div>
    
    <div>
        <img src="images/kagawad2.jpg" alt="Kagawad Ana Reyes" width="150">
        <p><strong>Ana Reyes</strong> - Education Committee</p>
    </div>
    
    <hr>
    
    <!-- Social Media Links -->
    <h2 id="contact">Connect With Us</h2>
    <p>
        <a href="https://facebook.com/barangaystonino" target="_blank">
            <img src="icons/facebook.png" alt="Facebook" width="30">
            Facebook Page
        </a><br>
        
        <a href="https://twitter.com/brgy_stonino" target="_blank">
            <img src="icons/twitter.png" alt="Twitter" width="30">
            Twitter
        </a>
    </p>
    
    <!-- Back to top link -->
    <p><a href="#top">Back to Top</a></p>
</body>
</html>
```

## Image Optimization Tips

1. **Resize images** before uploading (don't use HTML width/height to resize large images)
2. **Compress images** (TinyPNG.com, ImageOptim)
3. **Use appropriate format** (JPG for photos, PNG for graphics)
4. **Lazy loading** (loads images as user scrolls)
   ```html
   <img src="photo.jpg" alt="Photo" loading="lazy">
   ```

## Accessibility Best Practices

```html
<!-- Decorative images (no information) -->
<img src="decoration.png" alt="" role="presentation">

<!-- Informative images (describe content) -->
<img src="chart.png" alt="Sales increased 50% from 2023 to 2024">

<!-- Functional images (like buttons) -->
<a href="home.html">
    <img src="home-icon.png" alt="Go to homepage">
</a>
```

## Common Mistakes

### ❌ Missing `alt` attribute
```html
<img src="photo.jpg">  <!-- WRONG: No alt -->
```
✅ **Correct:**
```html
<img src="photo.jpg" alt="Barangay Captain">
```

### ❌ Using HTML to resize large images
```html
<!-- WRONG: 5MB image resized to 100px -->
<img src="huge-image.jpg" width="100">
```
✅ **Correct:** Resize image file first, then use.

### ❌ Broken link paths
```html
<a href="Services.html">Services</a>  <!-- Case-sensitive on servers! -->
<a href="services.html">Services</a>  <!-- Correct -->
```

### ❌ External links without `target="_blank"`
```html
<a href="https://facebook.com">FB</a>  <!-- Leaves your site -->
```
✅ **Better:**
```html
<a href="https://facebook.com" target="_blank">FB</a>
```

## Summary

**Links (`<a>`):**
- `href` = destination
- Types: external, internal, anchor, email, tel
- `target="_blank"` = new tab
- `download` = force download

**Images (`<img>`):**
- `src` = image source
- `alt` = description (required!)
- `width`/`height` = dimensions
- Formats: JPG (photos), PNG (logos), GIF (animations), SVG (vectors)
- Always optimize file size

**Next lesson:** Tables, Forms, and Input Fields

---

## Closing Story

Tian embedded the first imagea photo of the barangay hall. It loaded perfectly. Then came links to other pages: announcements, contacts, services. Click. Navigate. Return. The site was alive.

"This is it," Tian whispered. "This is what makes it a web. Links connecting pages. Images bringing content to life."

Kuya Miguel grinned. "Now you understand why Tim Berners-Lee called it the World Wide **Web**. It's all about connections."

Tian tested every link, every image. All working. The barangay portal was no longer a single static pageit was a system. Small, yes. But functional.

_Next up: Tables, Forms, and Inputsstructured data!_

---

## Closing Story

Tian embedded the first imagea photo of the barangay hall. It loaded perfectly. Then came links to other pages: announcements, contacts, services. Click. Navigate. Return. The site was alive.

"This is it," Tian whispered. "This is what makes it a web. Links connecting pages. Images bringing content to life."

Kuya Miguel grinned. "Now you understand why Tim Berners-Lee called it the World Wide **Web**. It's all about connections."

Tian tested every link, every image. All working. The barangay portal was no longer a single static pageit was a system. Small, yes. But functional.

_Next up: Tables, Forms, and Inputsstructured data!_

---

## Closing Story

Tian embedded the first imagea photo of the barangay hall. It loaded perfectly. Then came links to other pages: announcements, contacts, services. Click. Navigate. Return. The site was alive.

"This is it," Tian whispered. "This is what makes it a web. Links connecting pages. Images bringing content to life."

Kuya Miguel grinned. "Now you understand why Tim Berners-Lee called it the World Wide **Web**. It's all about connections."

Tian tested every link, every image. All working. The barangay portal was no longer a single static pageit was a system. Small, yes. But functional.

_Next up: Tables, Forms, and Inputsstructured data!_ 