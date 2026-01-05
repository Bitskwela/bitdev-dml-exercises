# Preview Deployments Activity

In this activity, you'll create your first preview deployment! You'll experience how branches create separate preview URLs, allowing you to test changes before they go live.

---

## Prerequisites

Before starting, make sure you have:

- ✅ Completed the previous activity (Git integration)
- ✅ A Vercel project connected to a GitHub repository
- ✅ A working website that's deployed to production

If you need a fresh start, use this simple website:

```html
<!-- index.html -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Preview Test Site</title>
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <header>
      <h1>🌟 My Website</h1>
      <p>Welcome to my preview deployment test!</p>
    </header>
    <main>
      <section class="content">
        <h2>About This Site</h2>
        <p>This is the production version of my website.</p>
      </section>
    </main>
    <footer>
      <p>Version: Production</p>
    </footer>
  </body>
</html>
```

```css
/* style.css */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: "Segoe UI", Arial, sans-serif;
  line-height: 1.6;
  background-color: #f5f5f5;
  color: #333;
}

header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 40px 20px;
  text-align: center;
}

main {
  max-width: 800px;
  margin: 40px auto;
  padding: 0 20px;
}

.content {
  background: white;
  padding: 30px;
  border-radius: 10px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

footer {
  text-align: center;
  padding: 20px;
  background: #333;
  color: white;
  margin-top: 40px;
}
```

---

## Task for Students

### Part 1: Verify Your Production Site

Before creating a preview, let's confirm your production site is working.

**Step 1: Check your production URL**

1. Open your Vercel dashboard
2. Click on your project
3. Find your production URL (e.g., `https://your-site.vercel.app`)

**Step 2: Visit your production site**

Open the URL in your browser and note what you see.

**Your Production URL:** `_________________________________`

**What does the site currently look like?** (Briefly describe):

`_________________________________________________________________`

✅ **Checkpoint:** Production site is working!

---

### Part 2: Create a Feature Branch

Now let's create a new branch for our experimental changes.

**Step 1: Open your terminal in the project folder**

Make sure you're on the main branch and it's up to date:

```bash
git checkout main
git pull origin main
```

**Step 2: Create a new feature branch**

```bash
git checkout -b feature/experimental-design
```

**Step 3: Verify you're on the new branch**

```bash
git branch
```

You should see:

```
  main
* feature/experimental-design
```

✅ **Checkpoint:** New branch created!

---

### Part 3: Make Experimental Changes

Let's make some noticeable changes that we'll preview before going live.

**Step 1: Update the HTML**

In `index.html`, change the header section:

```html
<!-- Find this -->
<header>
  <h1>🌟 My Website</h1>
  <p>Welcome to my preview deployment test!</p>
</header>

<!-- Change it to -->
<header>
  <h1>🚀 My NEW Website Design</h1>
  <p>⚠️ This is a PREVIEW - Not live yet!</p>
</header>
```

Also update the footer:

```html
<!-- Find this -->
<footer>
  <p>Version: Production</p>
</footer>

<!-- Change it to -->
<footer>
  <p>Version: Preview (experimental-design branch)</p>
</footer>
```

**Step 2: Update the CSS colors**

In `style.css`, change the header gradient:

```css
/* Find this */
header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  ...;
}

/* Change it to */
header {
  background: linear-gradient(135deg, #ff6b6b 0%, #ffa500 100%);
  ...;
}
```

**Step 3: Save your files**

Make sure both `index.html` and `style.css` are saved.

✅ **Checkpoint:** Changes made!

---

### Part 4: Push and Create Preview

**Step 1: Check what changed**

```bash
git status
```

You should see both files modified.

**Step 2: Commit your changes**

```bash
git add .
git commit -m "Experimental design: new colors and preview banner"
```

**Step 3: Push the branch to GitHub**

```bash
git push origin feature/experimental-design
```

**Step 4: Wait for Vercel to build**

Vercel automatically detects the new branch and starts building!

✅ **Checkpoint:** Branch pushed!

---

### Part 5: Find Your Preview URL

**Step 1: Open Vercel Dashboard**

Go to [vercel.com](https://vercel.com) and click on your project.

**Step 2: Go to Deployments**

Click the **"Deployments"** tab.

**Step 3: Find the preview deployment**

You should see two deployments:

```
Deployments
───────────
✓ Ready    feature/experimental-design    abc1234    Just now
✓ Ready    main                           xyz9876    Earlier
```

**Step 4: Get the preview URL**

Click on the `feature/experimental-design` deployment.

Copy the preview URL. It should look something like:

```
https://your-project-git-feature-experimental-design-username.vercel.app
```

**Your Preview URL:** `_________________________________`

✅ **Checkpoint:** Preview deployment found!

---

### Part 6: Compare Production vs Preview

Now the fun part—let's see both versions side by side!

**Step 1: Open both URLs**

Open two browser tabs:

1. **Tab 1:** Your production URL (from Part 1)
2. **Tab 2:** Your preview URL (from Part 5)

**Step 2: Compare the differences**

Fill in the comparison:

| Element       | Production          | Preview |
| ------------- | ------------------- | ------- |
| Header Title  | 🌟 My Website       |         |
| Header Colors | Purple gradient     |         |
| Footer Text   | Version: Production |         |

**Step 3: Verify production is unchanged**

Refresh your production URL. It should still show the original design!

✅ **Checkpoint:** Both versions exist simultaneously!

---

### Part 7: Simulate Getting Feedback

In a real scenario, you'd share your preview URL with teammates or stakeholders.

**Practice Exercise:**

Imagine you're messaging a colleague named Neri:

> "Hi Neri! I've been working on a new design for our website. Before I make it live, can you check out this preview and give me feedback? Here's the link: [your preview URL]"

**Based on the preview, write 2 pieces of feedback Neri might give:**

1. `________________________________________________________________`

2. `________________________________________________________________`

---

### Part 8: Make a Follow-up Change

Let's practice the iterative workflow—make another change based on "feedback."

**Step 1: Make an additional change**

Add this to your `style.css`:

```css
/* Add at the bottom */
.content h2 {
  color: #ff6b6b;
  border-bottom: 2px solid #ffa500;
  padding-bottom: 10px;
}
```

**Step 2: Push the update**

```bash
git add style.css
git commit -m "Add accent color to content headings"
git push origin feature/experimental-design
```

**Step 3: Refresh your preview URL**

Wait about 30 seconds for Vercel to rebuild, then refresh your preview URL.

**Question:** Did the same preview URL update with your new changes? ☐ Yes ☐ No

✅ **Checkpoint:** Preview updated with new changes!

---

## Part 9: Knowledge Check

### Question 1: Preview vs Production

What happens to your production website when you push to a feature branch?

- A) It gets updated immediately
- B) It shows an error page
- C) Nothing - production stays unchanged
- D) It shows both versions at once

**Your Answer:** **\_**

---

### Question 2: Preview URL Behavior

When you push more commits to the same feature branch, what happens?

- A) A new preview URL is created each time
- B) The same preview URL updates with new changes
- C) The preview URL stops working
- D) You need to manually refresh the deployment

**Your Answer:** **\_**

---

### Question 3: Going Live

After testing your preview and getting approval, how do you make your changes live?

- A) Delete the preview deployment
- B) Merge the feature branch into main
- C) Copy and paste files to production
- D) Click a "Make Live" button in the preview

**Your Answer:** **\_**

---

### Question 4: Branch Naming

Why is `feature/experimental-design` a better branch name than `test`?

- A) It's shorter and faster to type
- B) It describes what the branch contains
- C) Vercel requires the `feature/` prefix
- D) GitHub rejects branches named `test`

**Your Answer:** **\_**

---

### Question 5: Preview Benefits

Select ALL benefits of using preview deployments:

- ☐ A) Test changes without affecting production
- ☐ B) Share work-in-progress with stakeholders
- ☐ C) Automatically makes websites load faster
- ☐ D) Get feedback before going live
- ☐ E) Try multiple design variations simultaneously

**Your Answer:** **\_**

---

## Part 10: Clean Up (Optional)

If you want to promote your changes to production:

**Option A: Merge via GitHub**

1. Go to your GitHub repository
2. Click "Compare & pull request" for your branch
3. Create a Pull Request
4. Review and click "Merge pull request"
5. Your production site will update automatically!

**Option B: Merge via Command Line**

```bash
git checkout main
git merge feature/experimental-design
git push origin main
```

**Option C: Keep as Preview**

You can leave the branch as-is. The preview will remain available until you delete the branch.

**To delete the branch (after merging or if you don't want it):**

```bash
git checkout main
git branch -d feature/experimental-design
git push origin --delete feature/experimental-design
```

---

## What You Learned

In this activity, you accomplished:

- ✅ **Created a feature branch** for experimental changes
- ✅ **Made visible changes** to test the preview system
- ✅ **Pushed the branch** and watched Vercel create a preview
- ✅ **Found your preview URL** in the Vercel dashboard
- ✅ **Compared production vs preview** side by side
- ✅ **Updated the preview** with additional commits
- ✅ **Understood the feedback workflow** with preview deployments

---

## The Preview Workflow (Summary)

```
┌─────────────────────────────────────────────────────────────┐
│              PREVIEW DEPLOYMENT WORKFLOW                    │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   1. Create a feature branch                                │
│      git checkout -b feature/my-change                      │
│              ↓                                              │
│   2. Make your changes locally                              │
│              ↓                                              │
│   3. Push the branch                                        │
│      git push origin feature/my-change                      │
│              ↓                                              │
│   4. Vercel creates a preview URL automatically             │
│              ↓                                              │
│   5. Share URL → Get feedback → Make fixes → Push again     │
│              ↓                                              │
│   6. When approved, merge to main                           │
│              ↓                                              │
│   7. Production updates automatically! 🎉                   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## Answer Key

**Question 1:** C) Nothing - production stays unchanged

**Question 2:** B) The same preview URL updates with new changes

**Question 3:** B) Merge the feature branch into main

**Question 4:** B) It describes what the branch contains

**Question 5:** A, B, D, E (C is not related to preview deployments)

---

## Bonus Challenges

If you want extra practice:

1. **Create two different feature branches** - See how each gets its own preview URL
2. **Create a Pull Request on GitHub** - Notice how Vercel automatically comments with the preview link
3. **Try the Vercel Comments feature** - Click on the preview and add comments (if enabled)
4. **Promote from Vercel Dashboard** - Use the "Promote to Production" option instead of merging

---

## Next Steps

Congratulations! You now understand how professional developers use preview deployments to safely test changes before going live.

In the next lesson, you'll learn about:

- **Environment Variables** - Storing secrets and configuration
- **Build Settings** - Customizing how Vercel builds your project
- **Domain Configuration** - Adding your own custom domain

See you there! 🚀
