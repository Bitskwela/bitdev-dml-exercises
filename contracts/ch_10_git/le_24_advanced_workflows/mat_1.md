# Le 24: Advanced Workflow Strategies

![Advanced Git Workflow](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-advanced-workflow.png)

## Background Story

The Barangay Blockchain has grown. What started as Maria's side project is now a production system deployed across four regions with a team of eight developers.

Marco gathers the team for a workflow review: "We've outgrown our simple branching strategy. Singapore is confused about which branch to deploy. London doesn't know if a feature is tested. Cebu pushed to the wrong branch twice last week."

He draws a diagram on the whiteboard:

```
main ────────────────────────────────────────→
   ↑            ↑           ↑
release/1.0  release/1.1  release/2.0
   ↑            ↑           ↑
develop ─────────────────────────────────────→
   ↑      ↑      ↑      ↑      ↑
feature/ feature/ feature/ hotfix/ bugfix/
```

"This is Gitflow," Marco explains. "It's more complex, but it handles our needs: long-running features, scheduled releases, emergency hotfixes, and multi-region deployment."

Neri asks: "Will this slow us down?"

"It will slow down chaos," Marco replies. "And speed up confidence. Everyone will know exactly where code should go and what state it's in."

**Time Allotment**: 60 minutes

**Topics Covered**:

- Gitflow deep dive
- Release management
- Hotfix workflow
- Multi-environment strategies
- Choosing the right workflow for your team

---

## Gitflow: The Complete Picture

Gitflow uses multiple long-lived branches:

### Main Branches

| Branch    | Purpose               | Who Deploys From |
| --------- | --------------------- | ---------------- |
| `main`    | Production-ready code | Production       |
| `develop` | Integration branch    | Staging/QA       |

### Supporting Branches

| Branch Type | Created From | Merges To      | Purpose                    |
| ----------- | ------------ | -------------- | -------------------------- |
| `feature/*` | develop      | develop        | New features               |
| `release/*` | develop      | main + develop | Release preparation        |
| `hotfix/*`  | main         | main + develop | Emergency production fixes |

## The Feature Workflow

```bash
# 1. Start feature from develop
git checkout develop
git pull origin develop
git checkout -b feature/voter-analytics

# 2. Work on feature (days/weeks)
git commit -m "Add analytics module"
git commit -m "Add charts"
git push origin feature/voter-analytics

# 3. Create PR to develop (not main!)
# PR: feature/voter-analytics → develop

# 4. After review, merge to develop
# Feature is now in integration branch

# 5. Delete feature branch
git branch -d feature/voter-analytics
```

## The Release Workflow

When develop is ready for production:

```bash
# 1. Create release branch from develop
git checkout develop
git checkout -b release/1.2.0

# 2. Only bug fixes on release branch
git commit -m "Fix typo in voter message"
git commit -m "Fix validation edge case"

# 3. Test thoroughly (QA environment)

# 4. Merge to main (production)
git checkout main
git merge release/1.2.0 --no-ff
git tag -a v1.2.0 -m "Release 1.2.0"
git push origin main --tags

# 5. Merge back to develop (so fixes aren't lost)
git checkout develop
git merge release/1.2.0 --no-ff
git push origin develop

# 6. Delete release branch
git branch -d release/1.2.0
```

## The Hotfix Workflow

Production is broken. Emergency fix needed:

```bash
# 1. Create hotfix from main
git checkout main
git checkout -b hotfix/critical-security-fix

# 2. Fix the issue
git commit -m "Fix XSS vulnerability"

# 3. Test on production-like environment

# 4. Merge to main (deploy to production)
git checkout main
git merge hotfix/critical-security-fix --no-ff
git tag -a v1.2.1 -m "Hotfix 1.2.1"
git push origin main --tags

# 5. Merge to develop (don't lose the fix)
git checkout develop
git merge hotfix/critical-security-fix --no-ff
git push origin develop

# 6. Delete hotfix branch
git branch -d hotfix/critical-security-fix
```

## Real-World Scenario: Barangay Blockchain Release Week

**Monday**: Features freeze on develop. Release/2.0 created.

```bash
git checkout develop
git checkout -b release/2.0.0
git push origin release/2.0.0
```

**Tuesday-Wednesday**: QA tests release/2.0. Bugs found and fixed.

```bash
# Dev Sam fixes a bug
git checkout release/2.0.0
git commit -m "Fix vote counting edge case"
git push origin release/2.0.0
```

**Thursday**: Release approved. Merge to main.

```bash
git checkout main
git merge release/2.0.0 --no-ff
git tag -a v2.0.0 -m "Release 2.0.0: Multi-region voting"
git push origin main --tags

# CI/CD deploys to all regions
```

**Friday**: Emergency! Singapore reports bug.

```bash
git checkout main
git checkout -b hotfix/singapore-timezone-bug
# Fix it
git commit -m "Fix timezone calculation for Singapore"
git checkout main
git merge hotfix/singapore-timezone-bug --no-ff
git tag -a v2.0.1 -m "Hotfix: Singapore timezone"
git push origin main --tags
# Singapore fixed within hours
```

## Multi-Environment Strategy

| Branch      | Environment | Purpose                |
| ----------- | ----------- | ---------------------- |
| `feature/*` | Local/Dev   | Development            |
| `develop`   | Staging     | Integration testing    |
| `release/*` | QA/UAT      | Pre-production testing |
| `main`      | Production  | Live users             |

The Barangay Blockchain team:

- Develops on feature branches (local testing)
- Integrates to develop (staging.barangay-blockchain.ph)
- Prepares releases on release/\* (qa.barangay-blockchain.ph)
- Deploys main to production (barangay-blockchain.ph)

## Choosing Your Workflow

### Gitflow (What we covered)

- **Best for**: Scheduled releases, long feature cycles, multiple environments
- **Complexity**: High
- **Team size**: 5+ developers

### GitHub Flow (Simpler)

- **Best for**: Continuous deployment, web apps
- **Complexity**: Low
- **Team size**: 1-10 developers

```bash
# GitHub Flow is simpler:
main ←── feature branches
# Every merge to main deploys to production
```

### Trunk-Based Development (Simplest)

- **Best for**: Experienced teams, excellent CI/CD, feature flags
- **Complexity**: Low (but requires discipline)
- **Team size**: Any (with good practices)

```bash
# Everyone commits to main frequently
main ←── short-lived branches (hours, not days)
# Feature flags hide incomplete features
```

## The Barangay Blockchain Team's Decision

After discussion, the team chooses Gitflow because:

1. **Monthly releases**: They release on a schedule, not continuously
2. **Multiple regions**: Need QA time before deploying to Singapore, London
3. **Stakeholder demos**: Neri wants to see features before they go live
4. **Regulatory compliance**: Voting systems need audit trails

Different projects, different workflows. Choose what fits your team.

## Workflow Documentation

Create a `CONTRIBUTING.md` for your team:

```markdown
# Contribution Guide

## Branching Strategy

We use Gitflow.

## Branch Naming

- Features: `feature/description`
- Bugs: `bugfix/description`
- Hotfixes: `hotfix/description`
- Releases: `release/X.Y.Z`

## Workflow

1. Create feature branch from `develop`
2. Open PR to `develop`
3. Get 2 approvals
4. Merge (squash commits)
5. Delete feature branch

## Releases

- Release branches created monthly
- Only bug fixes on release branches
- Tag format: `vX.Y.Z`
```

## Key Takeaways

✓ Gitflow uses main, develop, feature, release, and hotfix branches
✓ Features merge to develop, not main
✓ Releases prepare code for production
✓ Hotfixes go directly to main (emergency)
✓ Always merge release/hotfix back to develop
✓ Tag every production release
✓ Different teams need different workflows
✓ Document your workflow for the team

**Next Lesson:** Best practices—commit messages that help future developers.
