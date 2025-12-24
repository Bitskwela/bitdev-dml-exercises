# Le 27: Tagging and Releases

![Git Tags](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-tags.png)

## Background Story

It's Thursday afternoon. Neri, the barangay stakeholder, calls an emergency meeting.

"The voting module is broken," she says. "We need to go back to the version from last month. The one that worked perfectly during the San Juan election."

The team looks at each other. Which version was that?

Maria checks the commit history. There are 200 commits from last month. Dev Sam remembers "it was before we added the SMS feature." The London developer says "I think it was after we fixed the timezone bug."

Nobody knows which exact commit was deployed to production that day.

"We need tags," Marco declares. "We should have tagged every release. v1.2.0 was deployed on October 15. v1.2.1 was the hotfix on October 20. Clear. Findable. Deployable."

Three hours later, they finally identify the commit by reading old deployment logs. They vow to tag every release from now on.

**Time Allotment**: 35 minutes

**Topics Covered**:

- What are Git tags?
- Lightweight vs annotated tags
- Semantic versioning
- Creating and managing tags
- Release workflow

---

## What Are Git Tags?

Tags are named pointers to specific commits—bookmarks in your history.

Unlike branches, tags don't move. When you create tag `v1.0.0` on a commit, it always points to that exact commit.

```bash
# History with tags
* abc1234 feat: add SMS notifications
* def5678 fix: timezone handling
* 789ghij chore: update dependencies  <-- tag: v1.2.0
* klm0123 feat: voting confirmation
```

## Two Types of Tags

### Lightweight Tags

Simple pointers to a commit. No extra information.

```bash
# Create lightweight tag
git tag v1.0.0

# Tag a specific commit
git tag v1.0.0 abc1234
```

### Annotated Tags (Recommended)

Include tagger info, date, and a message. These are proper Git objects.

```bash
# Create annotated tag
git tag -a v1.0.0 -m "First production release"

# View tag details
git show v1.0.0
# Shows: tagger, date, message, and the commit it points to
```

**Always use annotated tags for releases.** They provide crucial context.

## Semantic Versioning

The industry standard: **MAJOR.MINOR.PATCH**

```
v1.4.2
│ │ └── PATCH: Bug fixes (backwards compatible)
│ └──── MINOR: New features (backwards compatible)
└────── MAJOR: Breaking changes
```

### Version Progression Example

```
v1.0.0  - Initial release
v1.0.1  - Bug fix
v1.1.0  - New feature added
v1.2.0  - Another feature
v2.0.0  - Breaking API change
```

### Pre-release Versions

```
v1.0.0-alpha.1   - Early testing
v1.0.0-beta.1    - Feature complete, testing
v1.0.0-rc.1      - Release candidate
v1.0.0           - Production release
```

## Creating Tags for Barangay Blockchain

### Tag the Current Commit

```bash
# Create annotated tag on HEAD
git tag -a v1.3.0 -m "Release: Enhanced voting module"
```

### Tag a Past Commit

```bash
# Find the commit
git log --oneline

# Tag it
git tag -a v1.2.5 abc1234 -m "Hotfix: Timezone display issue"
```

### Tag with Detailed Message

```bash
git tag -a v2.0.0 -m "Release: Barangay Blockchain v2.0.0

Major Changes:
- New voting algorithm
- SMS notifications
- Multi-language support

Breaking Changes:
- API endpoint structure changed
- Requires database migration

Tested by: Maria, Dev Sam
Approved by: Marco"
```

## Managing Tags

### List All Tags

```bash
# List all tags
git tag

# List with pattern
git tag -l "v1.*"
# v1.0.0
# v1.1.0
# v1.2.0

# List with commit info
git tag -n1
# v1.0.0  First release
# v1.1.0  Added voting feature
```

### View Tag Details

```bash
git show v1.2.0
# Displays: tagger, date, message, commit details
```

### Delete a Tag

```bash
# Delete local tag
git tag -d v1.0.0-beta

# Delete remote tag
git push origin --delete v1.0.0-beta
```

## Pushing Tags to Remote

Tags aren't pushed with regular `git push`. They need explicit commands.

```bash
# Push a specific tag
git push origin v1.3.0

# Push all tags
git push origin --tags
```

## Checking Out Tags

Tags aren't branches. Checking out a tag puts you in "detached HEAD" state.

```bash
# Checkout a tag
git checkout v1.2.0

# Warning: You are in 'detached HEAD' state...

# To make changes, create a branch from the tag
git checkout -b hotfix/v1.2.1 v1.2.0
```

## Release Workflow

### Standard Release Process

```bash
# 1. Ensure main is up to date
git checkout main
git pull origin main

# 2. Run tests
npm test

# 3. Update version in package.json (if applicable)
# Edit package.json: "version": "1.3.0"

# 4. Commit version bump
git add package.json
git commit -m "chore: bump version to 1.3.0"

# 5. Create annotated tag
git tag -a v1.3.0 -m "Release v1.3.0: Enhanced voting module"

# 6. Push commit and tag
git push origin main
git push origin v1.3.0
```

### Hotfix Release

```bash
# 1. Create hotfix branch from production tag
git checkout -b hotfix/timezone v1.2.0

# 2. Apply fix
# ... make changes ...
git commit -m "fix: correct timezone offset calculation"

# 3. Tag the hotfix
git tag -a v1.2.1 -m "Hotfix: Timezone display corrected"

# 4. Merge to main
git checkout main
git merge hotfix/timezone
git push origin main
git push origin v1.2.1
```

## GitHub Releases

GitHub creates releases from tags automatically. You can:

1. Push a tag: `git push origin v1.3.0`
2. GitHub shows it under "Releases"
3. Add release notes, changelog, assets

Or create via GitHub UI:

1. Go to Releases → "Draft a new release"
2. Choose tag (or create new)
3. Add title, description
4. Attach binaries/assets
5. Publish

## Finding What Changed Between Tags

```bash
# Commits between two tags
git log v1.2.0..v1.3.0 --oneline

# Files changed between tags
git diff v1.2.0 v1.3.0 --stat

# Generate changelog
git log v1.2.0..v1.3.0 --pretty=format:"- %s (%h)"
```

## Why This Matters for Global Deployment

The Barangay Blockchain runs in production across multiple barangays. When Neri says "we need to rollback," the team needs to know:

- **Which version is in production?** → Check deployment logs for tag
- **What changed since last stable?** → Compare tags
- **How do we rollback?** → Checkout the previous tag

Tags provide this clarity:

```bash
# What's in production?
# Answer: v1.2.5

# Rollback to previous version
git checkout v1.2.4
# Deploy this version

# Compare what changed
git log v1.2.4..v1.2.5 --oneline
```

## Key Takeaways

✓ Tags mark specific commits with permanent names
✓ Use annotated tags (-a) for releases
✓ Follow semantic versioning: MAJOR.MINOR.PATCH
✓ Tags must be explicitly pushed: `git push origin v1.0.0`
✓ Create tags at every release, hotfix, and milestone
✓ Use `git checkout -b branch-name tag` to work from a tag
✓ GitHub Releases build on top of Git tags

**Next Lesson:** Git hooks—automating checks before commits and pushes.
