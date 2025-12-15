# Le 12: Branch Strategies

![Branch Strategies Comparison](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-strategies.png)

## Background Story

Neri, the barangay official, needs a stable version for production. But she also needs features deployed as soon as they're ready. And she needs emergency hotfixes to roll out immediately.

"We have three options," Marco explains to the team. "Gitflow for maximum stability, GitHub Flow for speed, or trunk-based for high-frequency deployment. Each has tradeoffs."

Maria asks: "Which one is best for Barangay Blockchain?"

"It depends on our release frequency," Marco answers. "If we deploy once a month, Gitflow makes sense. If we deploy weekly, GitHub Flow. If we deploy daily, trunk-based."

Neri interrupts: "I need emergency fixes to deploy immediately without waiting for planned releases."

"Then Gitflow with hotfix branches," Marco says. "And features can go to develop branch for staging before release."

What they decide will affect how the entire team branches, merges, and deploys for the next year.

**Time Allotment**: 40 minutes

**Topics Covered**:
- Gitflow strategy (most complex)
- GitHub Flow strategy (simplest)
- Trunk-based development (most aggressive)
- Choosing a strategy
- Emergency hotfixes
- Release management

---

## Gitflow Strategy

Most complex, best for multiple release versions.

```
main (production)
  ├─ release/1.0.0 (staging)
  └─ develop (integration)
      ├─ feature/voting
      ├─ feature/payment
      └─ bugfix/validator
```

**How it works:**
- `develop`: where features integrate
- `release/X`: staging before production
- `main`: production only
- `hotfix/*`: emergency fixes from main

**Gitflow workflow:**
```bash
# Create feature
git switch -c feature/voting develop

# Work, commit, push
git commit -m "Add voting protection"
git push origin feature/voting

# When done: merge to develop
git switch develop
git merge feature/voting

# Later: create release branch
git switch -c release/1.0.0 develop

# Test in staging, fix bugs
git commit -m "Fix payment bug found in testing"

# When ready: merge to main
git switch main
git merge release/1.0.0

# Emergency hotfix
git switch -c hotfix/critical-bug main
# Fix immediately, merge to both main AND develop
```

## GitHub Flow Strategy

Simple, best for continuous deployment.

```
main (production)
  ├─ feature/voting
  ├─ feature/payment
  └─ feature/dashboard
```

**How it works:**
- `main` is always deployable
- Create feature branch
- Test locally
- Open PR, review
- Merge to main
- Deploy main immediately

**GitHub Flow workflow:**
```bash
# Create feature
git switch -c feature/voting

# Work, commit, push
git commit -m "Add voting protection"
git push origin feature/voting

# Open PR on GitHub
# Marco reviews and approves
# Merge to main

# Deploy main
./deploy.sh main

# No staging, no release branches
# Simple and fast
```

## Trunk-Based Development

Most aggressive, best for high-confidence teams.

```
main
  ├─ feature/voting (< 1 day)
  ├─ feature/payment (< 1 day)
  └─ feature/dashboard (< 1 day)
```

**How it works:**
- Very short-lived branches (< 24 hours)
- Excellent test coverage required
- Features deployed multiple times per day
- Requires feature flags for incomplete work

## Choosing a Strategy

| Strategy | Release Frequency | Stability | Complexity |
|----------|------------------|-----------|-----------|
| **Gitflow** | Monthly | High | Complex |
| **GitHub Flow** | Weekly | Medium | Simple |
| **Trunk-based** | Daily | Depends on tests | Medium |

For Barangay Blockchain (multiple regions, monthly releases, emergency hotfixes):
- **Gitflow makes sense**
- `develop` for feature integration
- `release/1.0.0` for staging
- `main` for production
- `hotfix/*` for emergencies

## Why This Matters for Global Deployment

**For Barangay Blockchain across 4 regions with 1-month release cycle:**

1. **Week 1-3:** Developers in Manila, Cebu, Singapore create feature branches from `develop`
2. **Week 3:** Features complete, merged to `develop` for integration testing
3. **Week 4:** Release branch created. London team runs final testing
4. **Deployment day:** After Neri's approval, release branch merged to main
5. **Emergency:** Voting system crashes in production. Create `hotfix/voting-crash` from main
6. **Next day:** Hotfix merged to both main AND develop. Worldwide deployment

With Gitflow, this complexity is manageable. Without it, chaos.

## Key Takeaways

✓ Gitflow: best for planned releases with hotfixes
✓ GitHub Flow: best for weekly deployments  
✓ Trunk-based: best for daily deployments
✓ Choose based on release frequency
✓ Communicate strategy to entire team
✓ Different regions can follow same strategy

**Next Lesson:** Now we've mastered local branching. Time to share code with the world via remote repositories on GitHub.
