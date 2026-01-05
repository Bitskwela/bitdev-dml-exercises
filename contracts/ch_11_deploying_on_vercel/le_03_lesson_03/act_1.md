# Git Integration Activity

In this activity, you'll connect your GitHub repository to Vercel and experience the magic of automatic deployments. No more manual uploads—just push your code and watch it go live!

---

## Prerequisites

Before starting, make sure you have:

- ✅ A GitHub account
- ✅ Git installed on your computer
- ✅ A Vercel account
- ✅ A simple website project (HTML/CSS/JS)

If you don't have a project ready, create a simple one:

```html
<!-- index.html -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My Auto-Deploy Site</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        max-width: 600px;
        margin: 50px auto;
        padding: 20px;
        text-align: center;
      }
      h1 {
        color: #333;
      }
      .version {
        background: #f0f0f0;
        padding: 10px;
        border-radius: 5px;
        margin-top: 20px;
      }
    </style>
  </head>
  <body>
    <h1>🚀 Auto-Deploy Test</h1>
    <p>This site automatically deploys when I push to GitHub!</p>
    <div class="version"><strong>Version:</strong> 1.0.0</div>
  </body>
</html>
```

---

## Task for Students

### Part 1: Create and Push a GitHub Repository

**Step 1: Create a new repository on GitHub**

1. Go to [github.com](https://github.com) and log in
2. Click the **"+"** button → **"New repository"**
3. Fill in the details:
   - Repository name: `auto-deploy-test`
   - Description: "Testing automatic deployments with Vercel"
   - Visibility: Public (or Private if you prefer)
   - ❌ Do NOT initialize with README (we'll push our own files)
4. Click **"Create repository"**

**Step 2: Push your local project to GitHub**

Open your terminal in your project folder and run:

```bash
# Initialize git (if not already done)
git init

# Add all files
git add .

# Create your first commit
git commit -m "Initial commit - Auto-deploy test site"

# Add the remote repository (replace with YOUR username)
git remote add origin https://github.com/YOUR-USERNAME/auto-deploy-test.git

# Push to GitHub
git branch -M main
git push -u origin main
```

**Step 3: Verify your code is on GitHub**

Visit your repository on GitHub. You should see your `index.html` file there.

✅ **Checkpoint:** Your code is now on GitHub!

---

### Part 2: Connect Your Repository to Vercel

**Step 1: Start a new Vercel project**

1. Go to [vercel.com](https://vercel.com) and log in
2. Click **"Add New..."** → **"Project"**

**Step 2: Connect GitHub (if first time)**

1. Click **"Continue with GitHub"**
2. Authorize Vercel to access your repositories
3. Choose **"Only select repositories"** and select `auto-deploy-test`
4. Click **"Install"**

**Step 3: Import your repository**

1. Find `auto-deploy-test` in the list
2. Click **"Import"**

**Step 4: Configure and deploy**

1. Project Name: Leave as default or customize
2. Framework Preset: **Other**
3. Root Directory: Leave as `./`
4. Click **"Deploy"**

**Step 5: Wait for the initial deployment**

Watch the build logs as Vercel:

- Clones your repository
- Processes your files
- Deploys to production

✅ **Checkpoint:** Your site is now live! Note down your production URL.

**Your Production URL:** `https://_____________________.vercel.app`

---

### Part 3: Trigger Automatic Deployment

Now for the exciting part—let's make a change and watch it auto-deploy!

**Step 1: Make a change to your website**

Open `index.html` and update the version number:

```html
<!-- Find this line -->
<div class="version"><strong>Version:</strong> 1.0.0</div>

<!-- Change it to -->
<div class="version"><strong>Version:</strong> 1.1.0 - Updated via Git!</div>
```

**Step 2: Commit and push**

```bash
# Check what changed
git status

# Stage the change
git add index.html

# Commit with a descriptive message
git commit -m "Update version to 1.1.0"

# Push to GitHub
git push origin main
```

**Step 3: Watch the automatic deployment**

1. Open your Vercel dashboard
2. Click on your project
3. Watch the **"Deployments"** section

You should see:

```
🔄 Building...    main    abc1234    Just now
```

Then after a few seconds:

```
✓ Ready           main    abc1234    Just now
```

**Step 4: Verify the change is live**

1. Visit your production URL
2. You should see "Version: 1.1.0 - Updated via Git!"

✅ **Checkpoint:** Your change deployed automatically!

---

### Part 4: Explore the Build Logs

Let's understand what happened during deployment.

**Step 1: View deployment details**

1. In Vercel dashboard, click on the latest deployment
2. Click on **"Building"** or the deployment entry

**Step 2: Examine the build log**

Find and note down:

1. **Clone time:** How long did it take to clone your repo? **\_\_\_** ms

2. **Total duration:** How long was the entire deployment? **\_\_\_** seconds

3. **Commit message:** Does the log show your commit message? ☐ Yes ☐ No

4. **URLs generated:** List the URLs shown:
   - Preview URL: **********\_\_\_**********
   - Production URL: **********\_\_\_**********

---

### Part 5: Make Another Change (Practice)

Let's reinforce the workflow with one more change.

**Step 1: Add a new feature**

Add a timestamp to your page:

```html
<!-- Add this after the version div -->
<div class="timestamp">
  <strong>Last Updated:</strong>
  <span id="update-time"></span>
</div>

<script>
  document.getElementById("update-time").textContent =
    new Date().toLocaleDateString("en-PH", {
      year: "numeric",
      month: "long",
      day: "numeric",
    });
</script>
```

**Step 2: Deploy via Git**

```bash
git add .
git commit -m "Add last updated timestamp"
git push origin main
```

**Step 3: Verify**

1. Check Vercel dashboard for new deployment
2. Visit your live site
3. Confirm the timestamp appears

✅ **Checkpoint:** You've completed two automatic deployments!

---

## Part 6: Knowledge Check

Answer the following questions:

### Question 1: The Deployment Trigger

What triggers an automatic deployment on Vercel?

- A) Saving a file on your computer
- B) Pushing commits to your connected GitHub repository
- C) Refreshing the Vercel dashboard
- D) Opening your website in a browser

**Your Answer:** **\_**

---

### Question 2: The Production Branch

By default, which branch deploys to your production (live) website?

- A) develop
- B) feature
- C) main (or master)
- D) staging

**Your Answer:** **\_**

---

### Question 3: Troubleshooting

Your deployment failed. Where should you look first to find out what went wrong?

- A) Your local terminal
- B) The GitHub repository settings
- C) The Vercel build logs
- D) Your browser's developer console

**Your Answer:** **\_**

---

### Question 4: Workflow Order

Put these steps in the correct order (1-4):

**_ Vercel shows "Ready" status
_** You run `git push origin main`
**_ Vercel clones your repository and builds
_** You make changes and run `git commit`

---

### Question 5: Benefits (Select all that apply)

Which are benefits of Git integration over manual uploads?

- ☐ A) Automatic deployment on every push
- ☐ B) Deployment history tied to git commits
- ☐ C) Ability to rollback to previous versions
- ☐ D) Faster internet connection
- ☐ E) Team collaboration becomes easier

---

## What You Learned

In this activity, you accomplished:

- ✅ **Created a GitHub repository** and pushed your project code
- ✅ **Connected GitHub to Vercel** for automatic deployments
- ✅ **Triggered automatic deployments** by pushing changes
- ✅ **Viewed build logs** to understand the deployment process
- ✅ **Experienced the push → build → deploy workflow** firsthand

---

## The Complete Workflow (Summary)

```
┌─────────────────────────────────────────────────────────┐
│                YOUR NEW WORKFLOW                        │
├─────────────────────────────────────────────────────────┤
│                                                         │
│   1. Make changes locally                               │
│         ↓                                               │
│   2. git add . && git commit -m "message"               │
│         ↓                                               │
│   3. git push origin main                               │
│         ↓                                               │
│   4. ☕ Wait a few seconds                              │
│         ↓                                               │
│   5. ✨ Changes are LIVE!                               │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## Bonus Challenge

If you want extra practice:

1. **Add a CSS change** - Update the background color and deploy
2. **Add a new HTML page** - Create `about.html` and link to it
3. **Break something on purpose** - See what a failed build looks like
4. **Fix it** - Watch the next successful deployment

---

## Answer Key

**Question 1:** B) Pushing commits to your connected GitHub repository

**Question 2:** C) main (or master)

**Question 3:** C) The Vercel build logs

**Question 4:** 4, 2, 3, 1 (Commit → Push → Build → Ready)

**Question 5:** A, B, C, E (D is not related to Git integration)

---

## Next Steps

You've mastered automatic deployments! In the next lesson, you'll learn about **Preview Deployments**—how to test changes on a temporary URL before they go live. This is incredibly useful for:

- Getting feedback from teammates
- Testing new features safely
- Reviewing pull requests

See you in Lesson 4! 🚀
