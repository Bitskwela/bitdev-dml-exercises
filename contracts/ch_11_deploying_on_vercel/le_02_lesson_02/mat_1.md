# Le 02: Hosting Static Sites – Your First Deployment

![Static Site Deployment](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/vercel-static.png)

## Background Story

Maria is ready to deploy. She starts simple—a static HTML page for Neri's bakery.

"Before we deploy the blockchain dashboard," Marco advises, "let's deploy something small. Learn the workflow. Then scale up."

The bakery website is just HTML, CSS, and a few images. No backend. No database. Just files that the browser can render directly.

"This is a static site," Marco explains. "The simplest deployment. The browser receives the same files every time. No server processing needed."

Maria builds the bakery page in 20 minutes. Deploying it takes 2 minutes.

"That's it?" Maria asks, staring at `neris-bakery.vercel.app` working perfectly.

"That's deployment," Marco smiles. "Now let's understand what happened."

**Time Allotment**: 40 minutes

**Topics Covered**:

- What is a static site?
- Creating a simple static site
- Deploying via drag-and-drop
- Deploying via Vercel CLI
- Understanding deployment output

---

## What is a Static Site?

A **static site** is a website made of fixed files that don't change based on who visits or when.

```
Static Site:
index.html → Same for everyone
styles.css → Same for everyone
script.js → Same for everyone

Dynamic Site:
/profile → Different for each user
/dashboard → Changes based on data
/feed → Updates in real-time
```

### Static Site Examples

- Personal portfolios
- Business landing pages
- Documentation sites
- Blogs (pre-built)
- Marketing pages

### When to Use Static

| Use Case             | Static?               |
| -------------------- | --------------------- |
| Portfolio website    | ✅ Yes                |
| Company landing page | ✅ Yes                |
| Blog with 100 posts  | ✅ Yes (pre-built)    |
| Social media feed    | ❌ No (dynamic)       |
| User dashboard       | ❌ No (personalized)  |
| E-commerce cart      | ❌ No (session-based) |

Neri's bakery website is perfect for static deployment—menu, photos, contact info. It's the same for every visitor.

## Creating a Static Site

Let's build a simple site for Neri's bakery:

### Project Structure

```
neris-bakery/
├── index.html
├── styles.css
├── menu.html
└── images/
    ├── logo.png
    └── pandesal.jpg
```

### index.html

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Neri's Bakery - Fresh Bread Daily</title>
    <link rel="stylesheet" href="styles.css" />
  </head>
  <body>
    <header>
      <h1>🍞 Neri's Bakery</h1>
      <p>Fresh pandesal since 1985 | San Juan, Metro Manila</p>
    </header>

    <main>
      <section class="hero">
        <h2>Wake Up to Fresh Bread</h2>
        <p>Hot pandesal ready at 5 AM every morning</p>
        <a href="menu.html" class="btn">View Our Menu</a>
      </section>

      <section class="contact">
        <h3>Visit Us</h3>
        <p>123 Barangay Street, San Juan, Metro Manila</p>
        <p>Open: 5 AM - 9 PM daily</p>
        <p>Tel: (02) 8123-4567</p>
      </section>
    </main>

    <footer>
      <p>© 2024 Neri's Bakery. Made with ❤️ in the Philippines</p>
    </footer>
  </body>
</html>
```

### styles.css

```css
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: "Segoe UI", Arial, sans-serif;
  line-height: 1.6;
  color: #333;
}

header {
  background: #8b4513;
  color: white;
  text-align: center;
  padding: 2rem;
}

.hero {
  text-align: center;
  padding: 4rem 2rem;
  background: #fff8dc;
}

.btn {
  display: inline-block;
  background: #8b4513;
  color: white;
  padding: 1rem 2rem;
  text-decoration: none;
  border-radius: 5px;
  margin-top: 1rem;
}

.contact {
  padding: 2rem;
  background: white;
  text-align: center;
}

footer {
  background: #333;
  color: white;
  text-align: center;
  padding: 1rem;
}
```

## Method 1: Drag-and-Drop Deployment

The simplest way to deploy—no command line needed.

### Steps

1. Go to [vercel.com/new](https://vercel.com/new)
2. Scroll down to "Import Third-Party Git Repository" section
3. Or better: drag your project folder directly onto the page
4. Wait for upload and build
5. Get your URL!

```
Upload complete!
🎉 Your site is live at: https://neris-bakery.vercel.app
```

### What Happened?

1. Vercel received your files
2. Detected it's a static site (no package.json)
3. Deployed files to global CDN
4. Generated a unique URL
5. Configured HTTPS automatically

## Method 2: Vercel CLI Deployment

For developers who prefer the terminal:

```bash
# Navigate to your project
cd neris-bakery

# Deploy
vercel

# Follow prompts:
# ? Set up and deploy? [Y/n] Y
# ? Which scope? your-username
# ? Link to existing project? [y/N] N
# ? What's your project's name? neris-bakery
# ? In which directory is your code located? ./

# Output:
# 🔗 Linked to yourname/neris-bakery
# 🔍 Inspect: https://vercel.com/yourname/neris-bakery/abc123
# ✅ Production: https://neris-bakery.vercel.app
```

Your site is now live!

## Understanding Deployment Output

When Vercel deploys, you get several URLs:

```
🔗 Linked to: yourname/neris-bakery
   └── Your project in Vercel dashboard

🔍 Inspect: https://vercel.com/yourname/neris-bakery/abc123
   └── Build logs, deployment details

✅ Preview: https://neris-bakery-abc123.vercel.app
   └── This specific deployment

✅ Production: https://neris-bakery.vercel.app
   └── Your main URL (always latest)
```

## Viewing Your Deployment

### Check the Live Site

Open your browser and visit the URL:

```
https://neris-bakery.vercel.app
```

Your site is now accessible from:

- Your laptop in Manila
- Marco's phone in Cebu
- A tourist's tablet in Tokyo
- Anyone, anywhere with internet

### Check the Dashboard

Visit [vercel.com/dashboard](https://vercel.com/dashboard) to see:

- All your projects
- Deployment history
- Analytics
- Logs

## Making Updates

Changed something? Redeploy!

```bash
# Edit index.html...
# Add new content...

# Redeploy
vercel

# New version is live in seconds!
```

Each deployment gets a unique URL, so you can compare versions:

```
v1: https://neris-bakery-abc123.vercel.app
v2: https://neris-bakery-def456.vercel.app
Production: https://neris-bakery.vercel.app (always latest)
```

## Deployment Settings

For static sites, Vercel auto-detects settings. But you can customize:

### vercel.json

```json
{
  "cleanUrls": true,
  "trailingSlash": false
}
```

- `cleanUrls`: Removes `.html` from URLs (`/menu` instead of `/menu.html`)
- `trailingSlash`: Controls trailing slash behavior

## Common Static Site Issues

### Issue: Images Not Loading

```html
<!-- Wrong: Absolute path -->
<img src="/Users/maria/images/logo.png" />

<!-- Right: Relative path -->
<img src="images/logo.png" />

<!-- Right: Root-relative path -->
<img src="/images/logo.png" />
```

### Issue: CSS Not Applied

```html
<!-- Wrong: Wrong path -->
<link rel="stylesheet" href="C:/projects/styles.css" />

<!-- Right: Relative path -->
<link rel="stylesheet" href="styles.css" />
```

### Issue: 404 on Subpages

Make sure all HTML files are included in your deployment folder.

## The Global Reach

Neri's bakery site is now on Vercel's global CDN:

```
User in Manila → Singapore server → 20ms load time
User in London → Frankfurt server → 30ms load time
User in New York → Virginia server → 25ms load time
```

No matter where visitors are, they get fast load times because the site is served from a nearby edge location.

## Why This Matters: Beyond the Islands

Before deployment:

- Neri's bakery info exists on flyers in San Juan
- Only locals know about it
- No way to reach tourists

After deployment:

- `neris-bakery.vercel.app` is searchable globally
- Tourists can find it before their trip
- International food bloggers can review it
- Potential franchise partners can discover it

A simple HTML page becomes a global presence.

## Key Takeaways

✓ Static sites are fixed files—same for everyone
✓ Perfect for portfolios, landing pages, documentation
✓ Deploy via drag-and-drop or CLI
✓ Each deployment gets a unique URL
✓ Production URL always shows latest version
✓ Vercel's CDN makes sites fast globally
✓ Updates deploy in seconds

**Next Lesson:** Connecting your Git repository for automatic deployments!
