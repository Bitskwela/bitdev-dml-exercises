# First Deployment Activity

Marco clapped his hands together. "Okay Maria, theory time is over. Let's get your barangay dashboard online for real!"

Maria cracked her knuckles dramatically. "I've been waiting for this. Let's do it!"

"I'll give you a simple challenge first," Marco said. "Create a basic page, deploy it, and send me the live link. If I can see it from my phone, you pass."

---

## Task for Students

In this activity, you will deploy your first static website to the internet using Vercel. By the end, you'll have a live URL you can share with anyone.

---

### Part 1: Create Your Static Site

Create a new folder called `my-first-deploy` and add an `index.html` file with the following content:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My First Deployment</title>
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }
      body {
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 20px;
      }
      .card {
        background: white;
        border-radius: 20px;
        padding: 40px;
        max-width: 500px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        text-align: center;
      }
      h1 {
        color: #333;
        margin-bottom: 10px;
      }
      .subtitle {
        color: #666;
        margin-bottom: 20px;
      }
      .status {
        background: #10b981;
        color: white;
        padding: 10px 20px;
        border-radius: 50px;
        display: inline-block;
        font-weight: bold;
      }
      .info {
        margin-top: 30px;
        padding: 20px;
        background: #f3f4f6;
        border-radius: 10px;
        text-align: left;
      }
      .info p {
        margin: 5px 0;
        color: #555;
      }
      .info strong {
        color: #333;
      }
    </style>
  </head>
  <body>
    <div class="card">
      <h1>🚀 Hello, Internet!</h1>
      <p class="subtitle">My first Vercel deployment</p>
      <span class="status">✓ Successfully Deployed</span>

      <div class="info">
        <p><strong>Deployed by:</strong> [Your Name]</p>
        <p><strong>Date:</strong> <span id="date"></span></p>
        <p><strong>Project:</strong> Learning Vercel Deployment</p>
      </div>
    </div>

    <script>
      document.getElementById("date").textContent =
        new Date().toLocaleDateString("en-PH", {
          weekday: "long",
          year: "numeric",
          month: "long",
          day: "numeric",
        });
    </script>
  </body>
</html>
```

**Your Task:** Replace `[Your Name]` with your actual name before deploying!

---

### Part 2: Deploy Your Site

Choose ONE of the following methods:

#### Option A: Vercel Dashboard (Visual Method)

1. Go to [vercel.com/new](https://vercel.com/new)
2. Find the upload/import area
3. Drag your `my-first-deploy` folder and drop it
4. Wait for the deployment to complete
5. Click the generated URL to view your site

#### Option B: Vercel CLI (Terminal Method)

1. Open your terminal
2. Navigate to your project folder:
   ```bash
   cd path/to/my-first-deploy
   ```
3. Run the deployment command:
   ```bash
   vercel
   ```
4. Answer the prompts:
   - Set up and deploy? **Y**
   - Which scope? **[Your username]**
   - Link to existing project? **N**
   - Project name? **my-first-deploy**
   - Directory? **./**
   - Modify settings? **N**
5. Wait for deployment to complete
6. Copy the Production URL

---

### Part 3: Verify Your Deployment

Complete the following verification checklist:

#### Verification Task 1: Desktop Check

- [ ] Open the URL in your computer's browser
- [ ] Confirm your name appears on the page
- [ ] Confirm the date displays correctly

#### Verification Task 2: Mobile Check

- [ ] Open the URL on your phone (or use browser dev tools mobile view)
- [ ] Confirm the page displays properly on mobile

#### Verification Task 3: Incognito Check

- [ ] Open the URL in an incognito/private browser window
- [ ] This confirms the site is truly public, not just cached

---

### Part 4: Share Your Deployment

Maria sent her link to the barangay group chat and received instant feedback. Now it's your turn!

**Sharing Concept Questions:**

1. **Who can access your deployed URL?**

   - [ ] A) Only you
   - [ ] B) Only people on your WiFi network
   - [ ] C) Anyone with internet access worldwide
   - [ ] D) Only Vercel employees

2. **What information does your URL reveal?**

   - [ ] A) Your home address
   - [ ] B) Your Vercel username and project name
   - [ ] C) Your computer password
   - [ ] D) Your bank account

3. **If you want to share your portfolio with a potential employer in another country, what do you send them?**

   _Your answer:_ **********************\_\_\_**********************

---

### Part 5: Reflection Questions

Answer the following questions based on your experience:

1. **Which deployment method did you use (Dashboard or CLI)? Why did you choose it?**

   ***

   ***

2. **How long did the entire deployment process take (from running the command to seeing your live site)?**

   ***

3. **What was the most surprising thing about seeing your site live on the internet?**

   ***

   ***

4. **Maria wants to update her page with new information. What command would she run to redeploy quickly?**

   ***

---

## Submission Checklist

Before marking this activity complete, ensure you have:

- [ ] Created the `index.html` file with your name
- [ ] Successfully deployed to Vercel
- [ ] Verified the site works on desktop
- [ ] Verified the site works on mobile
- [ ] Tested in incognito mode
- [ ] Answered all verification and reflection questions
- [ ] **Copied your live URL:** **********************\_\_\_**********************

---

## What You Learned

- **Creating a static site** is as simple as making an HTML file in a folder
- **Deployment to Vercel** can be done in under 2 minutes via dashboard or CLI
- **Live URLs** are immediately accessible worldwide after deployment
- **Verification** on multiple devices ensures your site works for all users
- **Sharing** is as simple as sending a link—no special software needed for viewers

---

## Challenge Extension (Optional)

If you finish early, try these bonus challenges:

### Bonus 1: Add More Pages

Create an `about.html` file and link to it from your index. Redeploy and verify both pages work.

### Bonus 2: Check Your Deployment History

Run `vercel ls` in your terminal to see all your deployments.

### Bonus 3: View Build Logs

Go to your Vercel dashboard, click on your project, and explore the "Deployments" tab. Read through a build log.

---

## Answers (For Instructors)

**Part 4 Sharing Questions:**

- Q1: C (Anyone with internet access worldwide)
- Q2: B (Your Vercel username and project name)
- Q3: The Vercel URL (e.g., `https://my-first-deploy.vercel.app`)

**Part 5 Q4:** `vercel --prod` or just `vercel` and follow prompts

---

## Maria's Success

Later that day, Marco received a message from Maria with a link. He clicked it on his phone while waiting for a jeepney.

"Galing!" he replied. "Your first deployment is live. How does it feel?"

Maria responded with a string of celebration emojis. "Parang may superpower ako ngayon. Anything I build, I can share with the world!"

Marco smiled at his phone. Maria was ready for bigger challenges ahead.
