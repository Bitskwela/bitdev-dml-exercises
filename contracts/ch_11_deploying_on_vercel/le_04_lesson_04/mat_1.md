# Le 04: Understanding Preview Deployments

![Preview Deployments](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/vercel-preview.png)

## Background Story

Maria opens a pull request. She's redesigned Neri's bakery homepage with a new hero section.

"How do I show this to Neri before merging?" Maria asks. "I don't want to break the live site while she reviews it."

Before Vercel, this was complicated. You'd either:

- Share screenshots (not interactive)
- Deploy to a separate staging server (expensive, complex)
- Ask people to clone the repo and run locally (technical barrier)

But with Vercel's preview deployments, Maria just pushes her branch—and a unique URL appears.

"Here, Neri," Maria messages. "Check this preview: `neris-bakery-hero-redesign-abc.vercel.app`"

Neri clicks, sees the new design, suggests changes. Maria updates, pushes again. The preview URL updates. No production impact. No complex setup.

This is preview deployment magic.

**Time Allotment**: 35 minutes

**Topics Covered**:

- What are preview deployments?
- How preview URLs work
- Review workflow with previews
- Comparing preview vs production
- Team communication patterns

---

## What Are Preview Deployments?

A **preview deployment** is a temporary, fully-functional deployment of a branch or pull request.

```
Production Deployment:
└── main branch → neris-bakery.vercel.app
    Always live. Real users visit this.

Preview Deployments:
├── feature/hero-redesign → neris-bakery-hero-redesign-abc.vercel.app
├── feature/new-menu → neris-bakery-new-menu-def.vercel.app
└── fix/mobile-layout → neris-bakery-mobile-layout-ghi.vercel.app
    Temporary. For review only.
```

Each branch gets its own isolated URL. Changes to one preview don't affect others.

## How Preview URLs Work

When you push a non-production branch:

```bash
git checkout -b feature/contact-page
# ... make changes ...
git push origin feature/contact-page
```

Vercel automatically:

1. Detects the push
2. Builds your project
3. Deploys to a unique URL
4. Returns the preview URL

### URL Pattern

```
[project-name]-[branch-name]-[unique-id].vercel.app

Examples:
neris-bakery-hero-redesign-abc123.vercel.app
neris-bakery-git-feature-menu-xyz789.vercel.app
```

The URL includes:

- Project name (neris-bakery)
- Branch reference (hero-redesign)
- Unique deployment ID (abc123)

## Preview vs Production

| Aspect   | Preview               | Production           |
| -------- | --------------------- | -------------------- |
| URL      | Unique per deployment | Stable main URL      |
| Branch   | Any non-main branch   | main (or configured) |
| Audience | Team, reviewers       | Real users           |
| Purpose  | Review, testing       | Live application     |
| Lifespan | Temporary             | Permanent            |

## The Review Workflow

### Step 1: Create Feature Branch

```bash
git checkout -b feature/new-gallery
```

### Step 2: Make Changes and Push

```bash
# Add gallery section...
git add .
git commit -m "feat: add photo gallery section"
git push origin feature/new-gallery
```

### Step 3: Open Pull Request

On GitHub, open a PR from `feature/new-gallery` to `main`.

Vercel automatically comments on the PR:

```markdown
## Vercel Preview Deployment

🔍 **Preview:** https://neris-bakery-new-gallery-abc.vercel.app
📊 **Performance:** 94/100
📁 **Bundle Size:** 52 KB (+3 KB)
✅ **Status:** Ready

[Visit Preview] [Inspect Deployment]
```

### Step 4: Share and Review

Share the preview URL with:

- Team members for code review
- Stakeholders (Neri) for design feedback
- QA for testing

### Step 5: Iterate

If changes are needed:

```bash
# Make more changes
git add .
git commit -m "fix: adjust gallery layout per Neri's feedback"
git push origin feature/new-gallery
```

Vercel automatically:

- Creates a new deployment
- Updates the same preview URL
- Comments on the PR with new details

### Step 6: Merge

Once approved:

```bash
git checkout main
git merge feature/new-gallery
git push origin main
```

The production site updates automatically.

## Preview Features

### Inspect Deployment

Click "Inspect" on any deployment to see:

- Build logs
- Function logs
- Deployment files
- Environment variables used

### Compare Deployments

Compare preview to production:

```
Preview: neris-bakery-new-gallery-abc.vercel.app
    └── Has new gallery section

Production: neris-bakery.vercel.app
    └── Original design

Side-by-side review before merging
```

### Deployment Protection

Preview deployments can be protected:

```json
// vercel.json
{
  "previewDenylist": ["password-protected.html"],
  "password": "review-access-2024"
}
```

Or in dashboard: Settings → Deployment Protection

## Pull Request Comments

Vercel's GitHub integration provides rich PR comments:

```markdown
## Deployment Preview

**Preview:** https://preview-url.vercel.app

### Changes

- 📁 2 files changed
- 📦 Bundle: 52KB (+3KB from production)

### Performance

- ⚡ First Contentful Paint: 0.8s
- 📊 Lighthouse: 94/100

### Screenshots

[Auto-captured preview images]
```

This helps reviewers understand impact before clicking through.

## Multiple Preview Deployments

Each push creates a new deployment. You can access all of them:

```
Deployments for feature/new-gallery:

#3: abc123 - 2 hours ago (current)
    "fix: adjust gallery layout"
    https://neris-bakery-new-gallery-abc.vercel.app

#2: xyz789 - 5 hours ago
    "feat: add photo gallery"
    https://neris-bakery-xyz.vercel.app

#1: def456 - yesterday
    "initial gallery structure"
    https://neris-bakery-def.vercel.app
```

You can share any specific deployment for comparison.

## Preview Environment Variables

Previews can have different environment variables:

```
Production (main):
  DATABASE_URL=postgres://prod-db...
  ENVIRONMENT=production

Preview (branches):
  DATABASE_URL=postgres://staging-db...
  ENVIRONMENT=preview
```

Configure in Dashboard → Project → Settings → Environment Variables:

```
Variable: DATABASE_URL
Value: postgres://staging...
Environments: ☐ Production ☑ Preview ☐ Development
```

## Preview Deployment Limits

Free tier limits:

| Limit               | Free Tier        |
| ------------------- | ---------------- |
| Preview deployments | Unlimited        |
| Retention           | 2 weeks (unused) |
| Concurrent builds   | 1                |
| Build time          | 45 minutes       |

Previews are automatically cleaned up if not accessed.

## Best Practices

### 1. Always Use PRs

```bash
# Good: PR with preview
git checkout -b feature/update
git push origin feature/update
# Open PR → Get preview URL → Review → Merge

# Bad: Direct push to main
git push origin main
# No review, no preview, risky
```

### 2. Share Previews with Stakeholders

```
Message to Neri:
"Here's the new menu design for your review:
https://neris-bakery-new-menu-abc.vercel.app

Please let me know if the prices are correct
and if you like the layout."
```

### 3. Test on Preview Before Merging

- Check mobile responsiveness
- Verify all links work
- Test forms and interactions
- Check performance metrics

### 4. Use Descriptive Branch Names

```bash
# Good: Clear purpose
feature/hero-image-redesign
fix/broken-contact-form
chore/update-footer-copyright

# Bad: Unclear
update
changes
test
```

Good names make preview URLs readable.

## Why This Matters: Beyond the Islands

Consider the Barangay Blockchain review process:

**Old Way (No Previews):**

1. Maria finishes feature in Manila
2. Sends screenshots to Marco in Cebu
3. Marco can't interact with it
4. Neri in barangay hall never sees it
5. London reviewer confused by static images
6. Deploy and hope for the best

**New Way (With Previews):**

1. Maria pushes feature branch
2. Shares preview URL with everyone
3. Marco tests on his phone in Cebu
4. Neri clicks through on her tablet
5. London reviewer checks functionality
6. Everyone approves, then deploy

Preview deployments enable distributed teams to collaborate on live, interactive versions—not screenshots.

## Key Takeaways

✓ Preview deployments are temporary URLs for branches
✓ Each push to a branch updates its preview
✓ Pull requests automatically get preview comments
✓ Share previews with stakeholders for feedback
✓ Preview environment can have different config
✓ Test thoroughly on preview before merging
✓ Previews are automatically cleaned up

**Next Lesson:** Custom domain setup—your own `.com` instead of `.vercel.app`!
