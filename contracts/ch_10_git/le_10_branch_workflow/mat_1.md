# Le 10: Branch Workflow – Establishing Team Standards

![Branch Workflow Diagram](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-workflow.png)

## Scene: The Team Establishes Rules

**Friday morning, one week later. Team meeting.**

Maria, Marco, Sam (calling from Cebu), and Neri (from barangay hall) gather around the table—some physically, some on video.

Marco opens his terminal and runs `git branch`.

The output is chaos:
```
  feature/voting-1
  feature/voting-2
  feature/voting-fixes
  feature/voting-rush-job
  feature/payment-old-approach
  feature/payment-backup
  main
  (many deleted branches still listed)
```

"This," Marco says, "is not professional."

Neri looks confused. "Which branches are we actually using?"

"Exactly," Marco says. "No one can tell. We need standards."

Sam from Cebu chimes in: "In Singapore dev meetings, they have rules. feature/ for new features, bugfix/ for fixes, hotfix/ for emergencies. Everyone knows what they mean."

"Let's adopt that," Marco says. "And let's protect main. No one commits directly to main. Everything comes through pull requests with code review. That way, London always sees reviewed code before it reaches production."

Maria nods. "And we clean up branches after merging. Right now we have 47 branches, most of them dead."

Neri makes a decision: "This is our standard going forward. feature/, bugfix/, hotfix/. Protect main. Review before merging. Clean up after."

By establishing simple standards, the team moves from chaotic parallel development to organized parallel development. Work is coordinated. Intentions are clear. Global deployment becomes manageable.

**Time Allotment**: 35 minutes

**Topics Covered**:

- Branch naming conventions (feature/, bugfix/, hotfix/, release/, docs/)
- Why naming matters for global teams (clear communication across time zones)
- Protecting main branch (it must always be deployable)
- Pull request workflows (how code gets from branches to main)
- Branch policies for distributed teams (coordination without chaos)

---

## Branch Naming Conventions

Professional teams follow patterns:

| Pattern | Use Case | Example |
|---------|----------|---------|
| `feature/*` | New features | `feature/voting-protection` |
| `bugfix/*` | Bug fixes | `bugfix/validator-crash` |
| `hotfix/*` | Production fixes | `hotfix/critical-data-loss` |
| `release/*` | Release preparation | `release/1.0.0` |
| `docs/*` | Documentation | `docs/api-guide` |
| `chore/*` | Maintenance | `chore/update-dependencies` |

When Neri sees `feature/voting-improvements`, she immediately understands: "This is new voting work, not production-ready yet."

When London sees `release/1.0.0`, they know: "This is the version we're about to deploy to all four regions."

Naming matters for communication in distributed teams.

## Protecting Main

Main branch should be stable, always deployable. Professional teams protect it:

```bash
# What main must have
- Code reviewed (approved by another developer)
- Tests passing
- No breaking changes documented
- Tagged with version
```

You can't commit directly to main. You must:
1. Create a feature branch
2. Push to GitHub
3. Open a pull request
4. Wait for code review
5. Merge when approved

For Barangay Blockchain: main = "ready to deploy worldwide"

## Feature Branch Pattern

The most common workflow:

```bash
# Create feature branch
git switch -c feature/voting-improvements

# Work for several days
# Make commits
git commit -m "Add voter education module"
git commit -m "Improve vote counting accuracy"

# Push to GitHub
git push origin feature/voting-improvements

# Open Pull Request on GitHub
# Wait for Marco to review
# Marco approves

# Merge to main
git switch main
git merge feature/voting-improvements

# Delete feature branch
git branch -d feature/voting-improvements
```

## Why Main Protection Matters

**Without protection (Maria's scenario):**
1. Developer in London pushes directly to main at 9 AM London time
2. Code breaks voting system
3. Maria in Manila (asleep, 8 hours behind) wakes up to broken production
4. Chaos

**With protection:**
1. Developer creates `feature/voting-improvements`
2. Pushes to GitHub
3. Marco reviews: "Your change breaks vote counting. Let's discuss."
4. Developer fixes it
5. Marco approves
6. Merges safely
7. Everyone confident in production code

For global teams with sleeping team members, main protection is essential.

## Branch Lifetime

Branches should be short-lived:

- **feature/voting-improvements**: 2-3 days of work
- **Merge to main**: Gets reviewed, tested, deployed
- **Delete branch**: No longer needed
- **Create next branch**: Next feature

Long-lived branches are warning signs. If a branch lasts 3 weeks, the team isn't collaborating often enough.

## Why This Matters for Global Deployment

Barangay Blockchain spans Manila, Cebu, Singapore, London.

Without workflow discipline:
- Developers work on branches with unclear purposes
- Main is sometimes unstable
- Deployments are unpredictable
- Time zones make coordination harder

With workflow discipline:
- Feature names tell the story
- Main is always deployment-ready
- Deployments are predictable
- Time zones don't matter; process handles everything

## Key Takeaways

✓ Use naming conventions (feature/, bugfix/, release/)
✓ Protect main branch from direct commits
✓ Use pull requests for code review
✓ Keep branches short-lived (days, not weeks)
✓ Delete branches after merging
✓ Every region follows same workflow

**Next Lesson:** Once features are merged, we clean up branches to keep the repository organized.
