# Lesson 11 Activities: Semantic HTML

## Building Meaningful Web Structure

Master semantic HTML5 elements to create accessible, SEO-friendly websites!

---

## Activity 1: Div Soup vs Semantic HTML

**Goal:** Understand the difference between non-semantic and semantic markup.

**Create:** `semantic-comparison.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Semantic HTML Comparison</title>
    <style>
        .comparison { display: flex; gap: 20px; }
        .example { flex: 1; padding: 20px; border: 2px solid #ddd; }
        .bad { border-color: #f44336; }
        .good { border-color: #4CAF50; }
    </style>
</head>
<body>
    <h1>Semantic HTML Comparison</h1>
    
    <div class="comparison">
        <!-- ❌ Bad: Div soup (non-semantic) -->
        <div class="example bad">
            <h2>❌ Non-Semantic (Div Soup)</h2>
            <div class="header">
                <div class="logo">Barangay Sto. Niño</div>
                <div class="navigation">
                    <div class="nav-item">Home</div>
                    <div class="nav-item">Services</div>
                    <div class="nav-item">Contact</div>
                </div>
            </div>
            
            <div class="main-content">
                <div class="article">
                    <div class="article-title">Welcome</div>
                    <div class="article-content">Content here...</div>
                </div>
                
                <div class="sidebar">
                    <div class="widget">Latest news</div>
                </div>
            </div>
            
            <div class="footer">
                <div class="copyright">© 2025</div>
            </div>
        </div>
        
        <!-- ✅ Good: Semantic HTML5 -->
        <div class="example good">
            <h2>✅ Semantic HTML5</h2>
            <header>
                <h1>Barangay Sto. Niño</h1>
                <nav>
                    <ul>
                        <li>Home</li>
                        <li>Services</li>
                        <li>Contact</li>
                    </ul>
                </nav>
            </header>
            
            <main>
                <article>
                    <h2>Welcome</h2>
                    <p>Content here...</p>
                </article>
                
                <aside>
                    <section>
                        <h3>Latest News</h3>
                    </section>
                </aside>
            </main>
            
            <footer>
                <p><small>© 2025</small></p>
            </footer>
        </div>
    </div>
    
    <h2>Benefits of Semantic HTML:</h2>
    <ul>
        <li><strong>Accessibility:</strong> Screen readers understand page structure</li>
        <li><strong>SEO:</strong> Search engines rank semantic content higher</li>
        <li><strong>Maintainability:</strong> Easier for developers to understand</li>
        <li><strong>Future-proof:</strong> Standards-compliant code</li>
    </ul>
</body>
</html>
```

---

## Activity 2: Semantic Structure Elements

**Goal:** Learn all HTML5 semantic elements.

**Create:** `semantic-elements.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Semantic Elements</title>
    <style>
        header { background: #4CAF50; color: white; padding: 20px; }
        nav { background: #333; color: white; padding: 10px; }
        main { min-height: 400px; padding: 20px; }
        article { background: #f9f9f9; padding: 15px; margin: 10px 0; }
        section { border-left: 4px solid #4CAF50; padding-left: 10px; margin: 10px 0; }
        aside { background: #e7e7e7; padding: 15px; margin: 10px 0; }
        footer { background: #333; color: white; padding: 20px; text-align: center; }
    </style>
</head>
<body>
    <!-- HEADER: Site header with logo, navigation -->
    <header>
        <h1>Barangay Sto. Niño</h1>
        <p>Serving the community since 1952</p>
    </header>
    
    <!-- NAV: Navigation menu -->
    <nav>
        <ul>
            <li><a href="#home">Home</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="#services">Services</a></li>
            <li><a href="#contact">Contact</a></li>
        </ul>
    </nav>
    
    <!-- MAIN: Primary content (only ONE per page) -->
    <main>
        <!-- ARTICLE: Self-contained content (blog post, news article) -->
        <article>
            <h2>Latest Announcement</h2>
            <p><time datetime="2025-12-04">December 4, 2025</time></p>
            <p>Office hours extended until 6 PM during December.</p>
        </article>
        
        <!-- SECTION: Thematic grouping of content -->
        <section id="services">
            <h2>Our Services</h2>
            
            <article>
                <h3>Barangay Clearance</h3>
                <p>Required for employment and transactions.</p>
            </article>
            
            <article>
                <h3>Barangay ID</h3>
                <p>Official identification for residents.</p>
            </article>
        </section>
        
        <!-- ASIDE: Related but tangential content (sidebar) -->
        <aside>
            <h3>Quick Links</h3>
            <ul>
                <li><a href="#forms">Download Forms</a></li>
                <li><a href="#fees">Fee Schedule</a></li>
                <li><a href="#hours">Office Hours</a></li>
            </ul>
        </aside>
        
        <!-- FIGURE: Self-contained content with caption -->
        <figure>
            <img src="barangay-hall.jpg" alt="Barangay Hall" width="400">
            <figcaption>Barangay Sto. Niño Hall - Main entrance</figcaption>
        </figure>
        
        <!-- DETAILS: Disclosure widget (expandable) -->
        <details>
            <summary>How to apply for clearance?</summary>
            <ol>
                <li>Fill out application form</li>
                <li>Submit requirements</li>
                <li>Pay fee</li>
                <li>Claim clearance</li>
            </ol>
        </details>
    </main>
    
    <!-- FOOTER: Site footer with copyright, links -->
    <footer>
        <address>
            <strong>Barangay Sto. Niño Hall</strong><br>
            P. Burgos Street, Batangas City<br>
            Phone: <a href="tel:+6343123 4567">043-123-4567</a><br>
            Email: <a href="mailto:brgy.stonino@example.com">brgy.stonino@example.com</a>
        </address>
        <p><small>&copy; 2025 Barangay Sto. Niño. All rights reserved.</small></p>
    </footer>
</body>
</html>
```

---

## Activity 3: Article vs Section

**Goal:** Understand when to use `<article>` vs `<section>`.

**Create:** `article-vs-section.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Article vs Section</title>
</head>
<body>
    <h1>Article vs Section</h1>
    
    <!-- ARTICLE: Standalone content (can be distributed independently) -->
    <h2>Use ARTICLE for:</h2>
    <ul>
        <li>Blog posts</li>
        <li>News articles</li>
        <li>Forum posts</li>
        <li>Comments</li>
        <li>Product cards</li>
    </ul>
    
    <article>
        <h3>Barangay Celebrates Fiesta</h3>
        <p><time datetime="2025-11-15">November 15, 2025</time></p>
        <p>The annual fiesta was celebrated with games, food, and entertainment...</p>
        <p><a href="article1.html">Read more</a></p>
    </article>
    
    <article>
        <h3>New Barangay Hall Inaugurated</h3>
        <p><time datetime="2025-10-10">October 10, 2025</time></p>
        <p>The newly renovated barangay hall was officially opened...</p>
        <p><a href="article2.html">Read more</a></p>
    </article>
    
    <hr>
    
    <!-- SECTION: Thematic grouping (chapters of content) -->
    <h2>Use SECTION for:</h2>
    <ul>
        <li>Chapters</li>
        <li>Tabs</li>
        <li>Thematic groups</li>
        <li>Parts of an article</li>
    </ul>
    
    <article>
        <h3>Complete Guide to Barangay Services</h3>
        
        <section>
            <h4>Document Services</h4>
            <p>Information about clearances, IDs, and certificates...</p>
        </section>
        
        <section>
            <h4>Health Services</h4>
            <p>Medical assistance and health programs...</p>
        </section>
        
        <section>
            <h4>Educational Programs</h4>
            <p>Scholarships and training opportunities...</p>
        </section>
    </article>
    
    <hr>
    
    <!-- COMBINATION: Sections containing articles -->
    <h2>Sections can contain Articles:</h2>
    
    <section id="announcements">
        <h3>Latest Announcements</h3>
        
        <article>
            <h4>Office Hours Extended</h4>
            <p>December hours: 8 AM - 6 PM</p>
        </article>
        
        <article>
            <h4>Holiday Schedule</h4>
            <p>Closed on December 25-26, 2025</p>
        </article>
    </section>
</body>
</html>
```

**Rule of thumb:** If content makes sense on its own (RSS feed, social media), use `<article>`. If it's a thematic grouping, use `<section>`.

---

## Activity 4: Navigation Patterns

**Goal:** Create accessible navigation with `<nav>`.

**Create:** `navigation-semantic.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Semantic Navigation</title>
</head>
<body>
    <!-- 1. Main Navigation -->
    <nav aria-label="Main navigation">
        <ul>
            <li><a href="index.html">Home</a></li>
            <li><a href="about.html">About</a></li>
            <li><a href="services.html">Services</a></li>
            <li><a href="contact.html">Contact</a></li>
        </ul>
    </nav>
    
    <main>
        <h1>Barangay Services</h1>
        
        <!-- 2. Breadcrumb Navigation -->
        <nav aria-label="Breadcrumb">
            <ol>
                <li><a href="index.html">Home</a></li>
                <li><a href="services.html">Services</a></li>
                <li aria-current="page">Barangay Clearance</li>
            </ol>
        </nav>
        
        <!-- 3. Table of Contents -->
        <nav aria-label="Table of contents">
            <h2>On this page:</h2>
            <ul>
                <li><a href="#requirements">Requirements</a></li>
                <li><a href="#process">Application Process</a></li>
                <li><a href="#fees">Fees</a></li>
                <li><a href="#faq">FAQs</a></li>
            </ul>
        </nav>
        
        <section id="requirements">
            <h2>Requirements</h2>
            <p>Content...</p>
        </section>
        
        <section id="process">
            <h2>Application Process</h2>
            <p>Content...</p>
        </section>
    </main>
    
    <!-- 4. Footer Navigation -->
    <footer>
        <nav aria-label="Footer navigation">
            <ul>
                <li><a href="privacy.html">Privacy Policy</a></li>
                <li><a href="terms.html">Terms of Service</a></li>
                <li><a href="sitemap.html">Sitemap</a></li>
            </ul>
        </nav>
    </footer>
</body>
</html>
```

**Accessibility tip:** Use `aria-label` when you have multiple `<nav>` elements.

---

## Activity 5: Complete Semantic Page

**Goal:** Build a fully semantic barangay website page.

**Create:** `semantic-complete.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Sto. Niño - Official Website</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; line-height: 1.6; }
        header { background: #4CAF50; color: white; padding: 20px; text-align: center; }
        nav { background: #333; }
        nav ul { list-style: none; display: flex; justify-content: center; }
        nav li { margin: 0 15px; }
        nav a { color: white; text-decoration: none; padding: 10px; display: block; }
        nav a:hover { background: #555; }
        main { max-width: 1200px; margin: 20px auto; padding: 0 20px; display: grid; grid-template-columns: 2fr 1fr; gap: 20px; }
        article { background: #f9f9f9; padding: 20px; margin-bottom: 20px; }
        aside { background: #e7e7e7; padding: 20px; height: fit-content; }
        footer { background: #333; color: white; padding: 20px; text-align: center; margin-top: 40px; }
        .full-width { grid-column: 1 / -1; }
    </style>
</head>
<body>
    <!-- Site Header -->
    <header>
        <h1>Barangay Sto. Niño</h1>
        <p>Serving the community with integrity and excellence since 1952</p>
    </header>
    
    <!-- Main Navigation -->
    <nav aria-label="Main navigation">
        <ul>
            <li><a href="index.html" aria-current="page">Home</a></li>
            <li><a href="about.html">About Us</a></li>
            <li><a href="services.html">Services</a></li>
            <li><a href="officials.html">Officials</a></li>
            <li><a href="announcements.html">Announcements</a></li>
            <li><a href="contact.html">Contact</a></li>
        </ul>
    </nav>
    
    <!-- Main Content Area -->
    <main>
        <!-- Welcome Section -->
        <section class="full-width">
            <h2>Welcome to Barangay Sto. Niño</h2>
            <p>
                Barangay Sto. Niño is a vibrant community in Batangas City, serving over 
                5,000 residents with dedication and transparency. Our barangay government 
                is committed to providing excellent public services and fostering a safe, 
                progressive community.
            </p>
        </section>
        
        <!-- Main Content Column -->
        <div>
            <!-- Latest News Articles -->
            <section>
                <h2>Latest News</h2>
                
                <article>
                    <header>
                        <h3>Extended Office Hours for December</h3>
                        <p>
                            <time datetime="2025-12-01">December 1, 2025</time> | 
                            Posted by <span>Admin</span>
                        </p>
                    </header>
                    <p>
                        To better serve our constituents during the holiday season, 
                        the barangay hall will extend office hours until 6:00 PM 
                        throughout December.
                    </p>
                    <footer>
                        <a href="news1.html">Read more →</a>
                    </footer>
                </article>
                
                <article>
                    <header>
                        <h3>Free Medical Mission This Saturday</h3>
                        <p>
                            <time datetime="2025-11-28">November 28, 2025</time> | 
                            Posted by <span>Health Team</span>
                        </p>
                    </header>
                    <p>
                        Join us for a free medical and dental mission this Saturday, 
                        December 7, from 8 AM to 12 PM at the barangay covered court. 
                        First come, first served!
                    </p>
                    <footer>
                        <a href="news2.html">Read more →</a>
                    </footer>
                </article>
                
                <article>
                    <header>
                        <h3>Barangay Assembly Meeting Minutes</h3>
                        <p>
                            <time datetime="2025-11-20">November 20, 2025</time> | 
                            Posted by <span>Secretary</span>
                        </p>
                    </header>
                    <p>
                        The quarterly barangay assembly was successfully held with 
                        over 200 residents in attendance. Key topics discussed 
                        included infrastructure projects and new programs.
                    </p>
                    <footer>
                        <a href="news3.html">Read more →</a>
                    </footer>
                </article>
            </section>
            
            <!-- Services Overview -->
            <section>
                <h2>Our Services</h2>
                
                <article>
                    <h3>Document Services</h3>
                    <ul>
                        <li>Barangay Clearance</li>
                        <li>Barangay ID</li>
                        <li>Community Tax Certificate (Cedula)</li>
                        <li>Business Permit</li>
                        <li>Indigency Certificate</li>
                    </ul>
                    <p><a href="services.html#documents">View all document services →</a></p>
                </article>
            </section>
        </div>
        
        <!-- Sidebar Column -->
        <aside>
            <!-- Quick Links -->
            <section>
                <h3>Quick Links</h3>
                <nav aria-label="Quick links">
                    <ul>
                        <li><a href="forms.html">Download Forms</a></li>
                        <li><a href="fees.html">Fee Schedule</a></li>
                        <li><a href="hours.html">Office Hours</a></li>
                        <li><a href="hotlines.html">Emergency Hotlines</a></li>
                    </ul>
                </nav>
            </section>
            
            <!-- Office Hours -->
            <section>
                <h3>Office Hours</h3>
                <dl>
                    <dt>Monday - Friday</dt>
                    <dd>8:00 AM - 5:00 PM</dd>
                    
                    <dt>Saturday</dt>
                    <dd>8:00 AM - 12:00 PM</dd>
                    
                    <dt>Sunday & Holidays</dt>
                    <dd>Closed</dd>
                </dl>
            </section>
            
            <!-- Contact Info -->
            <section>
                <h3>Contact Us</h3>
                <address>
                    <strong>Barangay Sto. Niño Hall</strong><br>
                    P. Burgos Street<br>
                    Batangas City, Batangas<br>
                    <br>
                    <strong>Phone:</strong> <a href="tel:+6343123 4567">043-123-4567</a><br>
                    <strong>Mobile:</strong> <a href="tel:+639123456789">0912-345-6789</a><br>
                    <strong>Email:</strong> <a href="mailto:brgy.stonino@example.com">brgy.stonino@example.com</a>
                </address>
            </section>
            
            <!-- Expandable FAQ -->
            <section>
                <h3>Frequently Asked Questions</h3>
                
                <details>
                    <summary>How long does clearance processing take?</summary>
                    <p>Regular processing is same-day. Rush processing (2 hours) is available for an additional fee.</p>
                </details>
                
                <details>
                    <summary>What are the requirements for barangay ID?</summary>
                    <p>Valid government ID, two 1x1 photos, and proof of residency.</p>
                </details>
                
                <details>
                    <summary>Do you accept online applications?</summary>
                    <p>Yes! Visit our online portal at <a href="https://portal.brgystonino.gov.ph">portal.brgystonino.gov.ph</a></p>
                </details>
            </section>
        </aside>
    </main>
    
    <!-- Site Footer -->
    <footer>
        <section>
            <h3>About Barangay Sto. Niño</h3>
            <p>
                Established in 1952, Barangay Sto. Niño is committed to transparent 
                governance and quality public service.
            </p>
        </section>
        
        <!-- Footer Navigation -->
        <nav aria-label="Footer navigation">
            <ul style="list-style: none; display: flex; justify-content: center; margin: 20px 0;">
                <li style="margin: 0 10px;"><a href="privacy.html" style="color: white;">Privacy Policy</a></li>
                <li style="margin: 0 10px;"><a href="terms.html" style="color: white;">Terms of Service</a></li>
                <li style="margin: 0 10px;"><a href="sitemap.html" style="color: white;">Sitemap</a></li>
                <li style="margin: 0 10px;"><a href="accessibility.html" style="color: white;">Accessibility</a></li>
            </ul>
        </nav>
        
        <p>
            <small>
                &copy; 2025 Barangay Sto. Niño. All rights reserved.<br>
                Last updated: <time datetime="2025-12-04">December 4, 2025</time>
            </small>
        </p>
    </footer>
</body>
</html>
```

**Features implemented:**
✅ `<header>` for site header  
✅ `<nav>` for navigation with `aria-label`  
✅ `<main>` for primary content  
✅ `<article>` for independent content  
✅ `<section>` for thematic grouping  
✅ `<aside>` for sidebar content  
✅ `<footer>` for site footer  
✅ `<address>` for contact information  
✅ `<time>` for dates with `datetime`  
✅ `<details>`/`<summary>` for expandable content  
✅ Proper heading hierarchy  
✅ Accessible navigation patterns

---

## Activity 6: Accessibility Testing

**Goal:** Test your semantic HTML with accessibility tools.

**Instructions:**

1. **Use Lighthouse (Chrome DevTools):**
   - Open DevTools (F12)
   - Go to "Lighthouse" tab
   - Check "Accessibility"
   - Click "Analyze page load"
   - Target score: 90+

2. **Use WAVE Browser Extension:**
   - Install WAVE extension
   - Visit your page
   - Click WAVE icon
   - Check for errors (aim for 0)

3. **Use Screen Reader:**
   - Windows: Enable Narrator (Win + Ctrl + Enter)
   - Mac: Enable VoiceOver (Cmd + F5)
   - Navigate page with Tab key
   - Does structure make sense?

4. **Keyboard Navigation Test:**
   - Use only Tab, Enter, Arrow keys
   - Can you access all content?
   - Is focus visible?

---

## Activity 7: Refactoring Exercise

**Goal:** Convert non-semantic HTML to semantic HTML.

**Given (bad code):**
```html
<div class="header">
    <div class="logo">Barangay Site</div>
    <div class="menu">
        <div class="menu-item">Home</div>
        <div class="menu-item">About</div>
    </div>
</div>

<div class="content">
    <div class="post">
        <div class="post-title">News Title</div>
        <div class="post-date">Dec 4, 2025</div>
        <div class="post-content">Content...</div>
    </div>
    
    <div class="sidebar">
        <div class="widget">Widget content</div>
    </div>
</div>

<div class="footer">
    <div class="copyright">© 2025</div>
</div>
```

**Your task:** Refactor to semantic HTML.

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Semantic HTML5 Elements

**Document structure:**
```html
<header>      <!-- Site/page header -->
<nav>         <!-- Navigation menu -->
<main>        <!-- Main content (only ONE per page) -->
<article>     <!-- Self-contained content -->
<section>     <!-- Thematic grouping -->
<aside>       <!-- Sidebar/tangential content -->
<footer>      <!-- Site/page footer -->
```

**Content elements:**
```html
<figure>      <!-- Image with caption -->
<figcaption>  <!-- Caption for figure -->
<details>     <!-- Expandable disclosure -->
<summary>     <!-- Summary for details -->
<mark>        <!-- Highlighted text -->
<time>        <!-- Date/time -->
<address>     <!-- Contact information -->
```

## When to Use Each Element

**`<header>`:**
- Site header with logo
- Page header
- Article header
- Can have multiple per page

**`<nav>`:**
- Main navigation
- Breadcrumbs
- Table of contents
- Footer links
- Use `aria-label` for multiple navs

**`<main>`:**
- Primary content of page
- **Only ONE per page**
- Excludes header, footer, nav, aside

**`<article>`:**
- Blog posts
- News articles
- Forum posts
- Comments
- Product cards
- **Test:** Can it stand alone? (RSS feed, social media)

**`<section>`:**
- Thematic grouping
- Chapters
- Tabs
- Parts of article
- Should have a heading

**`<aside>`:**
- Sidebars
- Pull quotes
- Advertisements
- Related links
- Tangential content

**`<footer>`:**
- Site footer
- Article footer
- Copyright info
- Can have multiple per page

## Article vs Section

**Use `<article>` when:**
- Content is independent
- Makes sense in RSS feed
- Can be distributed separately
- Syndicated content

**Use `<section>` when:**
- Thematic grouping
- Chapters of content
- Tabs in interface
- Part of larger whole

**Examples:**
```html
<!-- ✅ Article (independent) -->
<article>
    <h2>Barangay Event Report</h2>
    <p>Full story here...</p>
</article>

<!-- ✅ Section (thematic group) -->
<section id="services">
    <h2>Our Services</h2>
    <!-- List of services -->
</section>

<!-- ✅ Sections inside article -->
<article>
    <h2>Complete Service Guide</h2>
    
    <section>
        <h3>Document Services</h3>
        <p>...</p>
    </section>
    
    <section>
        <h3>Health Services</h3>
        <p>...</p>
    </section>
</article>

<!-- ✅ Articles inside section -->
<section id="news">
    <h2>Latest News</h2>
    
    <article>
        <h3>Event 1</h3>
        <p>...</p>
    </article>
    
    <article>
        <h3>Event 2</h3>
        <p>...</p>
    </article>
</section>
```

## Accessibility Benefits

**Screen readers:**
- Understand page structure
- Navigate by landmarks
- Skip to main content
- Jump between sections

**Keyboard navigation:**
- Tab through interactive elements
- Skip links work better
- Focus management

**SEO benefits:**
- Search engines understand content hierarchy
- Semantic tags boost ranking
- Featured snippets more likely

**Lighthouse scoring:**
- Semantic HTML improves score
- Proper heading hierarchy
- ARIA landmarks automatic

## Refactoring Exercise Answer

**Original (bad):**
```html
<div class="header">
    <div class="logo">Barangay Site</div>
    <div class="menu">
        <div class="menu-item">Home</div>
        <div class="menu-item">About</div>
    </div>
</div>
```

**Refactored (good):**
```html
<header>
    <h1>Barangay Site</h1>
    <nav aria-label="Main navigation">
        <ul>
            <li><a href="index.html">Home</a></li>
            <li><a href="about.html">About</a></li>
        </ul>
    </nav>
</header>

<main>
    <article>
        <header>
            <h2>News Title</h2>
            <p><time datetime="2025-12-04">December 4, 2025</time></p>
        </header>
        <p>Content...</p>
    </article>
    
    <aside>
        <section>
            <h3>Widget Title</h3>
            <p>Widget content</p>
        </section>
    </aside>
</main>

<footer>
    <p><small>&copy; 2025 Barangay Sto. Niño</small></p>
</footer>
```

## Common Mistakes

❌ **Multiple `<main>` tags:**
```html
<!-- Wrong -->
<main>Content 1</main>
<main>Content 2</main>

<!-- Correct -->
<main>
    <section>Content 1</section>
    <section>Content 2</section>
</main>
```

❌ **Section without heading:**
```html
<!-- Wrong -->
<section>
    <p>Content without heading</p>
</section>

<!-- Correct -->
<section>
    <h2>Section Heading</h2>
    <p>Content with heading</p>
</section>
```

❌ **Using semantic tags for styling only:**
```html
<!-- Wrong -->
<article>  <!-- Just because you want a box -->
    <p>Random content</p>
</article>

<!-- Correct -->
<div class="box">  <!-- Use div for styling -->
    <p>Random content</p>
</div>
```

## Philippine Barangay Context

**Typical page structure:**
```html
<header>
    <h1>Barangay Name</h1>
    <nav>Main menu</nav>
</header>

<main>
    <section id="announcements">
        <h2>Announcements</h2>
        <article>Event 1</article>
        <article>Event 2</article>
    </section>
    
    <section id="services">
        <h2>Services</h2>
        <!-- Service list -->
    </section>
    
    <aside>
        <section id="officials">
            <h3>Officials</h3>
            <!-- Official list -->
        </section>
        
        <section id="contact">
            <h3>Contact</h3>
            <address>...</address>
        </section>
    </aside>
</main>

<footer>
    <nav>Footer links</nav>
    <p>Copyright</p>
</footer>
```

</details>

---

**Excellent!** You've mastered semantic HTML5 — your websites are now accessible, SEO-friendly, and future-proof!

**Next:** CSS introduction and linking methods!
