# Le 12: Branch Strategies – Choosing the Team's Way Forward

![Branch Strategies Comparison](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-strategies.png)

## Scene: A Team at the Crossroads

**Monday morning. The Barangay Hall conference room. Two months of progress, now at a critical juncture.**

Maria stares at her terminal. Forty-seven branches are listed. Some are outdated. Some are work-in-progress. Some have been sitting unused for three weeks.

"This is chaos," she says quietly to Marco, who's reviewing the branch list over her shoulder.

Marco nods. The team has grown. What started as Maria and Marco now includes:

- **Sam** in Cebu (voting system specialist)
- **Alexis** from Mexico City (payment system expert)
- **Dev intern** on her first week in Manila
- **Volunteer** from a provincial college

Each one created their own branches. Some named logically (`feature/voting-protection`), others cryptically (`test-thing-2`). Some merged cleanly. Others left dangling merge commits nobody understands.

"We need a branching strategy," Neri says, arriving for the weekly standup. "When emergency issues happen—and they will—I need to know which code is production-ready and which is experimental."

The intern nervously raises her hand: "I'm not sure when to create a branch, or when to merge. Do I merge to main? To develop? Where does my code go?"

Marco takes a deep breath. This moment has been coming since the team grew beyond three people.

"We need to decide how we work together. Not just what we build, but _how_ we coordinate our building."

He pulls up his notes: three different strategies, each with different tradeoffs.

"Gentlemen, ladies—we're at a decision point. The strategy we choose today affects how all of us will work for the next year. How we handle emergencies. How quickly we can release. How confident we are in production code."

**What they choose will define whether Barangay Blockchain remains chaotic, or becomes a professionally-managed codebase.**

---

## The Three Paths Forward

Three proven strategies exist. Each is used by companies you know. The choice isn't about what's "best"—it's about what's _right for your team's reality_.

**Time Allotment**: 40 minutes

**Topics Covered**:

- Gitflow strategy (maximum control, best for planned releases)
- GitHub Flow strategy (simplicity, best for rapid iteration)
- Trunk-based development (continuous delivery, best for high-confidence teams)
- Choosing based on reality (release frequency, team size, emergency needs)
- Emergency hotfixes in each strategy
- Long-term team scalability

---

## Strategy 1: Gitflow – Control Through Structure

**Best for**: Monthly or longer release cycles, multiple simultaneous versions, when stability is critical

**The Idea**: Create separate branches for _development_, _releasing_, and _hotfixing_. Main is sacred—only production-ready code touches it.

**Why Gitflow?**

Marco explains to the team: "Imagine Neri needs to release Version 1.0 to all 7 barangays next week. But we're still building features for Version 1.1. Gitflow keeps these separate."

"What if a bug emerges in production after we release?" Alexis asks. "We don't want to include all our new Version 1.1 features in the fix."

"Exactly," Marco says. "That's why Gitflow has emergency hotfix branches."

**The Branch Structure**:

```
main (production - what users see right now)
  ├─ release/1.0 (getting ready for production)
  └─ develop (where new features integrate)
      ├─ feature/voting-protection (Maria's work)
      ├─ feature/payment-audit (Alexis's work)
      └─ feature/sms-notifications (Sam's work)

And emergency:
hotfix/critical-bug (if production breaks)
```

**How Gitflow Works in Practice**:

**Week 1-3: Feature Development**

Sam in Cebu creates a feature branch from `develop`:

```bash
# Sam starts voting system improvements
git switch -c feature/voting-enhancement develop
# ... commits ...
# Ready? Push to origin
git push origin feature/voting-enhancement
# Create pull request, Marco reviews
# After approval, merge to develop
git switch develop
git merge feature/voting-enhancement
# develop now has Sam's code, ready for testing
```

Maria does the same with payment tracking:

```bash
git switch -c feature/payment-tracking develop
# ... work ...
git push origin feature/payment-tracking
# Merge to develop after review
```

**Week 3: Release Preparation**

Neri says: "I want to release Version 1.0 next week. Lock down `develop`. Stop accepting new features."

Marco creates a release branch:

```bash
git switch -c release/1.0 develop
# This branch is for staging and bugfixes only
# No new features—only polish and emergency fixes
```

The dev intern tests on this release branch. Finds a bug in payment calculation.

Maria fixes it directly on `release/1.0`:

```bash
git switch release/1.0
# Fix the bug
git commit -m "fix: correct payment rounding in vote tallying"
git push origin release/1.0
```

**Release Day: Deployment**

Code is solid. Neri approves:

```bash
# Merge release/1.0 to main (production)
git switch main
git merge release/1.0
git tag v1.0  # Mark the version
git push origin main --tags  # Push to GitHub

# Also merge back to develop so it has the bugfix
git switch develop
git merge release/1.0
git push origin develop
```

Production is now Version 1.0.

**Emergency Scenario: Production Bug**

Three days later, Neri gets a report: "The voting system crashed in Quezon province. Data might be corrupted."

Marco reacts immediately—this is why Gitflow exists:

```bash
# Emergency hotfix directly from main
git switch -c hotfix/voting-crash main
# Sam fixes the bug critically and carefully
# ... commit, test thoroughly ...
git push origin hotfix/voting-crash

# Merge to BOTH main (production fix) AND develop (future versions)
git switch main
git merge hotfix/voting-crash
git switch develop
git merge hotfix/voting-crash
# Both are updated, no duplicated bugs
```

**Key Advantage**: Neri can deploy bugfixes without including half-finished Version 1.1 features. Stability is preserved.

**Gitflow Visual Summary**:

| When                  | Where                             | Purpose                 |
| --------------------- | --------------------------------- | ----------------------- |
| **Feature work**      | Branch from `develop`             | New features, isolated  |
| **Testing features**  | Merge to `develop`                | Integration testing     |
| **Preparing release** | Create `release/*`                | Staging, final bugfixes |
| **Production ready**  | Merge to `main`                   | Users get this code     |
| **Emergency fix**     | Branch from `main`, merge to both | Production stability    |

---

## Strategy 2: GitHub Flow – Simplicity at Scale

**Best for**: Weekly or biweekly releases, rapid iteration, continuous deployment mindset

**The Idea**: One main branch. Feature branches are short-lived (hours to days). Every merge to main gets deployed immediately.

**Why GitHub Flow?**

Maria leans back: "Gitflow sounds good, but complicated. What if we just... deploy faster?"

"That's GitHub Flow," Marco explains. "Fewer branches. Faster cycles. But it requires excellent tests and confidence in code quality."

**The Branch Structure**:

```
main (always deployable, deployed multiple times per week)
  ├─ feature/voting-beta (Maria, 2 days)
  ├─ feature/analytics (Sam, 3 days)
  └─ feature/notifications (Alexis, 2 days)
```

No `develop` branch. No `release` branch. Main _is_ what users see, and it changes constantly.

**How GitHub Flow Works**:

Maria needs to add voting analytics:

```bash
# Create a feature branch
git switch -c feature/voting-analytics

# Work for 2-3 days
git commit -m "Add real-time vote counter"
git commit -m "Display results by barangay"
git push origin feature/voting-analytics

# Open a Pull Request on GitHub
# Marco, Alexis, and Neri review
# "Looks good," Marco says. "Deploy?"
# Merge to main
git switch main
git merge feature/voting-analytics
git push origin main

# Automatically, GitHub Actions deploy main to production
# Users see new voting analytics immediately
```

If a bug appears in production an hour later:

```bash
# Sam creates an emergency fix branch (not from main, but based on main)
git switch -c hotfix/voting-crash

# Fix immediately
git commit -m "fix: prevent vote counter overflow on large tallies"
git push origin hotfix/voting-crash

# PR, review, merge, deployed
# Total time: 30 minutes
```

**Pros**: Simpler to understand, faster feedback, deployments multiple times per day.

**Cons**: Requires strong tests and quality discipline. Bad code reaches users faster too.

**GitHub Flow is excellent for**:

- Teams that deploy multiple times daily
- Products where rapid iteration matters more than stability
- Teams with excellent test coverage
- Agile/Scrum environments

---

## Strategy 3: Trunk-Based Development – Maximum Speed

**Best for**: DevOps/SRE teams, continuous deployment, microservices, extremely confident teams

**The Idea**: Developers work on main itself (or branches that last < 24 hours). Feature flags control what's visible to users. No traditional "release" process.

**Why Trunk-Based Development?**

Alexis from Mexico asks: "What if we don't branch at all? What if we all work on main?"

Marco nods: "That's trunk-based. Google, Amazon, Facebook use this. You can deploy 50 times a day."

"But won't code conflict?" she asks.

"Yes. Constantly. But small conflicts resolve fast. And tests catch everything else."

**How It Works**:

```bash
# Everyone mostly works on main
git switch main
git pull origin main

# Short-lived branch for one feature (< 24 hours)
git switch -c feature/one-small-thing

# 2-4 hours later: feature is done and tested
git push origin feature/one-small-thing
# Merge to main immediately (or auto-merge)
git switch main
git merge feature/one-small-thing
git push origin main

# 1 minute later: feature is in production (if tests pass)
```

Feature flags control what's visible:

```javascript
// In a voting system frontend
if (featureFlags.isVotingBetaEnabled) {
  // New voting logic here
  showNewVotingUI();
} else {
  // Old voting logic here
  showClassicVotingUI();
}
```

Maria deploys the new voting code to production but keeps it hidden behind a flag. She monitors it. When confident, she flips the flag. Users see the feature.

**Pros**: Extreme speed, real-time feedback, tiny changes are easier to debug.

**Cons**: Requires extreme confidence, excellent monitoring, strong team discipline.

**Trunk-based is excellent for**:

- Teams deploying hourly
- Services where users expect constant updates
- Teams with 99%+ test coverage
- Companies like Google, Netflix, Facebook

---

## The Decision Framework

**For Barangay Blockchain in January 2026, which strategy fits?**

Marco leads the team through a decision matrix:

| Factor                        | Gitflow             | GitHub Flow      | Trunk-Based                |
| ----------------------------- | ------------------- | ---------------- | -------------------------- |
| **Release Frequency**         | Monthly             | Weekly           | Daily/Hourly               |
| **Number of Active Versions** | Multiple (1.0, 2.0) | One (main)       | One (main + flags)         |
| **Emergency Hotfixes**        | Easy (from main)    | Fast (< 30 min)  | Instant (already deployed) |
| **Team Experience**           | Needs structure     | Needs discipline | Needs expertise            |
| **Test Coverage Requirement** | Medium              | High             | Very High                  |
| **Learning Curve**            | Steep               | Gentle           | Moderate                   |

Neri speaks: "We release once a month to the 7 barangays. Some deployments are planned. Some are emergencies. We have 6 developers across 3 countries. I need stability, but also speed."

Marco: "That's textbook Gitflow."

"What's the learning curve?" asks the dev intern.

"About 2 weeks," Maria says. "More structure to learn, but clearer rules."

The team votes. Gitflow wins 5-1 (Alexis votes for GitHub Flow—she likes simplicity).

"Gitflow," Neri says. "Let's make it official. Starting tomorrow:

- Main branch is production-only. Nothing merges to main except releases and hotfixes.
- Develop branch is integration. Feature work happens there.
- Each developer creates feature branches from develop.
- Marco reviews all pull requests.
- Weekly integration testing.
- Monthly releases to production."

She pauses, then smiles.

"And if Barangay Blockchain becomes successful? If we're deploying twice a week? If our test coverage reaches 95%? Then we can evolve to GitHub Flow."

---

## What This Means for Tomorrow

The team now has explicit rules:

**For Maria working on voting improvements**:

```bash
git switch -c feature/voting-audit develop
# ... work, test, commit ...
git push origin feature/voting-audit
# Pull request → Marco reviews → merge to develop
# develop tested weekly → release branch monthly → main goes to production
```

**For Sam in Cebu adding SMS notifications**:

```bash
git switch -c feature/sms-alerts develop
# ... parallel development, same process ...
```

**For Alexis in Mexico debugging payment issues**:

```bash
git switch -c bugfix/payment-edge-case develop
# Even bugfixes follow the strategy
```

**If Neri discovers a critical bug in production**:

```bash
git switch -c hotfix/voting-security main
# Emergency fix directly from production code
# Deployed immediately to all 7 barangays
# Also merged back to develop so future versions have the fix
```

---

## Key Takeaways

✅ **Gitflow**: Structure + safety (best for teams needing stability)  
✅ **GitHub Flow**: Simplicity + speed (best for rapid iteration)  
✅ **Trunk-based**: Maximum speed (best for high-confidence teams)  
✅ **Choose based on reality**: release frequency, team size, emergency needs  
✅ **Communicate clearly**: every developer must know the rules  
✅ **Evolve as you grow**: start with Gitflow, move to GitHub Flow when ready

---

## What's Next?

You've mastered how to organize your local work. But the real power emerges when the team is _distributed_.

Tomorrow, Maria and Sam are in different cities. Code written in Manila needs to reach developers in Cebu and Mexico City. This requires sharing repositories across machines. The next lesson introduces **remote repositories on GitHub**—where "Beyond the Islands" truly begins.
