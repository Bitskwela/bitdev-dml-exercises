# Le 10: Branch Workflow

![Branch Workflow Diagram](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-workflow.png)

## Background Story

Friday morning. Barangay Blockchain team meeting. Three developers, four regions to deploy to.

"We need rules," Marco says. "Right now Maria creates feature/voting-1, feature/voting-2, feature/voting-fixes. It's chaos. Neri doesn't understand what's stable. London dev doesn't know if they can deploy."

"I just create names as I go," Maria admits.

"Let's use naming conventions," Marco explains. "feature/ for new work, bugfix/ for fixing bugs, release/ for releases. Everyone knows what each branch is for."

Neri nods: "So if I see feature/voting-improvements, I know it's new work. And if I see release/1.0.0, I know that's going to production."

"Exactly," Marco says. "And we protect main. No direct commits. Everything comes through merge requests. That way, Singapore always sees reviewed code before it reaches production."

By establishing simple naming conventions and protecting key branches, the team moves faster with confidence. Parallel work becomes organized chaos instead of pure chaos.

**Time Allotment**: 35 minutes

**Topics Covered**:
- Branch naming conventions
- Feature branches vs other types
- Protecting main branch
- Pull request workflows
- Branch policies for distributed teams

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
