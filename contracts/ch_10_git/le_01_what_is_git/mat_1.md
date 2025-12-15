# Le 01: What is Git?

![Git Foundations](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-intro.png)

## Background Story

_The Manila Digital Collective is finally ready. After months of building their market app, crypto payment system, and DeFi tools, they're preparing to launch globally. But there's one critical problem: how do they manage code changes when developers are scattered across Manila, Cebu, Davao, and soon, the world?_

_"If we all edit files at the same time, we'll overwrite each other's work," says Marco, the technical lead. "We need version control."_

_Enter Git—the distributed version control system that powers global open-source projects, tech companies, and the entire digital world._

**Time Allotment**: 30 minutes

**Topics Covered**: Version control concepts, Git history, distributed systems, collaboration

---

## What is Git?

**Git** is a **distributed version control system (DVCS)** that tracks changes to files over time. Think of it as a detailed ledger for your code—recording who changed what, when they changed it, and why.

### Before Git: The Chaos

Imagine the Manila Digital Collective without Git:

- Developer A saves `app.js` at 2:00 PM
- Developer B saves `app.js` at 2:05 PM—overwriting A's changes
- Dev C downloads the file at 2:30 PM—but which version?
- Nobody knows the history of changes
- A bug is discovered—but nobody knows who introduced it
- Recovery is impossible

### After Git: Control & Clarity

With Git:

- Every change is recorded with who made it and why
- Developers work in isolated branches
- Changes are merged safely
- History is preserved forever
- Anyone can see the exact evolution of the code
- If something breaks, we can pinpoint exactly when and why

## The Story of Git

**Created**: 2005 by Linus Torvalds (creator of Linux)
**Why**: Linux kernel development was growing too fast for other version control systems
**Impact**: Became the industry standard for software development worldwide

### Git's Advantages Over Older Systems

| Feature           | CVS  | SVN    | Git       |
| ----------------- | ---- | ------ | --------- |
| Distributed       | ❌   | ❌     | ✅        |
| Offline work      | ❌   | ❌     | ✅        |
| Fast branching    | ❌   | ❌     | ✅        |
| Collaboration     | Poor | Better | Excellent |
| Industry standard | ❌   | ❌     | ✅        |

## Core Git Concepts

### The Three-Level System

1. **Working Directory**: Your actual files on your computer
2. **Staging Area**: Files you've marked to be committed
3. **Repository**: The permanent record of all commits

### Key Terms

- **Repository (Repo)**: A directory containing your project and its entire Git history
- **Commit**: A snapshot of your code at a specific moment in time
- **Branch**: A parallel line of development
- **Merge**: Combining changes from different branches
- **Remote**: A copy of your repository on a server (like GitHub)
- **Clone**: Creating a copy of a repository

## Why Git Matters for Your Journey

As you launch your Filipino-built innovations to the world:

- **Collaboration**: Work with developers in Manila, Cebu, and beyond
- **Safety**: Never lose code again
- **Transparency**: Track every change, every decision
- **Professionalism**: Git is standard in every tech company, startup, and open-source project
- **Open Source**: Contribute to global projects using Git

## The Global Deployment Vision

Imagine:

- You build an app in Manila
- Your classmate in Cebu adds features in a branch
- A developer in Japan contributes improvements
- All changes are tracked, merged safely, and deployed to servers worldwide
- If something breaks, you roll back instantly

That's Git. That's the power you're about to gain.

---

**Ready to start your version control journey? Let's initialize your first repository!**

**Ready for the activity? Let's get started!**
