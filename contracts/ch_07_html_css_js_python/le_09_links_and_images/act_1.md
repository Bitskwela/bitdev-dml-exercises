# Lesson 9 Activities: Links and Images

## Making Websites Interactive and Visual

Master hyperlinks and images to create engaging, navigable web pages!

---

## Activity 1: Basic Link Creation

**Goal:** Create various types of hyperlinks.

**Create:** `links-basics.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Link Examples</title>
</head>
<body>
    <h1>Barangay Sto. Niño</h1>
    
    <!-- 1. External link (absolute URL) -->
    <p>Visit our <a href="https://facebook.com/brgyston">Facebook page</a></p>
    
    <!-- 2. Internal link (relative URL) -->
    <p>View our <a href="services.html">Services</a></p>
    <p>Read <a href="about.html">About Us</a></p>
    
    <!-- 3. Email link -->
    <p>Contact us: <a href="mailto:brgy.stonino@example.com">brgy.stonino@example.com</a></p>
    
    <!-- 4. Phone link -->
    <p>Call us: <a href="tel:+639123456789">0912-345-6789</a></p>
    
    <!-- 5. SMS link -->
    <p>Text us: <a href="sms:+639123456789">Send SMS</a></p>
    
    <!-- 6. Link to file -->
    <p><a href="clearance-form.pdf" download>Download Clearance Form</a></p>
</body>
</html>
```

**Test each link type:**
1. Does Facebook open in new tab?
2. Do internal links navigate?
3. Does email client open?
4. Does phone dialer activate on mobile?

---

## Activity 2: Link Attributes and Targets

**Goal:** Master link attributes for better UX.

**Create:** `link-attributes.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Link Attributes</title>
</head>
<body>
    <h1>Link Attribute Examples</h1>
    
    <!-- 1. Open in new tab (with security) -->
    <p>
        <a href="https://google.com" target="_blank" rel="noopener noreferrer">
            Google (opens in new tab)
        </a>
    </p>
    
    <!-- 2. Same tab (default) -->
    <p>
        <a href="https://google.com" target="_self">
            Google (same tab)
        </a>
    </p>
    
    <!-- 3. Title attribute (tooltip) -->
    <p>
        <a href="services.html" title="View our services">
            Services
        </a>
    </p>
    
    <!-- 4. Download attribute -->
    <p>
        <a href="document.pdf" download="barangay-clearance-form.pdf">
            Download with custom filename
        </a>
    </p>
    
    <!-- 5. Jump to section (anchor link) -->
    <p>
        <a href="#contact">Jump to Contact Section</a>
    </p>
    
    <!-- Content spacer -->
    <div style="height: 1000px;"></div>
    
    <!-- Target section -->
    <section id="contact">
        <h2>Contact Us</h2>
        <p>Barangay Hall address here...</p>
        <a href="#top">Back to top</a>
    </section>
</body>
</html>
```

**Security note:** Always use `rel="noopener noreferrer"` with `target="_blank"` to prevent security vulnerabilities!

---

## Activity 3: Navigation Menu

**Goal:** Build a functional navigation bar.

**Create:** `navigation.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Barangay Navigation</title>
</head>
<body>
    <!-- Navigation menu -->
    <nav>
        <ul>
            <li><a href="index.html">Home</a></li>
            <li><a href="about.html">About</a></li>
            <li><a href="services.html">Services</a></li>
            <li><a href="officials.html">Officials</a></li>
            <li><a href="announcements.html">Announcements</a></li>
            <li><a href="contact.html">Contact</a></li>
        </ul>
    </nav>
    
    <h1>Welcome to Barangay Sto. Niño</h1>
    <p>Main content here...</p>
    
    <!-- Breadcrumb navigation -->
    <nav aria-label="Breadcrumb">
        <ol>
            <li><a href="index.html">Home</a> &gt;</li>
            <li><a href="services.html">Services</a> &gt;</li>
            <li>Barangay Clearance</li>
        </ol>
    </nav>
</body>
</html>
```

**Navigation types:**
- Main menu (primary pages)
- Breadcrumbs (current location)
- Footer links (secondary pages)

---

## Activity 4: Image Basics

**Goal:** Add images with proper attributes.

**Create:** `images-basic.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Image Examples</title>
</head>
<body>
    <h1>Barangay Images</h1>
    
    <!-- 1. Basic image -->
    <img src="barangay-logo.png" alt="Barangay Sto. Niño Logo">
    
    <!-- 2. Image with size (prevents layout shift) -->
    <img 
        src="barangay-hall.jpg" 
        alt="Barangay Hall Building" 
        width="600" 
        height="400"
    >
    
    <!-- 3. Image with title (tooltip) -->
    <img 
        src="captain.jpg" 
        alt="Barangay Captain Juan Dela Cruz" 
        title="Kapitan Juan Dela Cruz"
        width="300"
    >
    
    <!-- 4. Lazy loading for performance -->
    <img 
        src="large-photo.jpg" 
        alt="Barangay Event" 
        loading="lazy"
        width="800"
    >
    
    <!-- 5. Decorative image (empty alt) -->
    <img src="decoration.png" alt="" width="100">
</body>
</html>
```

**Critical:** Always include `alt` attribute for accessibility!

---

## Activity 5: Image Paths

**Goal:** Understand absolute vs relative paths.

**File structure:**
```
project/
├── index.html
├── pages/
│   └── about.html
└── images/
    ├── logo.png
    └── photos/
        └── hall.jpg
```

**Create:** `image-paths.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Image Paths</title>
</head>
<body>
    <h1>Image Path Types</h1>
    
    <!-- 1. Relative path (same folder) -->
    <img src="logo.png" alt="Logo">
    
    <!-- 2. Relative path (subfolder) -->
    <img src="images/logo.png" alt="Logo">
    
    <!-- 3. Relative path (parent folder) -->
    <!-- If you're in pages/about.html -->
    <img src="../images/logo.png" alt="Logo">
    
    <!-- 4. Relative path (nested) -->
    <img src="images/photos/hall.jpg" alt="Hall">
    
    <!-- 5. Absolute path (full URL) -->
    <img src="https://example.com/images/logo.png" alt="Logo">
    
    <!-- 6. Root-relative path -->
    <img src="/images/logo.png" alt="Logo">
</body>
</html>
```

**Path rules:**
- `./` = current folder
- `../` = parent folder
- `/` = root folder
- No slash = current folder

---

## Activity 6: Clickable Images (Image Links)

**Goal:** Make images clickable.

**Create:** `image-links.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Clickable Images</title>
</head>
<body>
    <h1>Barangay Officials</h1>
    
    <!-- 1. Image link (opens page) -->
    <a href="captain-profile.html">
        <img 
            src="captain.jpg" 
            alt="Click to view Kapitan profile" 
            width="200"
        >
    </a>
    
    <!-- 2. Image link (opens in new tab) -->
    <a href="https://facebook.com/brgyston" target="_blank" rel="noopener noreferrer">
        <img 
            src="facebook-icon.png" 
            alt="Visit our Facebook page" 
            width="50"
        >
    </a>
    
    <!-- 3. Thumbnail linking to full image -->
    <a href="hall-full.jpg" target="_blank">
        <img 
            src="hall-thumbnail.jpg" 
            alt="Barangay Hall (click for full size)" 
            width="200"
        >
    </a>
    
    <!-- 4. Logo linking to homepage -->
    <a href="index.html">
        <img 
            src="logo.png" 
            alt="Barangay Sto. Niño - Go to Homepage" 
            width="150"
        >
    </a>
</body>
</html>
```

**Best practice:** Describe the link destination in alt text (not just the image).

---

## Activity 7: Complete Barangay Gallery Page

**Goal:** Build a photo gallery with links and images.

**Create:** `gallery.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photo Gallery - Barangay Sto. Niño</title>
    <style>
        /* Basic styling for gallery */
        .gallery {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .gallery-item {
            width: 300px;
        }
        .gallery-item img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav>
        <a href="index.html">Home</a> |
        <a href="about.html">About</a> |
        <a href="services.html">Services</a> |
        <a href="gallery.html">Gallery</a> |
        <a href="contact.html">Contact</a>
    </nav>
    
    <hr>
    
    <h1>Barangay Sto. Niño Photo Gallery</h1>
    <p>Glimpses of our community and activities</p>
    
    <hr>
    
    <h2>Barangay Hall</h2>
    <div class="gallery">
        <div class="gallery-item">
            <a href="images/hall-exterior.jpg" target="_blank">
                <img 
                    src="images/hall-exterior-thumb.jpg" 
                    alt="Barangay Hall exterior view"
                    loading="lazy"
                >
            </a>
            <p>Main entrance of Barangay Hall</p>
        </div>
        
        <div class="gallery-item">
            <a href="images/hall-interior.jpg" target="_blank">
                <img 
                    src="images/hall-interior-thumb.jpg" 
                    alt="Barangay Hall interior"
                    loading="lazy"
                >
            </a>
            <p>Reception area</p>
        </div>
        
        <div class="gallery-item">
            <a href="images/hall-office.jpg" target="_blank">
                <img 
                    src="images/hall-office-thumb.jpg" 
                    alt="Barangay Captain's office"
                    loading="lazy"
                >
            </a>
            <p>Captain's office</p>
        </div>
    </div>
    
    <hr>
    
    <h2>Community Events</h2>
    <div class="gallery">
        <div class="gallery-item">
            <a href="images/event-fiesta.jpg" target="_blank">
                <img 
                    src="images/event-fiesta-thumb.jpg" 
                    alt="Barangay Fiesta celebration"
                    loading="lazy"
                >
            </a>
            <p>Annual Barangay Fiesta 2024</p>
        </div>
        
        <div class="gallery-item">
            <a href="images/event-cleanup.jpg" target="_blank">
                <img 
                    src="images/event-cleanup-thumb.jpg" 
                    alt="Community cleanup drive"
                    loading="lazy"
                >
            </a>
            <p>Coastal cleanup drive</p>
        </div>
        
        <div class="gallery-item">
            <a href="images/event-sports.jpg" target="_blank">
                <img 
                    src="images/event-sports-thumb.jpg" 
                    alt="Barangay sports fest"
                    loading="lazy"
                >
            </a>
            <p>Annual sports fest</p>
        </div>
    </div>
    
    <hr>
    
    <h2>Officials</h2>
    <div class="gallery">
        <div class="gallery-item">
            <a href="officials.html#captain">
                <img 
                    src="images/captain.jpg" 
                    alt="View Captain profile"
                    loading="lazy"
                >
            </a>
            <p><strong>Juan Dela Cruz</strong><br>Barangay Captain</p>
        </div>
        
        <div class="gallery-item">
            <a href="officials.html#kagawad1">
                <img 
                    src="images/kagawad1.jpg" 
                    alt="View Kagawad profile"
                    loading="lazy"
                >
            </a>
            <p><strong>Maria Santos</strong><br>Kagawad</p>
        </div>
    </div>
    
    <hr>
    
    <!-- Footer with social links -->
    <footer>
        <h3>Follow Us</h3>
        <a href="https://facebook.com/brgyston" target="_blank" rel="noopener noreferrer">
            <img src="images/facebook.png" alt="Facebook" width="40">
        </a>
        <a href="https://twitter.com/brgyston" target="_blank" rel="noopener noreferrer">
            <img src="images/twitter.png" alt="Twitter" width="40">
        </a>
        <a href="mailto:brgy.stonino@example.com">
            <img src="images/email.png" alt="Email" width="40">
        </a>
        
        <p>
            <small>&copy; 2025 Barangay Sto. Niño. All rights reserved.</small>
        </p>
    </footer>
</body>
</html>
```

**Features implemented:**
✅ Navigation menu with links  
✅ Image gallery with thumbnails  
✅ Clickable images (full size)  
✅ Lazy loading for performance  
✅ Social media icon links  
✅ Proper alt text for accessibility  
✅ Responsive layout (basic)

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Activity 1: Link Types

**Complete link syntax:**
```html
<a href="URL" target="TARGET" rel="RELATIONSHIP" download="FILENAME" title="TOOLTIP">
    Link Text
</a>
```

**Link types:**

1. **External (absolute URL):**
   ```html
   <a href="https://google.com">Google</a>
   ```

2. **Internal (relative URL):**
   ```html
   <a href="about.html">About</a>
   <a href="pages/contact.html">Contact</a>
   <a href="../index.html">Home</a>
   ```

3. **Email:**
   ```html
   <a href="mailto:email@example.com">Email</a>
   <a href="mailto:email@example.com?subject=Hello&body=Message">Email with subject</a>
   ```

4. **Phone:**
   ```html
   <a href="tel:+639123456789">Call us</a>
   ```

5. **SMS:**
   ```html
   <a href="sms:+639123456789">Text us</a>
   <a href="sms:+639123456789?body=Hello">Text with message</a>
   ```

6. **Download:**
   ```html
   <a href="file.pdf" download>Download</a>
   <a href="file.pdf" download="custom-name.pdf">Download with name</a>
   ```

7. **Anchor (jump to section):**
   ```html
   <a href="#section-id">Jump to section</a>
   <!-- Target -->
   <div id="section-id">Content</div>
   ```

## Activity 2: Link Attributes

**Target values:**
- `_self` - Same tab/window (default)
- `_blank` - New tab/window
- `_parent` - Parent frame
- `_top` - Full window

**Security with `target="_blank"`:**
```html
<!-- ❌ Insecure -->
<a href="https://external.com" target="_blank">Link</a>

<!-- ✅ Secure -->
<a href="https://external.com" target="_blank" rel="noopener noreferrer">Link</a>
```

**Why `rel="noopener noreferrer"`?**
- `noopener` - Prevents new page from accessing `window.opener`
- `noreferrer` - Doesn't send referrer information
- Protects against tabnabbing attacks

**Download attribute:**
```html
<!-- Download with original name -->
<a href="document.pdf" download>Download</a>

<!-- Download with custom name -->
<a href="document.pdf" download="My Document.pdf">Download</a>
```

## Activity 3: Navigation Patterns

**Horizontal menu:**
```html
<nav>
    <a href="index.html">Home</a> |
    <a href="about.html">About</a> |
    <a href="contact.html">Contact</a>
</nav>
```

**List-based menu (recommended):**
```html
<nav>
    <ul>
        <li><a href="index.html">Home</a></li>
        <li><a href="about.html">About</a></li>
        <li><a href="contact.html">Contact</a></li>
    </ul>
</nav>
```

**Breadcrumb navigation:**
```html
<nav aria-label="Breadcrumb">
    <ol>
        <li><a href="/">Home</a></li>
        <li><a href="/services/">Services</a></li>
        <li>Barangay Clearance</li>
    </ol>
</nav>
```

**Active page indicator:**
```html
<nav>
    <a href="index.html">Home</a>
    <a href="about.html" aria-current="page" class="active">About</a>
    <a href="contact.html">Contact</a>
</nav>
```

## Activity 4: Image Attributes

**Complete image syntax:**
```html
<img 
    src="path/to/image.jpg"        <!-- Required: image path -->
    alt="Description"              <!-- Required: accessibility -->
    width="600"                    <!-- Optional: width in pixels -->
    height="400"                   <!-- Optional: height in pixels -->
    loading="lazy"                 <!-- Optional: lazy load -->
    decoding="async"               <!-- Optional: async decode -->
    title="Tooltip"                <!-- Optional: hover text -->
>
```

**Alt text guidelines:**

✅ **Good alt text:**
```html
<img src="captain.jpg" alt="Barangay Captain Juan Dela Cruz standing in front of barangay hall">
<img src="clearance.png" alt="Sample barangay clearance document">
```

❌ **Bad alt text:**
```html
<img src="captain.jpg" alt="image">
<img src="captain.jpg" alt="picture of captain">
<img src="captain.jpg" alt="">  <!-- Only for decorative images -->
```

**When to use empty alt:**
```html
<!-- Decorative images -->
<img src="decoration.png" alt="">

<!-- Image already described in text -->
<p>
    <img src="arrow.png" alt="">
    Click here to continue
</p>
```

**Width/height prevent layout shift:**
```html
<!-- ✅ Good: Browser reserves space -->
<img src="photo.jpg" alt="Photo" width="800" height="600">

<!-- ❌ Bad: Page jumps when image loads -->
<img src="photo.jpg" alt="Photo">
```

## Activity 5: Image Paths

**Path types:**

```
project/
├── index.html
├── pages/
│   └── about.html
└── images/
    ├── logo.png
    └── photos/
        └── hall.jpg
```

**From `index.html`:**
```html
<img src="images/logo.png" alt="Logo">
<img src="images/photos/hall.jpg" alt="Hall">
```

**From `pages/about.html`:**
```html
<img src="../images/logo.png" alt="Logo">
<img src="../images/photos/hall.jpg" alt="Hall">
```

**Absolute URL:**
```html
<img src="https://example.com/images/logo.png" alt="Logo">
```

**Root-relative (from web root):**
```html
<img src="/images/logo.png" alt="Logo">
```

**Path symbols:**
- `./` or none - Current directory
- `../` - Parent directory
- `/` - Root directory
- `../../` - Grandparent directory

## Activity 6: Image Links

**Syntax:**
```html
<a href="destination.html">
    <img src="image.jpg" alt="Description including link destination">
</a>
```

**Best practices:**

✅ **Good: Alt describes link destination:**
```html
<a href="profile.html">
    <img src="captain.jpg" alt="View Captain Juan Dela Cruz profile">
</a>
```

❌ **Bad: Alt only describes image:**
```html
<a href="profile.html">
    <img src="captain.jpg" alt="Photo of captain">
</a>
```

**Common patterns:**

```html
<!-- Logo link to homepage -->
<a href="index.html">
    <img src="logo.png" alt="Barangay Sto. Niño - Home">
</a>

<!-- Thumbnail to full image -->
<a href="full-image.jpg" target="_blank">
    <img src="thumbnail.jpg" alt="View full size photo">
</a>

<!-- Social media icons -->
<a href="https://facebook.com/page" target="_blank" rel="noopener noreferrer">
    <img src="facebook.png" alt="Visit our Facebook page">
</a>
```

## Activity 7: Performance Tips

**Lazy loading:**
```html
<img src="image.jpg" alt="Description" loading="lazy">
```
- Delays loading until image is near viewport
- Improves initial page load
- Use for below-the-fold images

**Image optimization:**
1. **Compress images** (TinyPNG, Squoosh)
2. **Use appropriate formats:**
   - JPEG for photos
   - PNG for graphics/transparency
   - WebP for modern browsers (smaller)
   - SVG for logos/icons
3. **Responsive images:**
   ```html
   <img 
       src="small.jpg" 
       srcset="small.jpg 400w, medium.jpg 800w, large.jpg 1200w"
       sizes="(max-width: 600px) 400px, (max-width: 900px) 800px, 1200px"
       alt="Description"
   >
   ```

**Philippine context:**
- Average mobile speed: 35 Mbps
- Optimize for slower connections
- Lazy load gallery images
- Use thumbnails (200-300px) linking to full size

</details>

---

**Perfect!** You've mastered links and images — your pages are now navigable and visually rich!

**Next:** Tables, forms, and inputs for structured data and user interaction!
