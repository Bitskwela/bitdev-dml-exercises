# Le 01: Welcome to Vercel – Introduction to Deployment

![Vercel Deployment](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_11/vercel-welcome.png)

## Background Story

Maria stands in front of her laptop, beaming. The Barangay Blockchain voting dashboard is complete. Beautiful UI. Smooth interactions. Clean code.

"It's perfect," she tells Marco. "Want to see it?"

Marco leans in. Maria types `http://localhost:3000` into the browser. The dashboard loads.

"Looks amazing," Marco says. "Send me the link. I want to show Neri."

Maria's smile fades. "The link? It's... localhost."

"Which means?"

"Which means... it only works on my laptop."

This is the gap between _building_ software and _shipping_ software. Millions of developers build incredible applications that never leave their machines. They never learn to deploy.

Today, Maria learns to cross that gap. Today, she sails beyond the islands.

**Time Allotment**: 45 minutes

**Topics Covered**:

- What is deployment?
- How the internet works (basics)
- What is Vercel?
- Creating a Vercel account
- The deployment workflow

---

## What is Deployment?

**Deployment** is the process of making your application accessible to users over the internet.

When you run `npm start` or `python manage.py runserver`, you're running a **local development server**. It:

- Only works on your computer
- Stops when you close the terminal
- Can't be accessed by anyone else

When you **deploy**, you:

- Upload your code to a server
- That server runs 24/7
- Anyone with the URL can access it

```
Local Development:
Your Computer → localhost:3000 → Only You

Deployed Application:
Cloud Server → yourapp.vercel.app → The Entire World
```

## How the Internet Works (Simplified)

When someone visits `barangay-dashboard.vercel.app`:

1. **Browser** asks DNS: "Where is barangay-dashboard.vercel.app?"
2. **DNS** responds: "It's at IP address 76.76.21.21"
3. **Browser** connects to that IP address
4. **Vercel's server** receives the request
5. **Server** sends back your HTML, CSS, JavaScript
6. **Browser** renders your application

Your code needs to be on a server that's:

- Always running (24/7)
- Connected to the internet
- Fast and reliable

## Traditional Deployment Pain

In the past, deployment meant:

```
❌ Renting a physical server ($100+/month)
❌ Installing Linux, configuring Apache/Nginx
❌ Setting up SSL certificates
❌ Managing security patches
❌ Handling traffic spikes manually
❌ Debugging server crashes at 3 AM
```

This is why many developers never deployed. It was hard.

## Enter Vercel

Vercel is a **deployment platform** that makes shipping applications easy:

```
✅ Free tier for most projects
✅ Deploy with a single command or git push
✅ Automatic HTTPS/SSL
✅ Global CDN (Content Delivery Network)
✅ Automatic scaling
✅ Zero server management
```

### The Vercel Workflow

```bash
# Traditional deployment
1. Buy server
2. Install OS
3. Configure web server
4. Upload files via FTP
5. Set up SSL
6. Monitor 24/7
# Total time: Days to weeks

# Vercel deployment
1. Connect GitHub repo
2. Push code
3. Done
# Total time: Minutes
```

## What is Serverless?

Vercel uses **serverless computing**. This doesn't mean "no servers"—it means you don't manage them.

| Traditional         | Serverless (Vercel)     |
| ------------------- | ----------------------- |
| You manage servers  | Vercel manages servers  |
| Pay for 24/7 uptime | Pay only when code runs |
| Scale manually      | Auto-scales             |
| You handle crashes  | Vercel handles crashes  |

Your code runs on Vercel's infrastructure. You focus on building; they focus on operations.

## Creating a Vercel Account

### Step 1: Sign Up

1. Go to [vercel.com](https://vercel.com)
2. Click "Sign Up"
3. Choose "Continue with GitHub" (recommended)
4. Authorize Vercel to access your GitHub

### Step 2: Explore the Dashboard

After signing up, you'll see:

- **Overview**: Your deployed projects
- **Projects**: List of applications
- **Integrations**: Connect databases, analytics, etc.
- **Settings**: Account configuration

### Step 3: Install Vercel CLI (Optional)

```bash
# Install globally
npm install -g vercel

# Verify installation
vercel --version

# Login to your account
vercel login
```

The CLI lets you deploy from your terminal without using the website.

## The Deployment Workflow

There are two main ways to deploy to Vercel:

### Method 1: Git Integration (Recommended)

```
1. Push code to GitHub
2. Vercel automatically detects the push
3. Vercel builds your project
4. Vercel deploys to a URL
5. You share the URL with the world
```

This is the workflow we'll use throughout this course.

### Method 2: CLI Deployment

```bash
# Navigate to your project
cd my-project

# Deploy with one command
vercel

# Output:
# Vercel CLI 28.0.0
# ? Set up and deploy? Yes
# ? Which scope? your-username
# ? Link to existing project? No
# ? What's your project's name? my-project
# 🔗 Linked to yourname/my-project
# 🔍 Inspect: https://vercel.com/yourname/my-project
# ✅ Production: https://my-project.vercel.app
```

That's it. Your application is now live.

## Your First Deployment Preview

Let's see what deployment looks like (we'll do this hands-on next lesson):

```bash
# Create a simple HTML file
mkdir my-first-deploy
cd my-first-deploy
echo '<h1>Hello from the Philippines!</h1>' > index.html

# Deploy with Vercel
vercel

# After a minute:
# ✅ https://my-first-deploy-abc123.vercel.app

# Anyone in the world can now visit that URL!
```

## Vercel's Global Network

When you deploy to Vercel, your application isn't on one server—it's replicated globally:

```
Your App on Vercel:
├── Singapore (Neri's visitors load fast)
├── Tokyo (Japanese tourists load fast)
├── San Francisco (US visitors load fast)
├── Frankfurt (European visitors load fast)
└── São Paulo (South American visitors load fast)
```

This is called a **CDN (Content Delivery Network)**. Users load your app from the server closest to them.

## Free Tier Generosity

Vercel's free tier includes:

| Feature              | Free Tier       |
| -------------------- | --------------- |
| Deployments          | Unlimited       |
| Bandwidth            | 100 GB/month    |
| Serverless Functions | 100 GB-hours    |
| Team Members         | 1               |
| Build Time           | 100 hours/month |

For learning and small projects, you'll likely never exceed these limits.

## Why Vercel for This Course?

We're using Vercel because:

1. **Free** - No credit card needed
2. **Fast** - Deploys in seconds
3. **Simple** - Minimal configuration
4. **Next.js** - Created by the same company
5. **Industry standard** - Used by major companies

By learning Vercel, you learn deployment patterns that transfer to AWS, Google Cloud, and other platforms.

## Why This Matters: Beyond the Islands

Maria's Barangay Blockchain dashboard sits on her laptop. Only she can see it.

After this course:

- Neri can access it from Barangay Hall
- Dev Sam can demo it to clients in Cebu
- London investors can evaluate it from the UK
- Singapore partners can integrate with their systems

Deployment transforms "my project" into "our product." It's the difference between a prototype and a production application.

## Key Takeaways

✓ Deployment makes your application accessible to the world
✓ Traditional deployment is complex; Vercel simplifies it
✓ Serverless means you don't manage infrastructure
✓ Vercel uses a global CDN for fast loading worldwide
✓ Free tier is generous for learning and small projects
✓ Git integration enables automatic deployments

**Next Lesson:** Deploying your first static site—HTML goes global!
