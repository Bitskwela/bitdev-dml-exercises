# Le 26: Gitignore Management

![Gitignore](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-gitignore.png)

## Scene: The Password in the Repository

**Thursday morning. The Barangay Blockchain is about to go live.**

Maria is excited. Her first major feature—complete, tested, ready. She runs:

```bash
git add .
git commit -m "feat: add voter registration module"
git push origin main
```

It deploys to production. Celebration time!

Five minutes later, Dev Sam messages in the team Slack, his voice shaking (as text): "Maria... did you just push your `.env` file? The one with the production database password?"

Maria's celebration stops. She runs:

```bash
git log --oneline -1
git show HEAD
```

And there it is—in the git history, visible to anyone who clones the repository:

```
DATABASE_PASSWORD=barangay_voting_2024_prod
DATABASE_USER=admin_barangay
```

The production password. The master database credentials. Sitting in a public GitHub repository.

"This is a security breach," Marco says coldly. "Anyone could fork our repository. They have production access."

The team spends the next two hours:

1. Rotating all passwords
2. Investigating what data was exposed
3. Notifying stakeholders
4. Implementing emergency patches

Later, Marco pulls Maria aside.

"This wasn't your fault. It's our fault for not setting up .gitignore," he says. "Never, ever commit environment files. Or secrets. Or API keys. Set up .gitignore on your first commit. Make it a habit. It's easier to prevent than to fix."

**This lesson teaches security. Files committed to Git are permanent. Prevent problems at the start.**

**Time Allotment**: 35 minutes

**Topics Covered**:

- What .gitignore does
- Essential patterns to ignore
- Global vs project gitignore
- Security considerations
- Removing accidentally committed files

---

## What is .gitignore?

The `.gitignore` file tells Git which files and directories to ignore. Ignored files:

- Won't appear in `git status`
- Won't be added with `git add .`
- Won't be committed or pushed
- Stay only on your local machine

```bash
# .gitignore example
node_modules/
.env
*.log
dist/
```

## Creating .gitignore

```bash
# Create .gitignore in repository root
touch .gitignore

# Add patterns
echo "node_modules/" >> .gitignore
echo ".env" >> .gitignore
echo "*.log" >> .gitignore

# Commit the .gitignore itself
git add .gitignore
git commit -m "chore: add gitignore"
```

## Essential Patterns for the Barangay Blockchain

### Environment and Secrets

```gitignore
# Environment files (CRITICAL - never commit!)
.env
.env.local
.env.production
.env*.local

# Secret keys
*.pem
*.key
secrets/
```

### Dependencies

```gitignore
# Node.js
node_modules/
package-lock.json  # Sometimes (depends on team preference)

# Python
__pycache__/
*.pyc
venv/
.venv/
```

### Build Outputs

```gitignore
# Build directories
dist/
build/
out/
coverage/

# Compiled files
*.min.js
*.min.css
```

### IDE and Editor

```gitignore
# VS Code
.vscode/
*.code-workspace

# JetBrains (WebStorm, IntelliJ)
.idea/
*.iml

# macOS
.DS_Store

# Windows
Thumbs.db
```

### Logs and Temporary Files

```gitignore
# Logs
*.log
logs/
npm-debug.log*

# Temporary files
*.tmp
*.temp
.cache/
```

## Complete Barangay Blockchain .gitignore

```gitignore
# Dependencies
node_modules/

# Environment (SECURITY!)
.env
.env.local
.env.production
.env*.local

# Build outputs
dist/
build/
coverage/
artifacts/
cache/

# Logs
*.log
logs/

# IDE
.vscode/
.idea/

# OS files
.DS_Store
Thumbs.db

# Hardhat/Blockchain specific
cache/
artifacts/
typechain/
typechain-types/

# Test coverage
coverage/
coverage.json
```

## Pattern Syntax

| Pattern                | Meaning                   | Example Match               |
| ---------------------- | ------------------------- | --------------------------- |
| `file.txt`             | Exact file                | `file.txt`                  |
| `*.log`                | All files ending in .log  | `error.log`, `debug.log`    |
| `folder/`              | Directory and contents    | `folder/anything.txt`       |
| `**/logs`              | logs folder anywhere      | `src/logs`, `test/logs`     |
| `!important.log`       | Exception (don't ignore)  | Keeps `important.log`       |
| `*.log` + `!error.log` | All logs except error.log | Ignores all but `error.log` |

## Global .gitignore

Some files should be ignored in ALL your repositories:

```bash
# Create global gitignore
touch ~/.gitignore_global

# Configure Git to use it
git config --global core.excludesfile ~/.gitignore_global
```

Global `.gitignore_global`:

```gitignore
# macOS
.DS_Store

# Windows
Thumbs.db

# IDE
.vscode/
.idea/

# Editor backups
*~
*.swp
```

Now these are ignored in every repository without adding them each time.

## Security: What MUST Be Ignored

These should NEVER be committed:

```gitignore
# API Keys and Secrets
.env
*.key
*.pem
secrets/
credentials/

# Private configurations
config.local.js
settings.local.json

# Database files
*.sqlite
*.db
```

## The Mistake: Accidentally Committed Files

If you already committed a file that should be ignored:

```bash
# Step 1: Add to .gitignore
echo ".env" >> .gitignore

# Step 2: Remove from Git (but keep local file)
git rm --cached .env

# Step 3: Commit the removal
git commit -m "chore: remove .env from tracking"

# WARNING: The file is still in git history!
# Anyone with repo access can see old versions
```

### For Sensitive Data: Nuclear Option

If secrets were committed, they're in history forever. You must:

1. **Rotate all exposed credentials immediately**
2. Consider using BFG Repo-Cleaner to rewrite history (advanced)
3. In extreme cases, delete and recreate the repository

```bash
# BFG example (advanced)
bfg --delete-files .env
git reflog expire --expire=now --all
git gc --prune=now --aggressive
git push --force
```

This is why prevention (.gitignore from the start) is better than cure.

## Why This Matters for Global Deployment

The Barangay Blockchain repository is:

- Hosted on GitHub (potentially public or shared)
- Cloned by developers in four regions
- Accessed by CI/CD systems
- Potentially audited by security teams

If `.env` is committed:

- Production passwords are exposed
- API keys can be stolen
- Database credentials are public
- Security audit fails

"I committed .env with the production database password" is how security breaches happen.

## Template Gitignores

GitHub provides templates for most project types:

```bash
# Create project with gitignore template
curl https://raw.githubusercontent.com/github/gitignore/master/Node.gitignore > .gitignore
```

Or visit: https://github.com/github/gitignore

## Key Takeaways

✓ .gitignore prevents files from being tracked
✓ Set up .gitignore BEFORE your first commit
✓ Never commit: .env, secrets, keys, passwords
✓ Ignore: node_modules, build outputs, IDE settings
✓ Use global gitignore for personal files (.DS_Store)
✓ Removing a committed file doesn't remove it from history
✓ If secrets are committed, rotate them immediately

**Next Lesson:** Tagging and releases—marking important points in your history.
