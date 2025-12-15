# Quiz: Advanced Workflows

Answer the following questions to check your understanding of this lesson.

## Question 1

What is trunk-based development?

A) A workflow using many long-lived branches
B) A workflow where developers integrate to main frequently, using short-lived branches
C) Only working on the main branch without any branches
D) A way to store code in tree structures

**Correct Answer: B**

**Explanation:** Trunk-based development emphasizes small, frequent integrations to the main branch, with feature flags instead of long-lived feature branches.

---

## Question 2

What are feature flags used for?

A) To mark commits as features
B) To enable/disable features in code without deploying new code
C) To create new branches automatically
D) To flag problematic commits

**Correct Answer: B**

**Explanation:** Feature flags let you deploy code with incomplete features disabled, enabling continuous deployment while controlling feature rollout.

---

## Question 3

What is the Git Forking workflow typically used for?

A) Enterprise internal projects only
B) Open source projects where contributors don't have write access
C) Small personal projects

**Correct Answer: B**

**Explanation:** Forking is common in open source: contributors fork the repo, make changes, and submit pull requests from their fork to the original repository.

---

## Question 4

True or False: Monorepo and polyrepo are strategies for organizing multiple projects.

**Correct Answer: True**

**Explanation:** Monorepo keeps all projects in one repository; polyrepo uses separate repositories. Each has trade-offs for dependency management and tooling.

---

## Question 5

What is the purpose of using Git submodules?

A) To delete unused modules
B) To include external repositories within your repository
C) To speed up Git operations

**Correct Answer: B**

**Explanation:** Submodules let you include and track external repositories as dependencies within your project, keeping them at specific versions.

---

**Reflection:** What did you find most helpful in this lesson? What would you like more practice with?
