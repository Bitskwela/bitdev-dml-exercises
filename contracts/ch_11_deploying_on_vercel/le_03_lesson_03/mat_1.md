# Le 03: Connecting Git Repository – Automatic Deployments

![Git Integration](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/vercel-git.png)

## Background Story

Maria has deployed Neri's bakery site via CLI. It works. But there's a problem.

"Every time I make a change," Maria says, "I have to remember to run `vercel` again."

"And what happens when Dev Sam makes changes?" Marco asks. "Does he have access to deploy?"

Maria realizes the issue. Manual deployments don't scale. When you're one developer working on a simple project, running `vercel` is fine. When you're a team working on a production application, you need automation.

"Connect your GitHub repository to Vercel," Marco explains. "Then every push automatically deploys. No manual steps. No forgotten deployments. Dev Sam pushes to main, the production site updates. Everyone stays in sync."

This is **continuous deployment**—and it's how professional teams work.

**Time Allotment**: 45 minutes

**Topics Covered**:

- Why Git integration matters
- Connecting GitHub to Vercel
- Automatic deployments on push
- Deployment triggers and branches
- Team collaboration workflow

---

## Why Git Integration?

### Manual Deployment Problems

```
Maria makes change → Maria runs vercel → Site updates
Dev Sam makes change → Dev Sam runs vercel → ??? (if he forgets)
Maria makes another change → Maria runs vercel → Overwrites Sam's work?

Chaos. Confusion. Conflicts.
```

### Git Integration Solution

```
Maria pushes to GitHub → Vercel auto-deploys → Site updates
Dev Sam pushes to GitHub → Vercel auto-deploys → Site updates
Everyone sees same history → Everyone deploys same way

Order. Consistency. Collaboration.
```

## Connecting GitHub to Vercel

### Step 1: Create GitHub Repository

First, get your project on GitHub:

```bash
cd neris-bakery

# Initialize git
git init

# Add files
git add .

# Commit
git commit -m "feat: initial bakery website"

# Create repo on GitHub (via website or CLI)
# Then connect:
git remote add origin https://github.com/yourname/neris-bakery.git
git push -u origin main
```

### Step 2: Import to Vercel

1. Go to [vercel.com/new](https://vercel.com/new)
2. Click "Import Git Repository"
3. Select your GitHub account
4. Find and select `neris-bakery`
5. Click "Import"

### Step 3: Configure Project

Vercel shows configuration options:

```
Project Name: neris-bakery
Framework Preset: Other (static site)
Root Directory: ./
Build Command: (none for static)
Output Directory: (none for static)
```

For a simple static site, defaults work fine. Click "Deploy".

### Step 4: Wait for Build

Vercel:

1. Clones your repository
2. Runs build command (if any)
3. Deploys to global CDN
4. Provides your URL

```
✅ Deployment Complete!
🔗 https://neris-bakery.vercel.app
```

## Automatic Deployments

Now the magic happens. Every push to GitHub triggers a deployment.

### Workflow

```bash
# Make a change
echo '<p>New hours: 4 AM - 10 PM</p>' >> index.html

# Commit and push
git add index.html
git commit -m "feat: update business hours"
git push origin main

# Vercel automatically:
# 1. Detects the push
# 2. Pulls latest code
# 3. Builds project
# 4. Deploys to production
# No manual intervention needed!
```

### Watching the Deployment

You can watch progress at:

- Vercel dashboard → Your project → Deployments
- Or the direct URL from the deployment notification

```
Deployment #5
Commit: feat: update business hours
Branch: main
Status: ● Building... → ✅ Ready
URL: https://neris-bakery.vercel.app
```

## Branch-Based Deployments

Vercel deploys different branches differently:

| Branch         | Deployment Type | URL                                   |
| -------------- | --------------- | ------------------------------------- |
| `main`         | Production      | `neris-bakery.vercel.app`             |
| `develop`      | Preview         | `neris-bakery-develop-abc.vercel.app` |
| `feature/menu` | Preview         | `neris-bakery-menu-xyz.vercel.app`    |

### Production Branch

By default, `main` is your production branch. Pushes to `main` update your main URL.

### Preview Branches

All other branches get unique preview URLs:

```bash
# Create feature branch
git checkout -b feature/new-menu

# Make changes
# ...

# Push feature branch
git push origin feature/new-menu

# Vercel creates:
# https://neris-bakery-new-menu-abc123.vercel.app
# Preview URL just for this branch!
```

## Team Collaboration

With Git integration, team workflow becomes smooth:

### Maria's Workflow

```bash
git checkout -b feature/contact-form
# ... make changes ...
git push origin feature/contact-form
# Preview URL: neris-bakery-contact-form-xxx.vercel.app
```

### Dev Sam's Workflow

```bash
git checkout -b feature/photo-gallery
# ... make changes ...
git push origin feature/photo-gallery
# Preview URL: neris-bakery-photo-gallery-yyy.vercel.app
```

### Merging to Production

```bash
# After review, merge to main
git checkout main
git merge feature/contact-form
git push origin main
# Production updates automatically!
```

## Deployment Triggers

### Default Triggers

- **Push to any branch** → Preview deployment
- **Push to production branch** → Production deployment
- **Pull request opened** → Preview deployment (commented on PR)

### Customizing Triggers

In Vercel dashboard → Project Settings → Git:

```
Production Branch: main
Preview Branches: All branches
Ignored Build Step: [command to skip builds]
```

### Skipping Deployments

Sometimes you don't want to trigger a deploy:

```bash
# Skip deployment for this commit
git commit -m "docs: update README [skip ci]"
```

Or in `vercel.json`:

```json
{
  "git": {
    "deploymentEnabled": {
      "main": true,
      "develop": true,
      "feature/*": false
    }
  }
}
```

## GitHub Integration Features

### Deployment Status Checks

GitHub shows deployment status on commits and PRs:

```
commit abc123 - ✅ Deployed to Vercel
commit def456 - 🔄 Building...
commit ghi789 - ❌ Build failed
```

### Comments on Pull Requests

When you open a PR, Vercel comments:

```
🔍 Preview: https://neris-bakery-pr-15-abc.vercel.app
📊 Performance: 95/100
📁 Size: 45 KB
✅ All checks passed
```

Reviewers can click the preview link to test changes before merging.

## Rollback

Made a mistake? Rollback to previous deployment:

1. Go to Vercel Dashboard → Deployments
2. Find the last working deployment
3. Click "..." → "Promote to Production"

Or via CLI:

```bash
# List deployments
vercel ls

# Rollback to specific deployment
vercel rollback [deployment-url]
```

## Environment-Specific Settings

Different branches can have different environment variables:

```
Production (main):
  API_URL=https://api.neris-bakery.com

Preview (feature branches):
  API_URL=https://staging-api.neris-bakery.com
```

We'll cover this in detail in the environment variables lesson.

## Best Practices

### 1. Protect Your Main Branch

On GitHub, enable branch protection:

- Require pull request reviews
- Require status checks (Vercel build must pass)
- No direct pushes to main

### 2. Use Descriptive Branch Names

```bash
# Good
feature/menu-redesign
fix/mobile-layout
docs/add-contact-info

# Bad
update
fix
my-branch
```

### 3. Small, Frequent Deploys

```bash
# Good: Small focused commits
git commit -m "feat: add menu section"
git commit -m "style: improve mobile layout"
git commit -m "fix: correct phone number"

# Bad: One giant commit
git commit -m "update everything"
```

Small deploys are easier to debug if something breaks.

## Why This Matters: Beyond the Islands

With Git integration:

- Maria pushes from Manila
- Dev Sam reviews from Cebu
- London developer can see preview
- Singapore client gets production URL
- Everyone works on the same codebase
- Deployments are automatic and consistent

No more "did you deploy?" questions. No more version confusion. The repository is the source of truth, and Vercel keeps production in sync.

## Key Takeaways

✓ Git integration enables automatic deployments
✓ Push to main = production deployment
✓ Push to other branches = preview deployments
✓ Each PR gets a unique preview URL
✓ Team members can work independently
✓ Rollback is easy if something breaks
✓ Branch protection prevents accidents

**Next Lesson:** Understanding preview deployments in depth!
