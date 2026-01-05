# CI/CD Best Practices Activity

Automate your deployment workflow. In this activity, you'll set up CI/CD pipelines with GitHub Actions and Vercel.

## Task for Students

### Part 1: CI/CD Concepts Quiz

**Question 1:** What does CI stand for?

- A) Continuous Implementation
- B) Continuous Integration
- C) Continuous Installation
- D) Code Integration

**Question 2:** When does Vercel create a preview deployment?

- A) Only on main branch pushes
- B) Only on PRs
- C) On any push to any branch
- D) Only when manually triggered

**Question 3:** What is a status check?

- A) Health monitoring
- B) Required CI job that must pass before merge
- C) Performance metric
- D) Security scan

**Question 4:** What triggers a production deployment in Vercel?

- A) Any push
- B) Push to main/production branch
- C) Manual trigger only
- D) On PR approval

**Question 5:** What is environment promotion?

- A) Marketing campaign
- B) Moving code through dev → staging → production
- C) Increasing server resources
- D) Adding environment variables

---

### Part 2: Create Basic CI Workflow

**Task:** Create a GitHub Actions workflow for CI:

```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  ci:
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

      - name: Lint
        run: npm run lint

      - name: Type check
        run: npx tsc --noEmit

      - name: Test
        run: npm test

      - name: Build
        run: npm run build
```

**Questions:**

1. What triggers this workflow? \_\_\_

2. Why use `npm ci` instead of `npm install`? \_\_\_

3. What does `cache: 'npm'` do? \_\_\_

---

### Part 3: Add Test Coverage

**Task:** Enhance the workflow with coverage reporting:

```yaml
- name: Run tests with coverage
  run: npm test -- --coverage --coverageReporters=text-lcov

- name: Upload coverage to Codecov
  uses: codecov/codecov-action@v4
  with:
    token: ${{ secrets.CODECOV_TOKEN }}
    fail_ci_if_error: true
```

**Exercise:** What would you add to fail the build if coverage drops below 80%?

```yaml
- name: Check coverage threshold
  run: |
    # Your answer here
```

---

### Part 4: E2E Tests on Preview

**Task:** Run E2E tests against preview deployments:

```yaml
# .github/workflows/e2e.yml
name: E2E Tests

on:
  deployment_status:

jobs:
  e2e:
    if: github.event.deployment_status.state == 'success'
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Install dependencies
        run: npm ci

      - name: Install Playwright browsers
        run: npx playwright install --with-deps chromium

      - name: Run E2E tests
        run: npx playwright test
        env:
          BASE_URL: ${{ github.event.deployment_status.target_url }}

      - name: Upload test results
        if: always()
        uses: actions/upload-artifact@v4
        with:
          name: playwright-report
          path: playwright-report/
```

**Questions:**

1. When does this workflow run? \_\_\_

2. What is `deployment_status`? \_\_\_

3. How does the test know which URL to test? \_\_\_

---

### Part 5: Branch Protection

**Task:** Configure branch protection rules:

**GitHub Settings → Branches → Add rule**

```
Branch name pattern: main

☑ Require a pull request before merging
  ☑ Require approvals: 1
  ☑ Dismiss stale reviews

☑ Require status checks to pass
  ☑ Require branches to be up to date
  Status checks:
    ☑ CI / ci
    ☑ E2E Tests / e2e

☑ Require conversation resolution

☑ Do not allow bypassing the above settings
```

**Questions:**

1. What happens if CI fails on a PR? \_\_\_

2. What if someone pushes directly to main? \_\_\_

3. Why require "branches to be up to date"? \_\_\_

---

### Part 6: Parallel Jobs

**Task:** Optimize CI with parallel jobs:

```yaml
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: "20", cache: "npm" }
      - run: npm ci
      - run: npm run lint

  typecheck:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: "20", cache: "npm" }
      - run: npm ci
      - run: npx tsc --noEmit

  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: "20", cache: "npm" }
      - run: npm ci
      - run: npm test

  build:
    needs: [lint, typecheck, test]
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: "20", cache: "npm" }
      - run: npm ci
      - run: npm run build
```

**Exercise:** Draw the job dependency graph:

```
lint ──────┐
typecheck ─┼─→ build
test ──────┘
```

---

### Part 7: Deploy Hooks

**Task:** Create a scheduled deployment:

```yaml
# .github/workflows/scheduled.yml
name: Scheduled Redeploy

on:
  schedule:
    # Every day at 2 AM UTC
    - cron: "0 2 * * *"
  workflow_dispatch: # Allow manual trigger

jobs:
  redeploy:
    runs-on: ubuntu-latest
    steps:
      - name: Trigger Vercel deployment
        run: |
          curl -X POST "${{ secrets.VERCEL_DEPLOY_HOOK }}"
```

**Questions:**

1. When does this run? \_\_\_

2. What is `workflow_dispatch`? \_\_\_

3. How do you create a deploy hook in Vercel? \_\_\_

---

### Part 8: Secrets Management

**Task:** Configure and use secrets:

```yaml
# Setting secrets:
# GitHub → Repository → Settings → Secrets → Actions

# Using secrets:
env:
  VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
  DATABASE_URL: ${{ secrets.DATABASE_URL }}

# In step:
- name: Deploy
  run: vercel deploy --prod --token=${{ secrets.VERCEL_TOKEN }}
```

**Exercise:** Which should be secrets vs environment variables?

| Variable          | Secret? | Why?   |
| ----------------- | ------- | ------ |
| VERCEL_TOKEN      | \_\_\_  | \_\_\_ |
| NODE_ENV          | \_\_\_  | \_\_\_ |
| DATABASE_URL      | \_\_\_  | \_\_\_ |
| API_VERSION       | \_\_\_  | \_\_\_ |
| STRIPE_SECRET_KEY | \_\_\_  | \_\_\_ |

---

### Part 9: Health Check and Rollback

**Task:** Implement automatic rollback:

```yaml
deploy:
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v4

    - name: Deploy to production
      id: deploy
      run: |
        url=$(vercel deploy --prod --token=${{ secrets.VERCEL_TOKEN }})
        echo "url=$url" >> $GITHUB_OUTPUT

    - name: Health check
      run: |
        max_attempts=5
        attempt=1
        while [ $attempt -le $max_attempts ]; do
          response=$(curl -s -o /dev/null -w "%{http_code}" ${{ steps.deploy.outputs.url }})
          if [ "$response" = "200" ]; then
            echo "Health check passed"
            exit 0
          fi
          echo "Attempt $attempt failed (status: $response)"
          sleep 10
          attempt=$((attempt + 1))
        done
        echo "Health check failed after $max_attempts attempts"
        exit 1

    - name: Rollback on failure
      if: failure()
      run: |
        vercel rollback --token=${{ secrets.VERCEL_TOKEN }}
        echo "Rolled back to previous deployment"
```

**Questions:**

1. How many health check attempts are made? \_\_\_

2. What triggers the rollback step? \_\_\_

3. What does `if: failure()` mean? \_\_\_

---

### Part 10: Complete Pipeline Design

**Task:** Design a complete CI/CD pipeline for a team project:

```
Feature Development:
1. Create feature branch from develop
2. Push changes → Preview deployment
3. Open PR to develop → CI runs
4. Review and approve
5. Merge to develop → Staging deployment

Release:
1. Create release branch from develop
2. PR to main → Full CI + E2E
3. Approve and merge
4. Production deployment
5. Tag release
```

**Exercise:** Write the workflow triggers:

```yaml
# For develop branch (staging)
on:
  push:
    branches: [___]

# For main branch (production)
on:
  push:
    branches: [___]
  workflow_dispatch:  # Allow manual production deploy
```

---

### What You Learned

✓ Creating CI workflows with GitHub Actions
✓ Running tests and linting automatically
✓ E2E testing on preview deployments
✓ Setting up branch protection rules
✓ Implementing rollback strategies
✓ Managing secrets securely

---

**Instructor Answers:**

Part 1: 1-B, 2-C, 3-B, 4-B, 5-B

Part 2:

1. Push to main/develop or PRs to main
2. `npm ci` is faster and ensures reproducible builds from lock file
3. Caches npm dependencies between runs for faster builds

Part 4:

1. When a deployment status event is triggered (after Vercel deploys)
2. GitHub event when a deployment changes state
3. From `github.event.deployment_status.target_url` environment variable

Part 5:

1. PR cannot be merged until CI passes
2. Blocked if branch protection is enabled
3. Ensures PR includes latest changes from main

Part 7:

1. Every day at 2 AM UTC
2. Allows manually triggering the workflow from GitHub UI
3. Project Settings → Git → Deploy Hooks → Create Hook

Part 8:

- VERCEL_TOKEN: Yes - authentication credential
- NODE_ENV: No - public configuration
- DATABASE_URL: Yes - contains credentials
- API_VERSION: No - public configuration
- STRIPE_SECRET_KEY: Yes - payment credentials

Part 9:

1. 5 attempts
2. When any previous step fails
3. Only run this step if previous steps failed

Part 10:

- Staging: `branches: [develop]`
- Production: `branches: [main]`
