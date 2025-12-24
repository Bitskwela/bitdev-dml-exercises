# Chapter 11: Deploying on Vercel – Global Deployment

## Setup & Prerequisites

Welcome to Chapter 11! Let's get your environment ready to deploy applications to the world.

---

## Prerequisites

### Required:

- **Node.js v14+** installed on your computer
- **A GitHub account** (free at https://github.com)
- **A Vercel account** (free at https://vercel.com)
- **A text editor** (VS Code, etc.)
- **Basic JavaScript knowledge** (from Ch 5)

### Highly Recommended:

- **Git installed** (from Ch 10)
- **Completion of Ch 5-6** (JavaScript fundamentals)
- **Completion of Ch 10** (Git workflows)

---

## Step 1: Install Node.js

Node.js is required for all lessons in this course.

### Windows & macOS

1. Visit https://nodejs.org
2. Download the LTS (Long Term Support) version
3. Run the installer
4. Accept defaults and complete

**macOS alternative (Homebrew)**:

```bash
brew install node
```

### Linux (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install nodejs npm
```

**Verify installation**:

```bash
node --version   # Should show v14.0.0 or higher
npm --version    # Should show 6.0.0 or higher
```

---

## Step 2: Create/Verify GitHub Account

You'll need GitHub to connect to Vercel for automatic deployments.

1. Go to https://github.com
2. Sign up or log in
3. Set up your profile
4. Generate personal access token (if needed for CLI):
   - Settings → Developer settings → Personal access tokens
   - Create token with `repo` and `public_repo` scopes

**Test GitHub**:

```bash
git --version
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

---

## Step 3: Create Vercel Account

1. Go to https://vercel.com
2. Click "Sign up"
3. Choose "Sign up with GitHub" (easiest option)
4. Authorize Vercel to access your GitHub account
5. Complete setup

**After signup**:

- You'll see the Vercel dashboard
- Ready to start deploying!

---

## Step 4: Install Vercel CLI (Optional but Helpful)

The Vercel CLI lets you deploy from your terminal.

```bash
npm install -g vercel
```

**Verify installation**:

```bash
vercel --version
```

**Login to Vercel CLI**:

```bash
vercel login
```

Follow prompts to authenticate with your Vercel account.

---

## Step 5: Create Your First Deployment

Let's verify everything works with a simple deployment.

### Option A: Deploy via GitHub

1. Create a repository on GitHub called `first-vercel-deploy`
2. Add an `index.html` file:
   ```html
   <!DOCTYPE html>
   <html>
     <head>
       <title>My First Deployment</title>
     </head>
     <body>
       <h1>Hello from Vercel! 🚀</h1>
       <p>This is deployed to the world.</p>
     </body>
   </html>
   ```
3. Push to GitHub
4. On Vercel dashboard, click "New Project"
5. Select your repository
6. Click "Deploy"
7. Wait 30 seconds, then click the URL!

### Option B: Deploy via CLI

```bash
# Create project folder
mkdir my-first-site
cd my-first-site

# Create index.html
echo '<h1>Hello from Vercel! 🚀</h1>' > index.html

# Deploy
vercel

# Follow prompts and get your live URL!
```

---

## Directory Structure (What You'll Create)

### Static Site

```
my-site/
├── index.html
├── style.css
└── script.js
```

### React App

```
my-react-app/
├── public/
├── src/
│   ├── App.js
│   └── index.js
├── package.json
└── README.md
```

### Next.js App

```
my-nextjs-app/
├── pages/
│   ├── index.js
│   └── api/
│       └── hello.js
├── public/
├── styles/
├── package.json
└── next.config.js
```

---

## Common Commands You'll Use

```bash
# Create new Next.js project
npx create-next-app@latest my-app
cd my-app

# Create React app
npx create-react-app my-app
cd my-app

# Install dependencies
npm install

# Run development server
npm run dev

# Build for production
npm run build

# Deploy with Vercel CLI
vercel

# Deploy and set production URL
vercel --prod
```

---

## Setting Environment Variables

For sensitive data (API keys, database URLs):

### Via Vercel Dashboard

1. Project → Settings → Environment Variables
2. Add variable name and value
3. Select which environments (development, preview, production)
4. Save

### Via `.env.local` file (local development only)

```
DATABASE_URL=postgresql://user:password@localhost/db
API_KEY=your-secret-key-here
```

**NEVER commit `.env.local` to Git!**

Add to `.gitignore`:

```
.env.local
.env.*.local
```

---

## Project Setup Checklist

Before each lesson, ensure:

- [ ] Node.js installed and working
- [ ] GitHub account and repository ready
- [ ] Vercel account connected to GitHub
- [ ] Vercel CLI installed (optional)
- [ ] `.gitignore` properly configured
- [ ] Environment variables set up

---

## Helpful Tips

### Terminal Basics

```bash
# Navigate to folder
cd my-project

# List files
ls

# Create folder
mkdir new-folder

# View file contents
cat filename.txt
```

### Debugging Deployments

If deployment fails:

1. Check Vercel dashboard for error message
2. Look at build logs (Deployments → click failed deployment → Logs)
3. Verify all environment variables are set
4. Ensure `package.json` has correct build scripts
5. Test locally first: `npm run dev`

### Common Errors

**"Cannot find module 'next'"**

- Run: `npm install`

**"Build failed with exit code 1"**

- Check build logs on Vercel dashboard
- Usually missing dependencies or syntax errors

**"Environment variable not found"**

- Add to Vercel dashboard Settings → Environment Variables
- Restart build

---

## Performance Tips

1. **Optimize images** - Use `next/image` component
2. **Code split** - Load only needed code
3. **Caching** - Set appropriate cache headers
4. **CDN** - Vercel uses global CDN automatically
5. **Monitor** - Check Vercel Analytics regularly

---

## Security Best Practices

1. **Never commit secrets** to Git
2. **Use environment variables** for sensitive data
3. **Add authentication** to admin endpoints
4. **Validate user input** on both frontend and backend
5. **Keep dependencies updated**: `npm audit fix`
6. **Use HTTPS** (Vercel does this automatically)

---

## Next Steps

After setup:

1. Read through Chapter 11 README
2. Go to `le_01_welcome_to_vercel/` for first lesson
3. Deploy something simple first
4. Gradually build more complex projects
5. Monitor your deployments
6. Share with the world!

---

## Resources

- **Vercel Docs**: https://vercel.com/docs
- **Next.js Docs**: https://nextjs.org/docs
- **Node.js Docs**: https://nodejs.org/docs
- **npm Packages**: https://www.npmjs.com
- **Web Vitals**: https://web.dev/vitals/

---

## You're Ready to Deploy!

✅ Node.js installed
✅ GitHub account ready
✅ Vercel account created
✅ First deployment successful

**Let's deploy amazing applications to the world!** 🌍

Head to `le_01_welcome_to_vercel/` to begin.

Happy deploying! 🚀
