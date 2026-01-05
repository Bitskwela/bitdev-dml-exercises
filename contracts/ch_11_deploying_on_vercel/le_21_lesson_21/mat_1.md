# Le 21: Team Collaboration – Access Control, Roles, and Workflows

![Team Collaboration](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/team-collaboration.png)

## Background Story

Maria's barangay platform is a success. Now the municipal government wants to expand it. She needs to onboard developers from other barangays.

"How do I give them access without letting everyone change everything?" Maria asks.

"Vercel has robust team features," Marco explains. "You can set roles, control access to projects, and manage who can deploy to production."

**Time Allotment**: 45 minutes

**Topics Covered**:

- Vercel team accounts
- Member roles and permissions
- Project access control
- Git integration with teams
- Deployment protection
- Audit logs and compliance

---

## Vercel Team Accounts

### Personal vs Team Accounts

| Feature        | Personal (Hobby) | Team (Pro/Enterprise) |
| -------------- | ---------------- | --------------------- |
| Members        | 1                | Unlimited             |
| Projects       | Unlimited        | Unlimited             |
| Roles          | N/A              | Multiple              |
| SSO            | No               | Enterprise            |
| Audit Logs     | No               | Yes                   |
| Access Control | Basic            | Advanced              |

### Creating a Team

1. Go to Vercel Dashboard
2. Click your avatar → Create Team
3. Enter team name and URL slug
4. Invite members

---

## Member Roles

Vercel provides granular role-based access control:

### Available Roles

| Role          | Description                           |
| ------------- | ------------------------------------- |
| **Owner**     | Full access, billing, team settings   |
| **Member**    | Deploy, manage projects               |
| **Developer** | Deploy to preview, limited production |
| **Viewer**    | Read-only access                      |
| **Billing**   | Manage billing only                   |

### Role Permissions Matrix

| Permission        | Owner | Member | Developer | Viewer |
| ----------------- | ----- | ------ | --------- | ------ |
| View projects     | ✅    | ✅     | ✅        | ✅     |
| View deployments  | ✅    | ✅     | ✅        | ✅     |
| Deploy preview    | ✅    | ✅     | ✅        | ❌     |
| Deploy production | ✅    | ✅     | ❌\*      | ❌     |
| Manage settings   | ✅    | ✅     | ❌        | ❌     |
| Delete projects   | ✅    | ✅     | ❌        | ❌     |
| Invite members    | ✅    | ❌     | ❌        | ❌     |
| Manage billing    | ✅    | ❌     | ❌        | ❌     |

\*Developers can be granted production access per project

---

## Inviting Team Members

### Via Dashboard

1. Team Settings → Members
2. Click "Invite Member"
3. Enter email address
4. Select role
5. Optionally limit to specific projects

### Via CLI

```bash
vercel team invite email@example.com --role developer
```

### Invitation Options

- **Team-wide**: Access to all projects
- **Project-specific**: Limited to selected projects only

---

## Project Access Control

### Project-Level Permissions

Control who can access specific projects:

1. Project Settings → Members
2. Add team members or groups
3. Set project-specific role

### Access Scopes

```
Team Level:
└── Owner
└── Member (all projects)
└── Viewer (all projects)

Project Level:
└── Project-specific Member
└── Project-specific Developer
└── Project-specific Viewer
```

---

## Deployment Protection

### Production Branch Protection

Prevent accidental production deployments:

1. Project Settings → Git
2. Set Production Branch (e.g., `main`)
3. Enable branch protection

### Deployment Approval

Require approval before production deployments:

1. Project Settings → Deployment Protection
2. Enable "Require Approval"
3. Select approvers

### Preview Deployment Protection

Protect preview deployments with authentication:

```
Options:
- Vercel Authentication (team members only)
- Password Protection
- Trusted IPs
```

---

## Git Integration

### GitHub Team Sync

Connect Vercel team with GitHub organization:

1. Team Settings → Git Integration
2. Connect GitHub
3. Grant organization access

### GitLab/Bitbucket Integration

Similar flow for GitLab and Bitbucket:

1. Team Settings → Git Integration
2. Choose provider
3. Authorize and connect

### Automatic Team Member Sync

When enabled:

- GitHub org members → Vercel team members
- Permissions sync automatically

---

## Workflow Best Practices

### Git Branch Strategy

```
main (production)
  └── develop (staging)
       └── feature/* (preview)
       └── fix/* (preview)
```

### Vercel Environment Mapping

| Branch      | Environment | URL                        |
| ----------- | ----------- | -------------------------- |
| `main`      | Production  | app.example.com            |
| `develop`   | Preview     | develop.app.example.com    |
| `feature/*` | Preview     | feature-\*.app.example.com |

### Protected Branches

Configure in GitHub/GitLab:

- Require PR reviews
- Require status checks
- Restrict who can push

---

## Code Review Integration

### Vercel + GitHub PR Workflow

1. Developer pushes branch
2. Opens Pull Request
3. Vercel creates preview deployment
4. Preview URL added to PR
5. Team reviews code AND preview
6. Merge triggers production deployment

### Comment Commands

Vercel bot responds to PR comments:

- `vercel deploy` - Trigger new deployment
- Preview URL provided automatically

---

## Audit Logs

### What's Logged

| Event           | Details                      |
| --------------- | ---------------------------- |
| Deployments     | Who deployed, when, what     |
| Member changes  | Added, removed, role changes |
| Project changes | Settings, domains, env vars  |
| Team settings   | Billing, integrations        |

### Accessing Audit Logs

1. Team Settings → Audit Log
2. Filter by date, user, action
3. Export for compliance

### Example Log Entry

```json
{
  "action": "deployment.created",
  "user": "maria@barangay.gov.ph",
  "project": "barangay-dashboard",
  "timestamp": "2026-01-15T08:30:00Z",
  "details": {
    "branch": "main",
    "commit": "abc123",
    "environment": "production"
  }
}
```

---

## Single Sign-On (SSO)

Enterprise feature for centralized authentication:

### SAML SSO

1. Team Settings → Security → SAML SSO
2. Configure with your IdP (Okta, Azure AD, etc.)
3. Enable enforcement

### Supported Providers

- Okta
- Azure AD
- Google Workspace
- OneLogin
- Generic SAML 2.0

---

## Team Settings

### General Settings

- Team name and URL
- Default project region
- Build cache settings

### Security Settings

- SSO configuration
- IP allowlist
- Session timeout
- 2FA enforcement

### Notifications

Configure team notifications:

- Deployment success/failure
- Domain changes
- Security alerts

---

## Cost Management

### Team Billing

- Centralized billing for all members
- Usage-based pricing
- Per-member costs (Pro plan)

### Spending Limits

Set limits to prevent unexpected charges:

1. Team Settings → Billing
2. Set spending limits
3. Configure alerts

---

## Maria's Team Setup

Maria configures her team:

```
Team: Barangay Tech Platform

Members:
├── Maria (Owner)
│   └── Full access to all projects
├── Juan (Member)
│   └── dashboard, admin, api projects
├── Ana (Developer)
│   └── dashboard project only
│   └── Preview deployments only
└── Pedro (Viewer)
    └── Read-only access
```

Project-specific roles:

| Project   | Maria | Juan   | Ana       | Pedro  |
| --------- | ----- | ------ | --------- | ------ |
| dashboard | Owner | Member | Developer | Viewer |
| admin     | Owner | Member | -         | Viewer |
| api       | Owner | Member | -         | -      |

---

## Key Takeaways

✓ Use team accounts for collaborative projects
✓ Assign roles based on responsibility level
✓ Control project access at team and project level
✓ Enable deployment protection for production
✓ Integrate with GitHub/GitLab for seamless workflow
✓ Use audit logs for compliance and security

**Next Lesson:** Deployment Protection—passwords, authentication, and trusted IPs!
