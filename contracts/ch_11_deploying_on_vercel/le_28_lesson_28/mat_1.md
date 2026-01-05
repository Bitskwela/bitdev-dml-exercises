# Le 28: CI/CD Best Practices – Automating Your Deployment Workflow

![CI/CD Pipeline](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/cicd.png)

## Background Story

Maria's barangay dashboard is growing. Multiple developers are now contributing, and manual deployments are causing issues.

"I just deployed over Marco's changes," Maria sighs.

"Time to set up proper CI/CD," Marco suggests. "Let's automate everything."

**Time Allotment**: 45 minutes

**Topics Covered**:

- Understanding CI/CD concepts
- GitHub Actions with Vercel
- Automated testing before deploy
- Preview deployments workflow
- Branch protection rules
- Deployment approvals
- Environment promotion

---

## What is CI/CD?

### Continuous Integration (CI)

```
Developer pushes code
        ↓
    Run tests
        ↓
    Run linting
        ↓
   Build project
        ↓
Report results
```

### Continuous Deployment (CD)

```
CI passes
    ↓
Auto-deploy to preview
    ↓
Review and approve
    ↓
Deploy to production
```

---

## Vercel's Built-in CI/CD

### Automatic Deployment Flow

| Trigger                | Environment | URL                    |
| ---------------------- | ----------- | ---------------------- |
| Push to main           | Production  | your-app.vercel.app    |
| Push to feature branch | Preview     | feature-xyz.vercel.app |
| Pull request           | Preview     | pr-123.vercel.app      |

### Every Push Gets

- Automatic build
- Preview deployment
- Unique URL
- Deployment checks

---

## GitHub Actions Integration

### Basic Workflow

```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: "20"
          cache: "npm"

      - name: Install dependencies
        run: npm ci

      - name: Run linting
        run: npm run lint

      - name: Run tests
        run: npm test

      - name: Build
        run: npm run build
```

---

## Pre-Deployment Checks

### Type Checking

```yaml
# .github/workflows/ci.yml
- name: Type check
  run: npx tsc --noEmit
```

### Linting

```yaml
- name: Lint code
  run: npm run lint

- name: Lint styles
  run: npm run lint:css
```

### Unit Tests

```yaml
- name: Run unit tests
  run: npm test -- --coverage

- name: Upload coverage
  uses: codecov/codecov-action@v4
```

---

## Integration Testing

### E2E Tests with Playwright

```yaml
# .github/workflows/e2e.yml
name: E2E Tests

on:
  deployment_status:

jobs:
  test:
    if: github.event.deployment_status.state == 'success'
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Install dependencies
        run: npm ci

      - name: Install Playwright
        run: npx playwright install --with-deps

      - name: Run E2E tests
        run: npx playwright test
        env:
          BASE_URL: ${{ github.event.deployment_status.target_url }}
```

---

## Required Status Checks

### Branch Protection

```yaml
# Settings → Branches → Branch protection rules

main:
  - Require status checks to pass
    ✓ CI / test
    ✓ E2E Tests / test
  - Require branches to be up to date
  - Require review from code owners
```

### Vercel Deployment Protection

```yaml
# vercel.json
{ "git": { "deploymentEnabled": { "main": true, "develop": true } } }
```

---

## Deployment Workflow

### Feature Branch Flow

```
1. Create feature branch
   git checkout -b feature/new-dashboard

2. Push changes
   git push origin feature/new-dashboard
   → Vercel creates preview

3. Open PR
   → CI runs tests
   → Preview URL in PR comments

4. Review and approve
   → Code review
   → E2E tests pass

5. Merge to main
   → Production deploy
```

---

## Environment Promotion

### Multi-Environment Setup

```
Development → Staging → Production

develop branch → staging.app.com
main branch → app.com
```

### Promotion Workflow

```yaml
# .github/workflows/promote.yml
name: Promote to Production

on:
  workflow_dispatch:
    inputs:
      version:
        description: "Deployment ID to promote"
        required: true

jobs:
  promote:
    runs-on: ubuntu-latest
    steps:
      - name: Promote deployment
        run: |
          vercel promote ${{ inputs.version }} --token=${{ secrets.VERCEL_TOKEN }}
```

---

## Deployment Previews

### Comment on PRs

```yaml
# Automatic with Vercel GitHub integration
# Shows:
# - Preview URL
# - Build logs
# - Lighthouse scores
```

### Custom PR Comments

```yaml
- name: Comment preview URL
  uses: actions/github-script@v7
  with:
    script: |
      github.rest.issues.createComment({
        issue_number: context.issue.number,
        owner: context.repo.owner,
        repo: context.repo.repo,
        body: '🚀 Preview: ${{ env.PREVIEW_URL }}'
      })
```

---

## Scheduled Deployments

### Cron-based Redeploy

```yaml
# .github/workflows/scheduled-deploy.yml
name: Scheduled Redeploy

on:
  schedule:
    - cron: "0 0 * * *" # Daily at midnight

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Trigger deployment
        run: |
          curl -X POST "${{ secrets.VERCEL_DEPLOY_HOOK }}"
```

### Deploy Hooks

Create in Vercel Dashboard:

1. Project Settings → Git
2. Deploy Hooks → Create Hook
3. Use URL in CI/CD

---

## Rollback Strategy

### Automatic Rollback

```yaml
# .github/workflows/deploy.yml
- name: Deploy
  id: deploy
  run: vercel deploy --prod --token=${{ secrets.VERCEL_TOKEN }}

- name: Health check
  run: |
    response=$(curl -s -o /dev/null -w "%{http_code}" ${{ steps.deploy.outputs.url }})
    if [ $response != "200" ]; then
      echo "Health check failed, rolling back"
      vercel rollback --token=${{ secrets.VERCEL_TOKEN }}
      exit 1
    fi
```

---

## Secrets Management

### GitHub Secrets

```yaml
# Repository Settings → Secrets → Actions

VERCEL_TOKEN: xxx
VERCEL_ORG_ID: xxx
VERCEL_PROJECT_ID: xxx
DATABASE_URL: xxx
```

### Using Secrets

```yaml
env:
  VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
  DATABASE_URL: ${{ secrets.DATABASE_URL }}
```

---

## Complete CI/CD Pipeline

```yaml
# .github/workflows/ci-cd.yml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: "20"
          cache: "npm"
      - run: npm ci
      - run: npm run lint

  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: "20"
          cache: "npm"
      - run: npm ci
      - run: npm test

  build:
    runs-on: ubuntu-latest
    needs: [lint, test]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: "20"
          cache: "npm"
      - run: npm ci
      - run: npm run build

  deploy-preview:
    if: github.event_name == 'pull_request'
    runs-on: ubuntu-latest
    needs: build
    steps:
      - uses: actions/checkout@v4
      - name: Deploy to Vercel Preview
        run: vercel deploy --token=${{ secrets.VERCEL_TOKEN }}

  deploy-production:
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    needs: build
    steps:
      - uses: actions/checkout@v4
      - name: Deploy to Vercel Production
        run: vercel deploy --prod --token=${{ secrets.VERCEL_TOKEN }}
```

---

## Maria's CI/CD Setup

Maria configures her pipeline:

```yaml
# Lint → Test → Build → Deploy
# Every PR gets:
# ✓ Automated testing
# ✓ Preview deployment
# ✓ E2E tests on preview
# ✓ Required reviews

# On merge to main:
# ✓ Production deploy
# ✓ Health check
# ✓ Automatic rollback if failed
```

**Results:**

- No more deployment conflicts
- Bugs caught before production
- Faster iteration cycles
- Team confidence increased

---

## Key Takeaways

✓ Automate testing before every deployment
✓ Use preview deployments for PR reviews
✓ Protect main branch with status checks
✓ Run E2E tests against preview URLs
✓ Implement automatic rollback on failures
✓ Manage secrets securely in CI/CD

**Next Lesson:** Rollbacks & Instant Rollback—recovering from failed deployments!
