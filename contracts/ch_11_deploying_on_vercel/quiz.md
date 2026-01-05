# Chapter 11 Quiz: Deploying on Vercel

```js
[
  {
    id: 1,
    type: "MCQ",
    answer: "b",
    points: 1,
    choices: [
      { id: "a", text: "AWS Amplify" },
      { id: "b", text: "Vercel" },
      { id: "c", text: "Netlify" },
      { id: "d", text: "Firebase Hosting" },
    ],
    question:
      "Which platform is specifically optimized for deploying Next.js applications?",
  },
  {
    id: 2,
    type: "MCQ",
    answer: "c",
    points: 1,
    choices: [
      { id: "a", text: "FTP upload" },
      { id: "b", text: "Email transfer" },
      { id: "c", text: "Git repository connection" },
      { id: "d", text: "Manual deployment button" },
    ],
    question:
      "What is the recommended way to deploy a static site to Vercel for continuous updates?",
  },
  {
    id: 3,
    type: "MCQ",
    answer: "a",
    points: 1,
    choices: [
      { id: "a", text: "A unique URL for testing before production" },
      { id: "b", text: "A cached version of the site" },
      { id: "c", text: "A backup deployment" },
      { id: "d", text: "A staging environment only" },
    ],
    question: "What is a preview deployment in Vercel?",
  },
  {
    id: 4,
    type: "TF",
    answer: true,
    points: 1,
    question:
      "Vercel automatically creates a preview deployment for every pull request.",
  },
  {
    id: 5,
    type: "MCQ",
    answer: "b",
    points: 1,
    choices: [
      { id: "a", text: "vercel config" },
      { id: "b", text: "vercel.json" },
      { id: "c", text: "vercel-settings.json" },
      { id: "d", text: ".vercelrc" },
    ],
    question:
      "Which file is used to configure Vercel project settings and deployment options?",
  },
  {
    id: 6,
    type: "MCQ",
    answer: "d",
    points: 1,
    choices: [
      { id: "a", text: "Via email" },
      { id: "b", text: "Via file upload" },
      { id: "c", text: "Via deployment hook only" },
      { id: "d", text: "In Vercel Environment Variables settings" },
    ],
    question:
      "How do you securely add environment variables to your Vercel deployment?",
  },
  {
    id: 7,
    type: "TF",
    answer: false,
    points: 1,
    question:
      "Environment variables set in a .env file on your local machine are automatically available in production.",
  },
  {
    id: 8,
    type: "MCQ",
    answer: "c",
    points: 1,
    choices: [
      { id: "a", text: "Server-side rendering (SSR)" },
      { id: "b", text: "Static site generation (SSG)" },
      { id: "c", text: "Both SSR and SSG" },
      { id: "d", text: "Only static HTML" },
    ],
    question: "What rendering methods does Next.js support on Vercel?",
  },
  {
    id: 9,
    type: "MCQ",
    answer: "b",
    points: 1,
    choices: [
      { id: "a", text: "Serverless functions are stored on your computer" },
      {
        id: "b",
        text: "Serverless functions execute only when called and are billed per execution",
      },
      { id: "c", text: "Serverless functions require a dedicated server" },
      { id: "d", text: "Serverless functions cannot access databases" },
    ],
    question: "What is a key characteristic of serverless functions?",
  },
  {
    id: 10,
    type: "MCQ",
    answer: "a",
    points: 1,
    choices: [
      { id: "a", text: "api/" },
      { id: "b", text: "functions/" },
      { id: "c", text: "serverless/" },
      { id: "d", text: "endpoints/" },
    ],
    question: "In Next.js, what directory contains API route handlers?",
  },
  {
    id: 11,
    type: "TF",
    answer: true,
    points: 1,
    question:
      "Edge functions in Vercel execute at locations closest to your users for lower latency.",
  },
  {
    id: 12,
    type: "MCQ",
    answer: "d",
    points: 1,
    choices: [
      { id: "a", text: "Before the response is sent to the browser" },
      { id: "b", text: "After the page loads" },
      { id: "c", text: "Only for authentication" },
      { id: "d", text: "Before requests reach your application" },
    ],
    question: "When does Edge Middleware execute in Vercel?",
  },
  {
    id: 13,
    type: "MCQ",
    answer: "c",
    points: 1,
    choices: [
      { id: "a", text: "One time at deployment" },
      { id: "b", text: "Only when manually triggered" },
      { id: "c", text: "On a scheduled interval using cron expressions" },
      { id: "d", text: "Randomly throughout the day" },
    ],
    question: "How often do Vercel Cron Jobs execute?",
  },
  {
    id: 14,
    type: "TF",
    answer: false,
    points: 1,
    question:
      "Images in Next.js using the Image component are automatically optimized and delivered in modern formats.",
  },
  {
    id: 15,
    type: "MCQ",
    answer: "b",
    points: 1,
    choices: [
      { id: "a", text: "LCP" },
      { id: "b", text: "All Core Web Vitals" },
      { id: "c", text: "FCP only" },
      { id: "d", text: "CLS only" },
    ],
    question: "What does Vercel Speed Insights measure?",
  },
  {
    id: 16,
    type: "MCQ",
    answer: "a",
    points: 1,
    choices: [
      { id: "a", text: "< 2.5 seconds" },
      { id: "b", text: "< 5 seconds" },
      { id: "c", text: "< 10 seconds" },
      { id: "d", text: "< 20 seconds" },
    ],
    question: "What is the good threshold for Largest Contentful Paint (LCP)?",
  },
  {
    id: 17,
    type: "TF",
    answer: true,
    points: 1,
    question:
      "Vercel automatically provides SSL/TLS certificates for custom domains.",
  },
  {
    id: 18,
    type: "MCQ",
    answer: "d",
    points: 1,
    choices: [
      { id: "a", text: "In the database" },
      { id: "b", text: "In the source code" },
      { id: "c", text: "In a local file" },
      {
        id: "d",
        text: "In Vercel Project Settings under Environment Variables",
      },
    ],
    question:
      "Where should API keys and database passwords be stored for security?",
  },
  {
    id: 19,
    type: "MCQ",
    answer: "b",
    points: 1,
    choices: [
      { id: "a", text: "After the code is deployed to production" },
      { id: "b", text: "Before merging to the main branch" },
      { id: "c", text: "Only on Fridays" },
      { id: "d", text: "Never, it's optional" },
    ],
    question: "When should automated tests run in a CI/CD pipeline?",
  },
  {
    id: 20,
    type: "MCQ",
    answer: "c",
    points: 1,
    choices: [
      { id: "a", text: "Rebuild the entire application" },
      { id: "b", text: "Deploy a new version" },
      { id: "c", text: "Revert to a previous working deployment" },
      { id: "d", text: "Delete all files" },
    ],
    question: "What is a rollback in Vercel?",
  },
  {
    id: 21,
    type: "TF",
    answer: true,
    points: 1,
    question:
      "Vercel keeps all previous deployments available for instant rollback.",
  },
  {
    id: 22,
    type: "MCQ",
    answer: "a",
    points: 1,
    choices: [
      { id: "a", text: "X-Frame-Options, X-Content-Type-Options, CSP" },
      { id: "b", text: "Authorization, Authentication, Encryption" },
      { id: "c", text: "Cache-Control, Expires, ETag" },
      { id: "d", text: "Accept, Accept-Language, User-Agent" },
    ],
    question: "Which are examples of security headers in Vercel configuration?",
  },
  {
    id: 23,
    type: "MCQ",
    answer: "b",
    points: 1,
    choices: [
      { id: "a", text: "Rate limiting" },
      { id: "b", text: "Web Application Firewall (WAF)" },
      { id: "c", text: "DDoS protection" },
      { id: "d", text: "All of the above" },
    ],
    question: "What security features does Vercel's firewall provide?",
  },
  {
    id: 24,
    type: "TF",
    answer: false,
    points: 1,
    question:
      "Database connections should be made inside API routes without any optimization.",
  },
  {
    id: 25,
    type: "MCQ",
    answer: "c",
    points: 1,
    choices: [
      { id: "a", text: "Multiple deployments on the same server" },
      { id: "b", text: "A monolithic architecture" },
      { id: "c", text: "A single codebase with multiple related projects" },
      { id: "d", text: "Multiple git repositories" },
    ],
    question: "What is a monorepo in the context of Vercel deployments?",
  },
  {
    id: 26,
    type: "MCQ",
    answer: "a",
    points: 1,
    choices: [
      {
        id: "a",
        text: "Team members can deploy independently with proper permissions",
      },
      { id: "b", text: "Anyone can deploy without restrictions" },
      { id: "c", text: "Only one person can deploy at a time" },
      { id: "d", text: "Deployments are blocked for all team members" },
    ],
    question: "What does deployment protection allow in Vercel team settings?",
  },
  {
    id: 27,
    type: "TF",
    answer: true,
    points: 1,
    question:
      "Vercel Analytics provides insights into visitor traffic and geographic data.",
  },
  {
    id: 28,
    type: "MCQ",
    answer: "b",
    points: 1,
    choices: [
      { id: "a", text: "git push" },
      { id: "b", text: "vercel deploy --prod" },
      { id: "c", text: "npm deploy" },
      { id: "d", text: "vercel publish" },
    ],
    question: "What CLI command deploys a project to production in Vercel?",
  },
  {
    id: 29,
    type: "MCQ",
    answer: "d",
    points: 1,
    choices: [
      { id: "a", text: "package.json" },
      { id: "b", text: "build.json" },
      { id: "c", text: "deploy.json" },
      { id: "d", text: "vercel.json" },
    ],
    question:
      "Which configuration file defines custom build and output directories in Vercel?",
  },
  {
    id: 30,
    type: "TF",
    answer: false,
    points: 1,
    question:
      "Preview deployments use the same domain as your production deployment.",
  },
  {
    id: 31,
    type: "FIB",
    answer: "git",
    points: 1,
    question:
      "Vercel automatically deploys your application whenever you push to your ______ repository.",
  },
  {
    id: 32,
    type: "FIB",
    answer: "serverless",
    points: 1,
    question:
      "API routes in Next.js become ______ functions when deployed to Vercel.",
  },
  {
    id: 33,
    type: "FIB",
    answer: "edge",
    points: 1,
    question:
      "______ functions in Vercel execute at locations near your users for reduced latency.",
  },
  {
    id: 34,
    type: "FIB",
    answer: "Core Web Vitals",
    points: 1,
    question:
      "Speed Insights measures ______ including LCP, INP, and CLS metrics.",
  },
  {
    id: 35,
    type: "FIB",
    answer: "environment",
    points: 1,
    question:
      "API keys and secrets should be stored as ______ variables in Vercel, not in source code.",
  },
  {
    id: 36,
    type: "FIB",
    answer: "middleware",
    points: 1,
    question:
      "Edge ______ allows you to intercept and modify requests before they reach your application.",
  },
  {
    id: 37,
    type: "FIB",
    answer: "cron",
    points: 1,
    question:
      "A ______ job in Vercel runs serverless functions on a scheduled interval.",
  },
  {
    id: 38,
    type: "FIB",
    answer: "preview",
    points: 1,
    question:
      "Every pull request automatically gets a unique ______ deployment URL for testing.",
  },
  {
    id: 39,
    type: "FIB",
    answer: "WAF",
    points: 1,
    question:
      "Vercel's ______ (Web Application Firewall) protects against DDoS attacks and rate limits.",
  },
  {
    id: 40,
    type: "FIB",
    answer: "rollback",
    points: 1,
    question:
      "A ______ instantly reverts to a previous working deployment without rebuilding.",
  },
];
```
