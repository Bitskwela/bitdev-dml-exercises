# Deployment Activity

Maria stared at her laptop screen, the barangay dashboard she'd been building for weeks finally complete. "It looks amazing on my computer," she told Marco, "but how do I share it with the barangay officials? I can't just carry my laptop to every meeting!"

Marco grinned. "That's exactly why we need to learn about deployment. Time to put your project on the internet, Maria!"

---

## Task for Students

### Part 1: Knowledge Check

Answer the following questions to test your understanding of web deployment basics.

**Question 1: What is Deployment?**

Which of the following best describes web deployment?

- [ ] A) Copying files to a USB drive
- [ ] B) Making your website accessible on the internet through a hosting server
- [ ] C) Sending your code via email to users
- [ ] D) Installing software on your local computer

---

**Question 2: How DNS Works**

Maria types `barangay-dashboard.vercel.app` in her browser. What happens behind the scenes?

Fill in the blanks:

1. The browser asks a \***\*\_\_\*\*** server to translate the domain name into an IP address.
2. The DNS server responds with the \***\*\_\_\*\*** address (like 76.76.21.21).
3. The browser then connects to that address to load the \***\*\_\_\*\***.

---

**Question 3: Vercel vs Traditional Hosting**

Match each benefit with Vercel (V) or Traditional Hosting (T):

| Benefit                                | V or T |
| -------------------------------------- | ------ |
| Automatic HTTPS/SSL certificates       | \_\_\_ |
| Requires manual server configuration   | \_\_\_ |
| Free tier with generous limits         | \_\_\_ |
| Need to manage server updates yourself | \_\_\_ |
| Automatic deployments from Git         | \_\_\_ |

---

**Question 4: Free Tier Awareness**

Which of the following are TRUE about Vercel's free (Hobby) tier? Select all that apply.

- [ ] A) You can deploy unlimited personal projects
- [ ] B) Custom domains are supported
- [ ] C) You can use it for commercial client projects
- [ ] D) Bandwidth is limited to 100GB per month
- [ ] E) Serverless functions have execution time limits

---

**Question 5: Scenario Question**

The barangay captain asks Maria: "Why should we use Vercel instead of just renting a traditional web server?"

Write 2-3 sentences explaining the benefits Maria should mention.

_Your answer:_

---

---

---

---

### Part 2: Hands-On Setup

Follow these steps to set up your Vercel account and prepare for deployment.

#### Step 1: Create a Vercel Account

1. Open your browser and go to [vercel.com](https://vercel.com)
2. Click **"Sign Up"**
3. Choose **"Continue with GitHub"** (recommended) or use your email
4. If using GitHub, authorize Vercel to access your repositories
5. Complete your profile setup

**Checkpoint:** You should see the Vercel dashboard with "No projects yet"

---

#### Step 2: Install Vercel CLI

Open your terminal and run:

```bash
npm install -g vercel
```

Verify the installation:

```bash
vercel --version
```

**Expected output:** Something like `Vercel CLI 33.x.x`

---

#### Step 3: Login via CLI

In your terminal, run:

```bash
vercel login
```

Choose the same login method you used for your account (GitHub, email, etc.).

**Checkpoint:** You should see `Success! You are now logged in.`

---

#### Step 4: Verify Your Setup

Run this command to confirm everything is connected:

```bash
vercel whoami
```

**Expected output:** Your Vercel username or email

---

### Submission Checklist

Before moving on, confirm you've completed:

- [ ] Created a Vercel account
- [ ] Installed Vercel CLI globally
- [ ] Successfully logged in via terminal
- [ ] Verified with `vercel whoami`

Take a screenshot of your terminal showing the `vercel whoami` output.

---

## What You Learned

- **Deployment** means making your website accessible on the internet through a hosting server
- **DNS** translates human-readable domain names into IP addresses that computers understand
- **Vercel** offers automatic HTTPS, Git integration, and a generous free tier—perfect for learning and personal projects
- The **Vercel CLI** lets you deploy directly from your terminal
- Free tier has limits on bandwidth and serverless function execution time, but is excellent for personal and learning projects

---

## Answers (For Instructors)

**Q1:** B  
**Q2:** 1. DNS, 2. IP, 3. website  
**Q3:** V, T, V, T, V  
**Q4:** A, B, D, E (C is false—commercial use requires a Pro plan)  
**Q5:** Sample answer: "Vercel handles all the server management automatically, so we don't need to hire someone to maintain it. It's free for our use case, gives us automatic security with HTTPS, and updates instantly whenever we push changes to GitHub."
