# Lesson 9: Links and Images

## Background Story

Tian's website had text structure, but Kuya Miguel said, "Now let's add links to connect pages and images to make it visual. These two elements make the web truly *hyper*text."

"What's the difference between a link and an image?" Tian asked.

"Links take you places. Images show you things. Both are essential for modern websites."

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