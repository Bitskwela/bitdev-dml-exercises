# Team Collaboration Activity

Working in teams requires proper access control and workflows. In this activity, you'll configure team settings and member permissions.

## Task for Students

### Part 1: Team Collaboration Quiz

**Question 1:** Which role can invite new team members?

- A) Viewer
- B) Developer
- C) Member
- D) Owner

**Question 2:** What does a Developer role allow by default?

- A) Full production deployments
- B) Preview deployments only
- C) Read-only access
- D) Billing management

**Question 3:** Where do you configure project-specific member access?

- A) Team Settings → Members
- B) Project Settings → Members
- C) vercel.json
- D) package.json

**Question 4:** What does Deployment Protection do?

- A) Speeds up deployments
- B) Requires approval before production deploy
- C) Adds SSL certificates
- D) Compresses assets

**Question 5:** Which plan includes SSO (Single Sign-On)?

- A) Hobby
- B) Pro
- C) Enterprise
- D) All plans

---

### Part 2: Role Assignment Exercise

**Scenario:** You're setting up a team for the Barangay Platform. Assign the appropriate roles:

| Person    | Responsibility                             | Recommended Role |
| --------- | ------------------------------------------ | ---------------- |
| Maria     | Project lead, full access                  | \_\_\_           |
| Juan      | Backend developer, full deploy             | \_\_\_           |
| Ana       | Junior developer, learning                 | \_\_\_           |
| Pedro     | Municipal auditor, needs to see dashboards | \_\_\_           |
| Lola Rosa | Accountant, pays the bills                 | \_\_\_           |

**Options:** Owner, Member, Developer, Viewer, Billing

---

### Part 3: Set Up a Vercel Team (Simulation)

**Step 1:** Understanding team creation:

```
Dashboard → Avatar → Create Team

Team Settings:
- Name: Barangay Tech Platform
- Slug: barangay-tech
- Region: Singapore (closest to Philippines)
```

**Step 2:** Invite members (conceptual):

```
Team Settings → Members → Invite

Member 1:
- Email: juan@barangay.gov.ph
- Role: Member
- Scope: All projects

Member 2:
- Email: ana@barangay.gov.ph
- Role: Developer
- Scope: dashboard project only
```

**Step 3:** Verify setup checklist:

- [ ] Team created with appropriate name
- [ ] Owner role assigned correctly
- [ ] Members invited with correct roles
- [ ] Project scopes configured
- [ ] Billing information added

---

### Part 4: Project Access Configuration

**Task:** Configure access for the following projects:

**Project: barangay-dashboard**

- Maria: Full access (can delete, change settings)
- Juan: Can deploy to production
- Ana: Can only deploy previews
- Pedro: Can only view

**What roles should each person have for this project?**

| Person | Project Role |
| ------ | ------------ |
| Maria  | \_\_\_       |
| Juan   | \_\_\_       |
| Ana    | \_\_\_       |
| Pedro  | \_\_\_       |

---

### Part 5: Deployment Protection Setup

**Task:** Enable deployment protection for the production project.

**Step 1:** Navigate to Project Settings → Deployment Protection

**Step 2:** Configure settings:

```yaml
Production Protection:
  - Require approval: Yes
  - Approvers: Maria, Juan
  - Bypass for Vercel CLI: No

Preview Protection:
  - Vercel Authentication: Yes (team members only)
  - Password: No
```

**Step 3:** Test the flow:

1. Create a PR → Preview deploys automatically ✅
2. Merge to main → Deployment queued, awaiting approval ⏳
3. Maria approves → Production deploys ✅

---

### Part 6: Git Workflow Configuration

**Task:** Map branches to environments:

```
Branches:
- main → Production
- develop → Staging
- feature/* → Preview
- hotfix/* → Preview
```

**Configure in Project Settings → Git:**

| Setting           | Value  |
| ----------------- | ------ |
| Production Branch | \_\_\_ |
| Preview Branches  | \_\_\_ |
| Ignored Branches  | \_\_\_ |

---

### Part 7: Audit Log Analysis

**Scenario:** Review these audit log entries and identify potential issues:

**Log 1:**

```json
{
  "action": "member.role.changed",
  "user": "unknown@external.com",
  "target": "ana@barangay.gov.ph",
  "oldRole": "developer",
  "newRole": "owner"
}
```

**Issue:** ******\_\_\_******

**Log 2:**

```json
{
  "action": "deployment.created",
  "user": "juan@barangay.gov.ph",
  "environment": "production",
  "time": "03:00 AM"
}
```

**Issue (if any):** ******\_\_\_******

**Log 3:**

```json
{
  "action": "project.deleted",
  "user": "maria@barangay.gov.ph",
  "project": "test-project"
}
```

**Issue (if any):** ******\_\_\_******

---

### Part 8: Permission Matrix Exercise

**Fill in the permissions for each role:**

| Action            | Owner | Member | Developer | Viewer |
| ----------------- | ----- | ------ | --------- | ------ |
| View deployments  | ✅    | ✅     | ✅        | \_\_\_ |
| Deploy preview    | ✅    | ✅     | \_\_\_    | ❌     |
| Deploy production | ✅    | \_\_\_ | ❌        | ❌     |
| Change env vars   | ✅    | \_\_\_ | ❌        | ❌     |
| Delete project    | ✅    | \_\_\_ | ❌        | ❌     |
| Invite members    | ✅    | ❌     | ❌        | \_\_\_ |

---

### Part 9: Notification Setup

**Task:** Configure team notifications:

| Event             | Notify      | Channel              |
| ----------------- | ----------- | -------------------- |
| Production deploy | Maria, Juan | Slack #deploys       |
| Failed deployment | All devs    | Slack #alerts, Email |
| Security alert    | Maria       | Email, SMS           |
| New member joined | Maria       | Email                |

**Where to configure:**
Team Settings → Notifications → Add Integration

---

### Part 10: Team Workflow Checklist

Review this checklist for a healthy team workflow:

- [ ] All members have appropriate roles
- [ ] Production deployments require approval
- [ ] Preview deployments are authenticated
- [ ] Branch protection enabled on main
- [ ] Audit logs reviewed weekly
- [ ] Notifications configured
- [ ] Emergency rollback plan documented

---

### What You Learned

✓ Vercel team accounts and roles
✓ Assigning project-specific permissions
✓ Deployment protection configuration
✓ Git workflow with branch-environment mapping
✓ Reading and analyzing audit logs
✓ Setting up team notifications

---

**Instructor Answers:**

Part 1: 1-D, 2-B, 3-B, 4-B, 5-C

Part 2:

- Maria → Owner
- Juan → Member
- Ana → Developer
- Pedro → Viewer
- Lola Rosa → Billing

Part 4:

- Maria → Owner (or Member with project ownership)
- Juan → Member
- Ana → Developer
- Pedro → Viewer

Part 6:

- Production Branch: main
- Preview Branches: All (or develop, feature/_, hotfix/_)
- Ignored Branches: (optional) archive/_, test/_

Part 7:

- Log 1 Issue: Unknown external user promoted someone to Owner - potential security breach
- Log 2 Issue: Possibly suspicious (3 AM deploy), but may be legitimate
- Log 3 Issue: None - Owner deleting test project is normal

Part 8:

- Viewer: View deployments ✅
- Developer: Deploy preview ✅
- Member: Deploy production ✅
- Member: Change env vars ✅
- Member: Delete project ✅
- Viewer: Invite members ❌
